import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/job_check_in/datasource/job_check_in_datasource.dart';
import 'package:ticket_com_vc_app/src/domain/remote/job_check_in/repository/job_check_in_repository.dart';

class JobCheckInRepositoryImpl implements JobCheckInRepository {
  JobCheckInRepositoryImpl(this.jobCheckInDatasource);

  final JobCheckInDatasource jobCheckInDatasource;

  @override
  Future<Either<Failure, void>> putJobCheckIn({
    required String deviceId,
    required String eventId,
  }) async {
    return await jobCheckInDatasource.putJobCheckIn(
      deviceId: deviceId,
      eventId: eventId,
    );
  }
}
