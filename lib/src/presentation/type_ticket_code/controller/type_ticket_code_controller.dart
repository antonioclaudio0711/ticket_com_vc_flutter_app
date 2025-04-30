import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/utils.dart';
import 'package:ticket_com_vc_app/src/domain/remote/participant_check_in/repository/participant_check_in_repository.dart';
import 'package:ticket_com_vc_app/src/service/navigation/navigation_service.dart';

class TypeTicketCodeController extends ChangeNotifier {
  TypeTicketCodeController() {
    fetchDeviceIdentifier();
  }

  final NavigationService navigationService = GetIt.I<NavigationService>();
  final ParticipantCheckInRepository _participantCheckInRepository =
      GetIt.I<ParticipantCheckInRepository>();

  TextEditingController ticketCodeTextEditingController =
      TextEditingController();

  ValueNotifier<String> deviceIdentifier = ValueNotifier("");
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> fetchDeviceIdentifier() async =>
      deviceIdentifier.value = await getDeviceIdentifier();

  Future<void> checkInWithTypedTicketCode({
    required String eventId,
    required BuildContext context,
  }) async {
    if (ticketCodeTextEditingController.text.isEmpty) return;

    isLoading.value = true;

    final response = await _participantCheckInRepository.putParticipantCheckIn(
      ticketCode: ticketCodeTextEditingController.text,
      deviceId: deviceIdentifier.value,
      eventId: eventId,
    );

    response.fold(
      (error) {
        final String errorMessage =
            error.toString().replaceFirst("Exception: ", "");

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

    isLoading.value = false;
    ticketCodeTextEditingController.clear();
  }
}
