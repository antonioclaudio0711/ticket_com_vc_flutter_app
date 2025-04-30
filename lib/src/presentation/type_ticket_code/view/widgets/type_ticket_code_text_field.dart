import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';

class TypeTicketCodeTextField extends StatelessWidget {
  const TypeTicketCodeTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: AppStrings.ticketCodeString,
            hintStyle: TextStyle(
              color: AppColors.blueColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.greenColor, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.greyColor, width: 1),
            ),
            prefixIcon: Icon(
              Icons.confirmation_num_outlined,
              color: AppColors.blueColor,
            ),
          ),
        ),
      ),
    );
  }
}
