import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';

class NumberOfTicketsContainer extends StatelessWidget {
  const NumberOfTicketsContainer({
    super.key,
    required this.totalTickets,
    required this.checkedTickets,
    required this.listOfParticipantsPageName,
  });

  final int totalTickets;
  final int checkedTickets;
  final ListOfParticipantsPages listOfParticipantsPageName;

  @override
  Widget build(BuildContext context) {
    final TextStyle generalTextStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );

    Widget widgetAccordingPageName() {
      switch (listOfParticipantsPageName) {
        case ListOfParticipantsPages.checkedParticipants:
          return Text(
            "${AppStrings.checkedTicketsString} $checkedTickets",
            style: generalTextStyle,
          );

        default:
          return Column(
            children: [
              Text(
                "${AppStrings.totalTicketsString} $totalTickets",
                style: generalTextStyle,
              ),
              Text(
                "${AppStrings.checkedTicketsString} $checkedTickets",
                style: generalTextStyle,
              ),
            ],
          );
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.purpleColor,
          width: 1,
        ),
      ),
      child: widgetAccordingPageName(),
    );
  }
}
