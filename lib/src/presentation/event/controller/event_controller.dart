import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

class EventController extends ChangeNotifier {
  EventController();

  final NavigationService navigationService = GetIt.I<NavigationService>();
}
