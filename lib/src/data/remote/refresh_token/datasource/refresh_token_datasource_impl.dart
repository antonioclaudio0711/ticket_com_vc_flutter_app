import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/data/remote/refresh_token/datasource/refresh_token_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/refresh_token/model/refresh_token_model.dart';
import 'package:ticket_com_vc_app/src/service/http/http_service.dart';

class RefreshTokenDatasourceImpl implements RefreshTokenDatasource {
  RefreshTokenDatasourceImpl(this.httpService);

  final IHttpService httpService;

  @override
  Future<Either<Failure, void>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await httpService.post(
        "api/accounts/token/refresh/",
        {
          "refresh": refreshToken,
        },
      );

      final Map<String, dynamic> jsonResponse = response.data;
      final RefreshTokenModel loginModel =
          RefreshTokenModel.fromJson(jsonResponse);

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString("access", loginModel.accessToken);
      preferences.setString("refresh", loginModel.refreshToken);

      return Right(null);
    } catch (e) {
      return Left(
        UnknownException(
          titleError: AppStrings.errorGenericTitleString,
          descriptionError: AppStrings.errorSomethingWrongString,
        ),
      );
    }
  }
}
