import 'package:fpdart/fpdart.dart';
import 'package:ticket_com_vc_app/src/core/error/failure.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/model/event_model.dart';

abstract class EventDatasource {
  Future<Either<Failure, List<EventModel>>> fetchEventsList();
}
