import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/gradient_text.dart';

class ListOfParticipantsButton extends StatelessWidget {
  const ListOfParticipantsButton({
    super.key,
    required this.listOfParticipantsFunction,
  });

  final Function() listOfParticipantsFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: listOfParticipantsFunction,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.purpleColor,
            width: 1,
          ),
        ),
        child: Center(
          child: GradientText(
            gradient: LinearGradient(
              colors: AppColors.purpleLinearGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            text: AppStrings.seeParticipantsListString,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
