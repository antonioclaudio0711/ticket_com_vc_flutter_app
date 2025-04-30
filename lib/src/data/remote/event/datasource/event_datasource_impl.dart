import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/datasource/event_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/model/event_model.dart';
import 'package:ticket_com_vc_app/src/service/http/http_service.dart';

class EventDatasourceImpl implements EventDatasource {
  EventDatasourceImpl(this.httpService);

  final IHttpService httpService;

  @override
  Future<Either<Failure, List<EventModel>>> fetchEventsList() async {
    try {
      final response = await httpService.get(
        "api/events/jobs/my-events/",
      );

      final Map<String, dynamic> jsonResponse = response.data;
      final List<dynamic> jsonEventsList = jsonResponse["results"];

      final eventsList = jsonEventsList
          .map((jsonEvent) => EventModel.fromJson(jsonEvent))
          .toList();

      return Right(eventsList);
    } on DioException catch (err) {
      if (err.type == DioExceptionType.connectionError ||
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
            descriptionError:
                '${err.response?.statusCode} - ${AppStrings.errorSomethingWrongString} ${err.toString()}',
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
