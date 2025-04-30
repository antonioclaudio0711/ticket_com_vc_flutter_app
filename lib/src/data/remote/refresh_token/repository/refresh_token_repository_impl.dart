import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/refresh_token/datasource/refresh_token_datasource.dart';
import 'package:ticket_com_vc_app/src/domain/remote/refresh_token/repository/refresh_token_repository.dart';

class RefreshTokenRepositoryImpl implements RefreshTokenRepository {
  RefreshTokenRepositoryImpl(this.refreshTokenDatasource);

  final RefreshTokenDatasource refreshTokenDatasource;

  @override
  Future<Either<Failure, void>> refreshToken({
    required String refreshToken,
  }) async {
    return await refreshTokenDatasource.refreshToken(
      refreshToken: refreshToken,
    );
  }
}
