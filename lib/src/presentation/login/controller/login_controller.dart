import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/domain/remote/login/repository/login_repository.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

class LoginController extends ChangeNotifier {
  LoginController();

  final NavigationService navigationService = GetIt.I<NavigationService>();
  final LoginRepository _loginRepository = GetIt.I<LoginRepository>();

  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  ValueNotifier<bool> isObscureText = ValueNotifier(true);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  void resetAllValues() {
    passwordTextEditingController.clear();
    emailTextEditingController.clear();

    isObscureText.value = true;
  }

  void changeTextVisibility() => isObscureText.value = !isObscureText.value;

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.pleaseInsertYourEmailString;
    } else if (!email.contains("@") || email.length < 8) {
      return AppStrings.pleaseInsertAValidEmailString;
    } else {
      return null;
    }
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.pleaseInsertYourPasswordString;
    } else if (password.length < 8) {
      return AppStrings.pleaseInsertAValidPasswordString;
    } else {
      return null;
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;

    final response = await _loginRepository.login(
      email: email,
      password: password,
    );

    response.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(
              error.description,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
      (success) async {
        if (!success.isStaff) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text(
                AppStrings.userCantAccessAppString,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          navigationService.pushNamedAndRemoveUntil(
            AppRoutes.homeAppRoute,
          );

          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          preferences.setString("refresh", success.refreshToken);
          preferences.setString("access", success.accessToken);
        }
      },
    );

    resetAllValues();
    isLoading.value = false;
  }
}
