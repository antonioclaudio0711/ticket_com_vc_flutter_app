import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';

abstract class ParticipantCheckInDatasource {
  Future<Either<Failure, void>> putParticipantCheckIn({
    required String ticketCode,
    required String deviceId,
    required String eventId,
  });
}
