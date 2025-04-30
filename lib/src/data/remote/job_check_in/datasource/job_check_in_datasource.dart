import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';

abstract class JobCheckInDatasource {
  Future<Either<Failure, void>> putJobCheckIn({
    required String deviceId,
    required String eventId,
  });
}
