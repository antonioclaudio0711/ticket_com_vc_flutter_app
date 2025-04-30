import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_colors.dart';

class CustomTextformField extends StatelessWidget {
  const CustomTextformField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validatorFunction,
    required this.textFormFieldPadding,
    this.isObscureText,
    this.suffixIcon,
    this.suffixIconFunction,
  });

  final String hintText;
  final TextEditingController controller;
  final EdgeInsets textFormFieldPadding;
  final String? Function(String?)? validatorFunction;
  final bool? isObscureText;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: textFormFieldPadding,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: TextFormField(
          validator: validatorFunction,
          controller: controller,
          obscureText: isObscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.greenColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.greyColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
                    onPressed: suffixIconFunction ?? () {},
                    icon: Icon(
                      suffixIcon,
                      color: AppColors.greyColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
