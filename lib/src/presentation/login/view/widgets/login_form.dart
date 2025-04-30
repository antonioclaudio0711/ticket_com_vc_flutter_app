import 'package:flutter/material.dart';
import 'package:ticket_com_vc_app/src/core/utils/app_strings.dart';
import 'package:ticket_com_vc_app/src/core/utils/common_widgets/custom_elevated_button.dart';
import 'package:ticket_com_vc_app/src/presentation/login/controller/login_controller.dart';
import 'package:ticket_com_vc_app/src/presentation/login/view/widgets/custom_text_form_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.loginController,
    required this.loginOnPressedFunction,
  });

  final Key formKey;
  final LoginController loginController;
  final Function() loginOnPressedFunction;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextformField(
            textFormFieldPadding: const EdgeInsets.only(top: 56, bottom: 24),
            validatorFunction: (email) => loginController.emailValidator(email),
            hintText: AppStrings.emailString,
            controller: loginController.emailTextEditingController,
          ),
          ValueListenableBuilder(
            valueListenable: loginController.isObscureText,
            builder: (context, isObscureText, _) {
              return CustomTextformField(
                textFormFieldPadding: const EdgeInsets.only(bottom: 39),
                validatorFunction: (password) =>
                    loginController.passwordValidator(password),
                hintText: AppStrings.passwordString,
                controller: loginController.passwordTextEditingController,
                suffixIcon:
                    isObscureText ? Icons.visibility : Icons.visibility_off,
                suffixIconFunction: () =>
                    loginController.changeTextVisibility(),
                isObscureText: isObscureText,
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: loginController.isLoading,
            builder: (context, isLoading, _) {
              return CustomElevatedButton(
                isLoading: isLoading,
                onPressedFunction: loginOnPressedFunction,
                buttonWidth: MediaQuery.of(context).size.width / 1.2,
                buttonText: AppStrings.loginString,
              );
            },
          ),
        ],
      ),
    );
  }
}
