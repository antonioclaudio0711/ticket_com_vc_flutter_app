import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';

class ParticipantCard extends StatelessWidget {
  const ParticipantCard({
    super.key,
    required this.participantName,
    required this.participantEmail,
    required this.participantTicketCode,
    required this.participantIsChecked,
  });

  final String participantName;
  final String participantEmail;
  final String participantTicketCode;
  final bool participantIsChecked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  participantName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1.8,
                  ),
                ),
                Text(
                  participantEmail,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.8,
                  ),
                ),
                Text(
                  participantTicketCode,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.8,
                  ),
                ),
              ],
            ),
            participantIsChecked
                ? Icon(
                    Icons.check_circle_outline,
                    color: AppColors.purpleColor,
                  )
                : Container()
          ],
        ),
        Divider(color: Colors.black),
      ],
    );
  }
}
