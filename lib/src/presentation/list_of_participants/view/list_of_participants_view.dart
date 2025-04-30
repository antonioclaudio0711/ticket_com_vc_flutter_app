import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/check_in_button.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';
import 'package:ticket_com_vc_app/src/presentation/list_of_participants/controller/list_of_participants_controller.dart';
import 'package:ticket_com_vc_app/src/presentation/list_of_participants/view/widgets/list_of_participants_page_name_selector.dart';
import 'package:ticket_com_vc_app/src/presentation/list_of_participants/view/widgets/loading_indicator.dart';
import 'package:ticket_com_vc_app/src/presentation/list_of_participants/view/widgets/number_of_tickets_container.dart';
import 'package:ticket_com_vc_app/src/presentation/list_of_participants/view/widgets/participant_card.dart';

class ListOfParticipantsView extends StatefulWidget {
  const ListOfParticipantsView({
    super.key,
    required this.eventId,
  });

  static const routeName = AppRoutes.listOfParticipantsAppRoute;
  final String eventId;

  @override
  State<ListOfParticipantsView> createState() => _ListOfParticipantsViewState();
}

class _ListOfParticipantsViewState extends State<ListOfParticipantsView> {
  String get eventId => widget.eventId;
  final ListOfParticipantsController _controller =
      ListOfParticipantsController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(fetchMoreParticipants);
  }

  Future<void> fetchMoreParticipants() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await _controller.fetchListOfParticipants(eventId: eventId);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: _controller.navigationService.goBack,
          icon: Icon(Icons.chevron_left),
        ),
        title: Text(
          AppStrings.listOfParticipantsString,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          top: 12,
          right: 24,
          bottom: 8,
        ),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _controller.listOfParticipantsPageName,
              builder: (context, listOfParticipantsPageName, _) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListOfParticipantsPageNameSelector(
                          onTapFunction: () =>
                              _controller.changeListOfParticipantsPageName(
                            eventId: eventId,
                            newListOfParticipantsPageName:
                                ListOfParticipantsPages.allParticipants,
                          ),
                          textLabelButton: AppStrings.allParticipantsPageString,
                          isSelected: listOfParticipantsPageName ==
                              ListOfParticipantsPages.allParticipants,
                        ),
                        ListOfParticipantsPageNameSelector(
                          onTapFunction: () =>
                              _controller.changeListOfParticipantsPageName(
                            eventId: eventId,
                            newListOfParticipantsPageName:
                                ListOfParticipantsPages.checkedParticipants,
                          ),
                          textLabelButton:
                              AppStrings.checkedParticipantsPageString,
                          isSelected: listOfParticipantsPageName ==
                              ListOfParticipantsPages.checkedParticipants,
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: _controller.quantitiesOfTickets,
                      builder: (context, quantitiesOfTickets, _) {
                        if (quantitiesOfTickets != null) {
                          return NumberOfTicketsContainer(
                            totalTickets: quantitiesOfTickets.totalTickets,
                            checkedTickets: quantitiesOfTickets.checkedTickets,
                            listOfParticipantsPageName:
                                listOfParticipantsPageName,
                          );
                        } else {
                          return SizedBox(height: 12);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: _controller.fetchListOfParticipants(eventId: eventId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: LoadingIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        AppStrings.errorToLoadListOfParticipantsString,
                      ),
                    );
                  } else {
                    return ValueListenableBuilder(
                      valueListenable: _controller.isLoading,
                      builder: (context, isLoading, _) {
                        if (isLoading) {
                          return Center(child: LoadingIndicator());
                        } else {
                          return ValueListenableBuilder(
                            valueListenable: _controller.listOfParticipants,
                            builder: (context, listOfParticipants, _) {
                              if (listOfParticipants.isEmpty) {
                                return Center(
                                  child: Text(
                                    AppStrings
                                        .noParticipantsAreRegisteredString,
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  controller: _scrollController,
                                  itemCount: _controller.isTheLastPage
                                      ? listOfParticipants.length
                                      : listOfParticipants.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < listOfParticipants.length) {
                                      return ParticipantCard(
                                        participantName:
                                            listOfParticipants[index]
                                                .user
                                                .fullName,
                                        participantEmail:
                                            listOfParticipants[index]
                                                .user
                                                .email,
                                        participantTicketCode:
                                            listOfParticipants[index].code!,
                                        participantIsChecked:
                                            listOfParticipants[index].checked,
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Center(child: LoadingIndicator()),
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CheckInButton(
        containerChildWidget: Icon(
          Icons.qr_code_scanner,
          color: AppColors.purpleColor,
        ),
        checkInFunction: () =>
            _controller.navigationService.pushReplacementNamed(
          AppRoutes.checkInAppRoute,
          arguments: eventId,
        ),
      ),
    );
  }
}
