import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/code_check_in_button.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/custom_text_button.dart';
import 'package:ticket_com_vc_app/src/presentation/check_in/controller/check_in_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckInView extends StatefulWidget {
  const CheckInView({
    super.key,
    required this.eventId,
  });

  static const routeName = AppRoutes.checkInAppRoute;
  final String eventId;

  @override
  State<CheckInView> createState() => _CheckInViewState();
}

class _CheckInViewState extends State<CheckInView> {
  String get eventId => widget.eventId;
  final CheckInController _controller = CheckInController();

  @override
  void initState() {
    _controller.scannerController.start();
    super.initState();
  }

  @override
  void dispose() {
    _controller.scannerController.dispose();
    _controller.scannerController.stop();
    super.dispose();
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
          AppStrings.checkInString,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.readerPositionString,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 32),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MobileScanner(
                  controller: _controller.scannerController,
                  onDetect: (capture) => _controller.handleBarCode(
                    capture: capture,
                    context: context,
                    eventId: eventId,
                  ),
                ),
              ),
            ),
            CustomTextButton(
              labelText: AppStrings.seeParticipantsListString,
              onTapFunction: () =>
                  _controller.navigationService.pushReplacementNamed(
                AppRoutes.listOfParticipantsAppRoute,
                arguments: eventId,
              ),
            ),
            SizedBox(height: 24),
            CodeCheckInButton(
              typeCodeButtonFunction: () =>
                  _controller.navigationService.pushReplacementNamed(
                AppRoutes.typeTicketCodeAppRoute,
                arguments: eventId,
              ),
            )
          ],
        ),
      ),
    );
  }
}
