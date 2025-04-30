import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/login/datasource/login_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/login/model/login_model.dart';
import 'package:ticket_com_vc_app/src/domain/remote/login/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this.loginDatasource);

  final LoginDatasource loginDatasource;

  @override
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    return await loginDatasource.login(
      email: email,
      password: password,
    );
  }
}
