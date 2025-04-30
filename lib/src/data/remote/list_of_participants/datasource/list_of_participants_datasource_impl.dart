import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/datasource/list_of_participants_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/model/list_of_participants_model.dart';
import 'package:ticket_com_vc_app/src/service/http/http_service.dart';

class ListOfParticipantsDatasourceImpl implements ListOfParticipantsDatasource {
  ListOfParticipantsDatasourceImpl(this.httpService);

  final IHttpService httpService;

  @override
  Future<Either<Failure, ListOfParticipantsModel>> fetchListOfParticipants({
    String? status,
    int? page = 1,
    required String eventId,
  }) async {
    String requestUrl = status == null
        ? "/api/events/jobs/my-events/$eventId/tickets/?page=$page"
        : "/api/events/jobs/my-events/$eventId/tickets/?page=$page&status=$status";

    try {
      final response = await httpService.get(requestUrl);

      final Map<String, dynamic> jsonResponse = response.data;
      final ListOfParticipantsModel listOfParticipantsModel =
          ListOfParticipantsModel.fromJson(jsonResponse);

      return Right(listOfParticipantsModel);
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
