import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/login/model/login_model.dart';

abstract class LoginDatasource {
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  });
}
