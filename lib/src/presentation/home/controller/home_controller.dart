import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/model/event_model.dart';
import 'package:ticket_com_vc_app/src/domain/remote/event/repository/event_repository.dart';
import 'package:ticket_com_vc_app/src/domain/remote/job_check_in/repository/job_check_in_repository.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

class HomeController extends ChangeNotifier {
  HomeController();

  final NavigationService navigationService = GetIt.I<NavigationService>();
  final EventRepository _eventRepository = GetIt.I<EventRepository>();
  final JobCheckInRepository _jobCheckInRepository =
      GetIt.I<JobCheckInRepository>();

  ValueNotifier<List<EventModel>> eventsList = ValueNotifier([]);
  ValueNotifier<String> deviceIdentifier = ValueNotifier("");
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> fetchEventsList() async {
    final response = await _eventRepository.fetchEventsList();

    response.fold(
      (error) {},
      (success) => eventsList.value = success,
    );
  }

  Future<void> fetchDeviceIdentifier() async =>
      deviceIdentifier.value = await getDeviceIdentifier();

  Future<void> workerCheckIn({
    required EventModel event,
  }) async {
    isLoading.value = true;

    await fetchDeviceIdentifier();

    final response = await _jobCheckInRepository.putJobCheckIn(
      deviceId: deviceIdentifier.value,
      eventId: event.id,
    );

    response.fold(
      (error) {},
      (success) {
        event.actuationIsActivated = true;
        eventsList.notifyListeners();
        navigationService.goBack();
      },
    );

    isLoading.value = false;
  }
}
