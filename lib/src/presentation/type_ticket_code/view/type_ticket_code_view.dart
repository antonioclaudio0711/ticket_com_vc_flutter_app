import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_routes.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/check_in_button.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/custom_text_button.dart';
import 'package:ticket_com_vc_app/src/presentation/type_ticket_code/controller/type_ticket_code_controller.dart';
import 'package:ticket_com_vc_app/src/presentation/type_ticket_code/view/widgets/type_ticket_code_text_field.dart';

class TypeTicketCodeView extends StatefulWidget {
  const TypeTicketCodeView({
    super.key,
    required this.eventId,
  });

  static const routeName = AppRoutes.typeTicketCodeAppRoute;
  final String eventId;

  @override
  State<TypeTicketCodeView> createState() => _TypeTicketCodeViewState();
}

class _TypeTicketCodeViewState extends State<TypeTicketCodeView> {
  String get eventId => widget.eventId;
  final TypeTicketCodeController _controller = TypeTicketCodeController();

  @override
  void dispose() {
    _controller.ticketCodeTextEditingController.clear();
    _controller.dispose();
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
          AppStrings.codeCheckInString,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.typeTheTicketCodeString,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            TypeTicketCodeTextField(
              controller: _controller.ticketCodeTextEditingController,
            ),
            CustomTextButton(
              onTapFunction: () =>
                  _controller.navigationService.pushReplacementNamed(
                AppRoutes.checkInAppRoute,
                arguments: eventId,
              ),
              labelText: AppStrings.turnToCameraString,
            )
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _controller.isLoading,
        builder: (context, isLoading, _) {
          return CheckInButton(
            containerChildWidget: _controller.isLoading.value
                ? SizedBox(
                    width: 25,
                    child: CircularProgressIndicator(
                      color: AppColors.blueColor,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    Icons.tag,
                    color: AppColors.purpleColor,
                  ),
            checkInFunction: () async {
              await _controller.checkInWithTypedTicketCode(
                eventId: eventId,
                context: context,
              );
            },
          );
        },
      ),
    );
  }
}
