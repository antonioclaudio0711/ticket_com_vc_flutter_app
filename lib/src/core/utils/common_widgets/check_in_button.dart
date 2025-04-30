import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    super.key,
    required this.checkInFunction,
    required this.containerChildWidget,
    this.buttonOpacity,
  });

  final Function() checkInFunction;
  final Widget containerChildWidget;
  final double? buttonOpacity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: checkInFunction,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
        child: Opacity(
          opacity: buttonOpacity ?? 1.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 16,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: AppColors.purpleLinearGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: containerChildWidget,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      AppStrings.doCheckInString,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
