import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_constants.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/domain/remote/refresh_token/repository/refresh_token_repository.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';
import 'package:uuid/uuid.dart';

class ClientInterceptor extends Interceptor {
  ClientInterceptor(this.dio);

  final Dio dio;
  bool isSessionExpiredHandled = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = preferences.getString("access");

    options.baseUrl = AppConstants.PRODUCTION_BASE_URL;

    options.followRedirects = false;
    options.headers.addAll({
      "Content-Type": "application/json",
      "Device": Platform.isAndroid ? "ANDROID" : "IOS",
      "client-key": AppConstants.CLIENT_KEY,
      "client-secret": AppConstants.CLIENT_SECRET,
      "x-csrf-token": Uuid().v4(),
    });

    bool isLoginPath = options.path.contains("/api/accounts/users/app/login/");

    if (!isLoginPath && accessToken != null) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }

    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    bool isRefreshTokenPath =
        err.requestOptions.path.contains("api/accounts/token/refresh/");

    if (isRefreshTokenPath) {
      if (!isSessionExpiredHandled) {
        isSessionExpiredHandled = true;
        show401Dialog();

        return;
      }
    } else if (err.response?.statusCode == 401 && !isRefreshTokenPath) {
      final RefreshTokenRepository refreshTokenRepository =
          GetIt.I<RefreshTokenRepository>();
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String? refreshToken = preferences.getString("refresh");

      if (refreshToken != null) {
        final response = await refreshTokenRepository.refreshToken(
          refreshToken: refreshToken,
        );

        response.fold(
          (error) {},
          (success) async {
            String? accessToken = preferences.getString("access");

            final RequestOptions requestOptions = err.requestOptions;
            requestOptions.headers["Authorization"] = "Bearer $accessToken";

            try {
              final response = await dio.fetch(requestOptions);

              return handler.resolve(response);
            } catch (error) {
              return handler.next(err);
            }
          },
        );
      } else {
        if (!isSessionExpiredHandled) {
          isSessionExpiredHandled = true;
          show401Dialog();

          return;
        }
      }
    } else {
      return handler.next(err);
    }
  }

  void show401Dialog() async {
    final NavigationService navigationService = GetIt.I<NavigationService>();
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await showDialog(
      context: navigationService.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(AppStrings.expiredSessionString),
          content: Text(AppStrings.expiredCredentialsString),
          actions: [
            TextButton(
              onPressed: () async {
                isSessionExpiredHandled = false;
                await preferences.remove("access");
                await preferences.remove("refresh");

                navigationService
                    .pushNamedAndRemoveUntil(AppRoutes.initialAppRoute);
              },
              child: Text(AppStrings.turnToLoginScreenString),
            ),
          ],
        ),
      ),
    );
  }
}
