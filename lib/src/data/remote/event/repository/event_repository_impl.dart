import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/datasource/event_datasource.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/model/event_model.dart';
import 'package:ticket_com_vc_app/src/domain/remote/event/repository/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  EventRepositoryImpl(this.eventDatasource);

  final EventDatasource eventDatasource;

  @override
  Future<Either<Failure, List<EventModel>>> fetchEventsList() async {
    return await eventDatasource.fetchEventsList();
  }
}
