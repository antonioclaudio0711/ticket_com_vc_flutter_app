import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';
import 'package:ticket_com_vc_app/src/domain/remote/participant_check_in/repository/participant_check_in_repository.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

class CheckInController extends ChangeNotifier {
  CheckInController() {
    fetchDeviceIdentifier();
  }

  final NavigationService navigationService = GetIt.I<NavigationService>();
  final ParticipantCheckInRepository _participantCheckInRepository =
      GetIt.I<ParticipantCheckInRepository>();

  final scannerController = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  ValueNotifier<String> ticketScannedCode = ValueNotifier("");
  ValueNotifier<String> deviceIdentifier = ValueNotifier("");
  bool isProcessing = false;

  Future<void> fetchDeviceIdentifier() async =>
      deviceIdentifier.value = await getDeviceIdentifier();

  Future<void> handleBarCode({
    required BarcodeCapture? capture,
    required BuildContext context,
    required String eventId,
  }) async {
    if (capture == null || isProcessing) return;

    if (capture.barcodes.isNotEmpty &&
        capture.barcodes.first.rawValue != null) {
      isProcessing = true;
      ticketScannedCode.value = capture.barcodes.first.rawValue!;

      final response =
          await _participantCheckInRepository.putParticipantCheckIn(
        ticketCode: ticketScannedCode.value,
        deviceId: deviceIdentifier.value,
        eventId: eventId,
      );

      response.fold(
        (error) {
          final String errorMessage = error.description;

          switch (errorMessage) {
            case AppStrings.ticketCodeNotFoundString:
              showCheckInResponseDialog(
                context: context,
                dialogSeconds: 5,
                gradientColorDialog: AppColors.yellowLinearGradient,
                responseText: errorMessage,
                responseTextColor: Colors.black,
                iconDialog: Icon(
                  Icons.cancel_outlined,
                  color: Colors.black,
                  size: 75,
                ),
              );
            case AppStrings.ticketCodeHasAlreadyUsed:
              showCheckInResponseDialog(
                context: context,
                dialogSeconds: 5,
                gradientColorDialog: AppColors.redLinearGradient,
                responseText: errorMessage,
                responseTextColor: Colors.white,
                iconDialog: Icon(
                  Icons.error_outline_outlined,
                  color: Colors.white,
                  size: 75,
                ),
              );

            default:
              showCheckInResponseDialog(
                context: context,
                dialogSeconds: 5,
                gradientColorDialog: AppColors.yellowLinearGradient,
                responseText: errorMessage,
                responseTextColor: Colors.black,
                iconDialog: Icon(
                  Icons.cancel_outlined,
                  color: Colors.black,
                  size: 75,
                ),
              );
          }
        },
        (success) {
          showCheckInResponseDialog(
            context: context,
            dialogSeconds: 2,
            gradientColorDialog: AppColors.greenLinearGradient,
            responseText: AppStrings.ticketCodeReaderSuccessString,
            responseTextColor: Colors.white,
            iconDialog: Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 75,
            ),
          );
        },
      );
    }

    isProcessing = false;
  }
}
