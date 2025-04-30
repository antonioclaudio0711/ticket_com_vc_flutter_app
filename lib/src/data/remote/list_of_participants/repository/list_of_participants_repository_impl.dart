import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/datasource/list_of_participants_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/model/list_of_participants_model.dart';
import 'package:ticket_com_vc_app/src/domain/remote/list_of_participants/repository/list_of_participants_repository.dart';

class ListOfParticipantsRepositoryImpl implements ListOfParticipantsRepository {
  ListOfParticipantsRepositoryImpl(this.listOfParticipantsDatasource);

  final ListOfParticipantsDatasource listOfParticipantsDatasource;

  @override
  Future<Either<Failure, ListOfParticipantsModel>> fetchListOfParticipants({
    String? status,
    int? page = 1,
    required String eventId,
  }) async {
    return await listOfParticipantsDatasource.fetchListOfParticipants(
      status: status,
      page: page,
      eventId: eventId,
    );
  }
}
