import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_assets.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/presentation/login/controller/login_controller.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/gradient_text.dart';
import 'package:ticket_com_vc_app/src/presentation/login/view/widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = AppRoutes.loginAppRoute;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 110, bottom: 56),
                  child: Image.asset(
                    AppAssets.ticketComVcVerticalLogoAsset,
                  ),
                ),
                GradientText(
                  text: AppStrings.doLoginString,
                  gradient: LinearGradient(
                    colors: AppColors.purpleLinearGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                LoginForm(
                  formKey: _formKey,
                  loginController: _loginController,
                  loginOnPressedFunction: () async {
                    if (_formKey.currentState!.validate()) {
                      await _loginController.login(
                        email: _loginController.emailTextEditingController.text,
                        password:
                            _loginController.passwordTextEditingController.text,
                        context: context,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
