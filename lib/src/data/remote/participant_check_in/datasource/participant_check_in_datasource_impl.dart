import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/data/remote/participant_check_in/datasource/participant_check_in_datasource.dart';
import 'package:ticket_com_vc_app/src/service/http/http_service.dart';

class ParticipantCheckInDatasourceImpl implements ParticipantCheckInDatasource {
  ParticipantCheckInDatasourceImpl(this.httpService);

  final IHttpService httpService;

  @override
  Future<Either<Failure, void>> putParticipantCheckIn({
    required String ticketCode,
    required String deviceId,
    required String eventId,
  }) async {
    try {
      await httpService.put(
        "api/events/$eventId/ticket-checkin/",
        {
          "code": ticketCode,
          "device_id": deviceId,
        },
      );

      return Right(null);
    } on DioException catch (err) {
      if (err.response?.statusCode == 400) {
        List<dynamic> errorResponseData = err.response?.data;
        String errorMessage;

        switch (errorResponseData) {
          case ["Ticket not found"]:
            errorMessage = AppStrings.ticketCodeNotFoundString;
          case ["Ticket already used"]:
            errorMessage = AppStrings.ticketCodeHasAlreadyUsed;
          default:
            errorMessage = AppStrings.ticketCodeReaderErrorString;
        }
        return Left(
          HttpRequestException(
              titleError: AppStrings.errorGenericTitleString,
              descriptionError: errorMessage),
        );
      } else if (err.type == DioExceptionType.connectionError ||
          err.type == DioExceptionType.connectionTimeout) {
        return Left(
          HttpRequestException(
            titleError: AppStrings.errorGenericTitleString,
            descriptionError: AppStrings.errorInternetFailedString,
          ),
        );
      } else {
        return Left(
          HttpRequestException(
            titleError: AppStrings.errorGenericTitleString,
            descriptionError: AppStrings.ticketCodeReaderErrorString,
          ),
        );
      }
    } catch (error) {
      return Left(
        UnknownException(
          titleError: AppStrings.errorGenericTitleString,
          descriptionError:
              '${AppStrings.errorSomethingWrongString} ${error.toString()}',
        ),
      );
    }
  }
}
