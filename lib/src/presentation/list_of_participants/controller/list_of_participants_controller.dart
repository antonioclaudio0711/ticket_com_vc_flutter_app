import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/model/counter_model.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/model/participant_model.dart';
import 'package:ticket_com_vc_app/src/domain/remote/list_of_participants/repository/list_of_participants_repository.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

class ListOfParticipantsController extends ChangeNotifier {
  ListOfParticipantsController();

  final NavigationService navigationService = GetIt.I<NavigationService>();
  final ListOfParticipantsRepository listOfParticipantsRepository =
      GetIt.I<ListOfParticipantsRepository>();

  ValueNotifier<ListOfParticipantsPages> listOfParticipantsPageName =
      ValueNotifier(ListOfParticipantsPages.allParticipants);
  ValueNotifier<List<ParticipantModel>> listOfParticipants = ValueNotifier([]);
  ValueNotifier<CounterModel?> quantitiesOfTickets = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  bool isTheLastPage = false;
  int listOfAllParticipantsPage = 1;
  int listOfCheckedParticipantsPage = 1;

  Future<void> changeListOfParticipantsPageName({
    required ListOfParticipantsPages newListOfParticipantsPageName,
    required String eventId,
  }) async {
    if (listOfParticipantsPageName.value != newListOfParticipantsPageName) {
      isLoading.value = true;

      listOfParticipantsPageName.value = newListOfParticipantsPageName;

      listOfParticipants.value.clear();
      quantitiesOfTickets.value = null;

      isTheLastPage = false;
      listOfAllParticipantsPage = 1;
      listOfCheckedParticipantsPage = 1;

      await fetchListOfParticipants(eventId: eventId);

      isLoading.value = false;
    }
  }

  void setQuantitiesOfTickets({
    required CounterModel counters,
  }) {
    if (quantitiesOfTickets.value == null ||
        quantitiesOfTickets.value!.totalTickets != counters.totalTickets ||
        quantitiesOfTickets.value!.checkedTickets != counters.checkedTickets ||
        quantitiesOfTickets.value!.remainingTickets !=
            counters.remainingTickets) {
      quantitiesOfTickets.value = counters;
    }
  }

  Future<void> fetchListOfParticipants({
    required String eventId,
  }) async {
    if (isTheLastPage) return;

    switch (listOfParticipantsPageName.value) {
      case ListOfParticipantsPages.checkedParticipants:
        final response =
            await listOfParticipantsRepository.fetchListOfParticipants(
          status: "used",
          eventId: eventId,
          page: listOfCheckedParticipantsPage,
        );

        response.fold(
          (error) {},
          (success) {
            listOfParticipants.value = [
              ...listOfParticipants.value,
              ...success.results,
            ];

            setQuantitiesOfTickets(counters: success.counters);

            if (success.next != null && success.next!.isNotEmpty) {
              listOfCheckedParticipantsPage++;
            } else {
              isTheLastPage = true;
            }
          },
        );

      case ListOfParticipantsPages.allParticipants:
        final response =
            await listOfParticipantsRepository.fetchListOfParticipants(
          eventId: eventId,
          page: listOfAllParticipantsPage,
        );

        response.fold(
          (error) {},
          (success) {
            listOfParticipants.value = [
              ...listOfParticipants.value,
              ...success.results,
            ];

            setQuantitiesOfTickets(counters: success.counters);

            if (success.next != null && success.next!.isNotEmpty) {
              listOfAllParticipantsPage++;
            } else {
              isTheLastPage = true;
            }
          },
        );
    }
  }
}
