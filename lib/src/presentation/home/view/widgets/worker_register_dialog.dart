import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';
import 'package:ticket_com_vc_app/src/data/remote/event/model/event_model.dart';
import 'package:ticket_com_vc_app/src/presentation/home/controller/home_controller.dart';

class WorkerRegisterDialog extends StatelessWidget {
  const WorkerRegisterDialog({
    super.key,
    required this.event,
    required this.controller,
  });

  final EventModel event;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        textAlign: TextAlign.center,
        AppStrings.workerRegisterString,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${AppStrings.eventNameString} ${event.name}\n${AppStrings.eventLocalizationString} ${event.address}\n${AppStrings.eventDateString} ${dateFormatter(event.startDatetime)}",
          ),
        ],
      ),
      actions: [
        ValueListenableBuilder(
          valueListenable: controller.isLoading,
          builder: (context, isLoading, _) {
            return ElevatedButton(
              onPressed: () async =>
                  await controller.workerCheckIn(event: event),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(5),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      AppStrings.activateString,
                      style: TextStyle(color: Colors.white),
                    ),
            );
          },
        ),
      ],
    );
  }
}
