import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/participant_check_in/datasource/participant_check_in_datasource.dart';
import 'package:ticket_com_vc_app/src/domain/remote/participant_check_in/repository/participant_check_in_repository.dart';

class ParticipantCheckInRepositoryImpl implements ParticipantCheckInRepository {
  ParticipantCheckInRepositoryImpl(this.participantCheckInDatasource);

  final ParticipantCheckInDatasource participantCheckInDatasource;

  @override
  Future<Either<Failure, void>> putParticipantCheckIn({
    required String ticketCode,
    required String deviceId,
    required String eventId,
  }) async {
    return await participantCheckInDatasource.putParticipantCheckIn(
      ticketCode: ticketCode,
      deviceId: deviceId,
      eventId: eventId,
    );
  }
}
