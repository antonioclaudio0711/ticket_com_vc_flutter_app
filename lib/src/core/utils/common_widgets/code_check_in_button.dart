import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/gradient_text.dart';

class CodeCheckInButton extends StatelessWidget {
  const CodeCheckInButton({
    super.key,
    required this.typeCodeButtonFunction,
  });

  final Function() typeCodeButtonFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: typeCodeButtonFunction,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 19,
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
            text: AppStrings.typeTheCodeString,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
