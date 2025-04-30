import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/data/remote/login/datasource/login_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/login/model/login_model.dart';
import 'package:ticket_com_vc_app/src/service/http/http_service.dart';

class LoginDatasourceImpl implements LoginDatasource {
  LoginDatasourceImpl(this.httpClient);

  final IHttpService httpClient;

  @override
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await httpClient.post(
        "/api/accounts/users/app/login/",
        {
          "email": email,
          "password": password,
        },
      );

      final Map<String, dynamic> jsonResponse = response.data;
      final LoginModel loginModel = LoginModel.fromJson(jsonResponse);

      return Right(loginModel);
    } on DioException catch (err) {
      if (err.response?.statusCode == 422) {
        return Left(
          HttpRequestException(
              titleError: AppStrings.errorGenericTitleString,
              descriptionError: AppStrings.invalidEmailOrPasswordString),
        );
      } else if (err.type == DioExceptionType.connectionError ||
          err.type == DioExceptionType.connectionTimeout) {
        return Left(
          HttpRequestException(
            titleError: AppStrings.errorGenericTitleString,
            descriptionError: AppStrings.errorInternetFailedString,
          ),
        );
      } else {
        return Left(
          HttpRequestException(
            titleError: AppStrings.errorGenericTitleString,
            descriptionError: AppStrings.loginErrorString,
          ),
        );
      }
    } catch (error) {
      return Left(
        UnknownException(
          titleError: AppStrings.errorGenericTitleString,
          descriptionError:
              '${AppStrings.errorSomethingWrongString} ${error.toString()}',
        ),
      );
    }
  }
}
