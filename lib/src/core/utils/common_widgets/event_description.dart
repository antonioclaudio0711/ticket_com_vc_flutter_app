import 'package:flutter/material.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventLocalization,
  });

  final String eventName;
  final String eventDate;
  final String eventLocalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        SizedBox(height: 8),
        Text(
          eventDate,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
        SizedBox(height: 8),
        Text(
          eventLocalization,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
