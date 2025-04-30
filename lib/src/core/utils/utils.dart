import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

enum ListOfParticipantsPages {
  allParticipants,
  checkedParticipants,
}

String dateFormatter(String originalDate) {
  final originalDateToDateTime = DateTime.parse(originalDate);
  String weekDay = DateFormat("EEEE", "pt_BR").format(originalDateToDateTime);
  weekDay = weekDay[0].toUpperCase() + weekDay.substring(1);

  String formattedDate =
      "$weekDay, ${DateFormat("dd/MM/yyyy", "pt_BR").format(originalDateToDateTime)}";

  return formattedDate;
}

Future<String> getDeviceIdentifier() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? "ID não disponível";
  } else {
    return "";
  }
}

void showCheckInResponseDialog({
  required BuildContext context,
  required int dialogSeconds,
  required List<Color> gradientColorDialog,
  required String responseText,
  required Color responseTextColor,
  required Icon iconDialog,
}) {
  final NavigationService navigationService = GetIt.I<NavigationService>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      Future.delayed(
        Duration(seconds: dialogSeconds),
        () => navigationService.goBack(),
      );

      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: gradientColorDialog,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  iconDialog,
                  SizedBox(height: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      responseText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: responseTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
