import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/model/list_of_participants_model.dart';

abstract class ListOfParticipantsDatasource {
  Future<Either<Failure, ListOfParticipantsModel>> fetchListOfParticipants({
    String? status,
    int? page = 1,
    required String eventId,
  });
}
