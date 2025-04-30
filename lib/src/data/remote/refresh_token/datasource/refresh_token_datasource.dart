import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';

abstract class RefreshTokenDatasource {
  Future<Either<Failure, void>> refreshToken({
    required String refreshToken,
  });
}
