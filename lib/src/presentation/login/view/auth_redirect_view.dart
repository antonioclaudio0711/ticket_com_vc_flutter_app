import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

class AuthRedirectView extends StatefulWidget {
  const AuthRedirectView({super.key});

  static const routeName = AppRoutes.initialAppRoute;

  @override
  AuthRedirectViewState createState() => AuthRedirectViewState();
}

class AuthRedirectViewState extends State<AuthRedirectView> {
  @override
  void initState() {
    super.initState();
    _handleAuth();
  }

  Future<void> _handleAuth() async {
    final NavigationService navigationService = GetIt.I<NavigationService>();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = preferences.getString("access");
    String? refreshToken = preferences.getString("refresh");

    final result = accessToken != null && refreshToken != null;

    if (result) {
      navigationService.pushNamedAndRemoveUntil(AppRoutes.homeAppRoute);
    } else {
      navigationService.pushNamedAndRemoveUntil(AppRoutes.loginAppRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.blueColor,
        ),
      ),
    );
  }
}
