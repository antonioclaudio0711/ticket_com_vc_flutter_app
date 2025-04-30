import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';

class ListOfParticipantsPageNameSelector extends StatelessWidget {
  const ListOfParticipantsPageNameSelector({
    super.key,
    required this.onTapFunction,
    required this.textLabelButton,
    required this.isSelected,
  });

  final Function() onTapFunction;
  final String textLabelButton;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blueColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.blueColor,
          ),
        ),
        child: Text(
          textLabelButton,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : AppColors.blueColor,
          ),
        ),
      ),
    );
  }
}
