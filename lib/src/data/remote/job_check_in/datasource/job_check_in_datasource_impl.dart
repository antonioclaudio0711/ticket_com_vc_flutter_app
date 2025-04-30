import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/data/remote/job_check_in/datasource/job_check_in_datasource.dart';
import 'package:ticket_com_vc_app/src/service/http/http_service.dart';

class JobCheckInDatasourceImpl implements JobCheckInDatasource {
  JobCheckInDatasourceImpl(this.httpService);

  final IHttpService httpService;

  @override
  Future<Either<Failure, void>> putJobCheckIn({
    required String deviceId,
    required String eventId,
  }) async {
    try {
      await httpService.put(
        "api/events/jobs/my-events/$eventId/checkin/?per_page=0",
        {
          "device_id": deviceId,
        },
      );

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
