import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/datasource/event_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/datasource/event_datasource_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/repository/event_repository_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/job_check_in/datasource/job_check_in_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/job_check_in/datasource/job_check_in_datasource_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/job_check_in/repository/job_check_in_repository_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/datasource/list_of_participants_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/datasource/list_of_participants_datasource_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/repository/list_of_participants_repository_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/login/datasource/login_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/login/datasource/login_datasource_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/login/repository/login_repository_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/participant_check_in/datasource/participant_check_in_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/participant_check_in/datasource/participant_check_in_datasource_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/participant_check_in/repository/participant_check_in_repository_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/refresh_token/datasource/refresh_token_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/refresh_token/datasource/refresh_token_datasource_impl.dart';
import 'package:ticket_com_vc_app/src/data/remote/refresh_token/repository/refresh_token_repository_impl.dart';
import 'package:ticket_com_vc_app/src/domain/remote/event/repository/event_repository.dart';
import 'package:ticket_com_vc_app/src/domain/remote/job_check_in/repository/job_check_in_repository.dart';
import 'package:ticket_com_vc_app/src/domain/remote/list_of_participants/repository/list_of_participants_repository.dart';
import 'package:ticket_com_vc_app/src/domain/remote/login/repository/login_repository.dart';
import 'package:ticket_com_vc_app/src/domain/remote/participant_check_in/repository/participant_check_in_repository.dart';
import 'package:ticket_com_vc_app/src/domain/remote/refresh_token/repository/refresh_token_repository.dart';
import 'package:ticket_com_vc_app/src/service/http/client_interceptor.dart';
import 'package:ticket_com_vc_app/src/service/http/http_service.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // App Navigation
  sl.registerLazySingleton(
    () => NavigationService(),
  );

  // DIO
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();

    dio.interceptors.add(
      ClientInterceptor(dio),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  });
  sl.registerLazySingleton<IHttpService>(
    () => HttpService(sl()),
  );

  // Login Datasource
  sl.registerFactory<LoginDatasource>(
    () => LoginDatasourceImpl(sl()),
  );
  // Login Repository
  sl.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(sl()),
  );

  // RefreshToken Datasource
  sl.registerFactory<RefreshTokenDatasource>(
    () => RefreshTokenDatasourceImpl(sl()),
  );
  // RefreshToken Repository
  sl.registerFactory<RefreshTokenRepository>(
    () => RefreshTokenRepositoryImpl(sl()),
  );

  // Event Datasource
  sl.registerFactory<EventDatasource>(
    () => EventDatasourceImpl(sl()),
  );
  // Event Repository
  sl.registerFactory<EventRepository>(
    () => EventRepositoryImpl(sl()),
  );

  // JobCheckIn Datasource
  sl.registerFactory<JobCheckInDatasource>(
    () => JobCheckInDatasourceImpl(sl()),
  );
  // JobCheckIn Repository
  sl.registerFactory<JobCheckInRepository>(
    () => JobCheckInRepositoryImpl(sl()),
  );

  // ParticipantCheckIn Datasource
  sl.registerFactory<ParticipantCheckInDatasource>(
    () => ParticipantCheckInDatasourceImpl(sl()),
  );
  // ParticipantCheckIn Repository
  sl.registerFactory<ParticipantCheckInRepository>(
    () => ParticipantCheckInRepositoryImpl(sl()),
  );

  // ListOfParticipants Datasource
  sl.registerFactory<ListOfParticipantsDatasource>(
    () => ListOfParticipantsDatasourceImpl(sl()),
  );
  // ListOfParticipants Repository
  sl.registerFactory<ListOfParticipantsRepository>(
    () => ListOfParticipantsRepositoryImpl(sl()),
  );
}
