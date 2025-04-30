import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/presentation/home/controller/home_controller.dart';
import 'package:ticket_com_vc_app/src/presentation/home/view/widgets/event_card.dart';
import 'package:ticket_com_vc_app/src/presentation/home/view/widgets/worker_register_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = AppRoutes.homeAppRoute;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.myEventsString,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.blueColor,
        ),
        body: FutureBuilder(
          future: _controller.fetchEventsList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.blueColor,
                  strokeWidth: 2,
                ),
              );
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.nextEventsString,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _controller.eventsList,
                        builder: (context, eventsList, _) {
                          return eventsList.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Center(
                                    child: Text(
                                      AppStrings.noEventsRegisteredString,
                                    ),
                                  ),
                                )
                              : Wrap(
                                  children: List.generate(
                                    eventsList.length,
                                    (index) {
                                      return EventCard(
                                        cardOnTapFunction: eventsList[index]
                                                .actuationIsActivated
                                            ? () => _controller
                                                    .navigationService
                                                    .navigateTo(
                                                  AppRoutes.eventAppRoute,
                                                  arguments: eventsList[index],
                                                )
                                            : () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return WorkerRegisterDialog(
                                                      event: eventsList[index],
                                                      controller: _controller,
                                                    );
                                                  },
                                                );
                                              },
                                        event: eventsList[index],
                                      );
                                    },
                                  ),
                                );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
