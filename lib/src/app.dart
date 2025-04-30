import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/dismiss_keyboard.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/model/event_model.dart';
import 'package:ticket_com_vc_app/src/presentation/check_in/view/check_in_view.dart';
import 'package:ticket_com_vc_app/src/presentation/event/view/event_view.dart';
import 'package:ticket_com_vc_app/src/presentation/list_of_participants/view/list_of_participants_view.dart';
import 'package:ticket_com_vc_app/src/presentation/login/view/auth_redirect_view.dart';
import 'package:ticket_com_vc_app/src/presentation/login/view/login_view.dart';
import 'package:ticket_com_vc_app/src/presentation/home/view/home_view.dart';
import 'package:ticket_com_vc_app/src/presentation/type_ticket_code/view/type_ticket_code_view.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      childWidget: MaterialApp(
        title: 'Ticket.com.vc App',
        navigatorKey: GetIt.I<NavigationService>().navigatorKey,
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case AuthRedirectView.routeName:
                  return AuthRedirectView();
                case LoginView.routeName:
                  return const LoginView();
                case HomeView.routeName:
                  return HomeView();
                case EventView.routeName:
                  return EventView(
                    event: routeSettings.arguments as EventModel,
                  );
                case ListOfParticipantsView.routeName:
                  return ListOfParticipantsView(
                    eventId: routeSettings.arguments as String,
                  );
                case CheckInView.routeName:
                  return CheckInView(
                    eventId: routeSettings.arguments as String,
                  );
                case TypeTicketCodeView.routeName:
                  return TypeTicketCodeView(
                    eventId: routeSettings.arguments as String,
                  );
                default:
                  return AuthRedirectView();
              }
            },
          );
        },
      ),
    );
  }
}
