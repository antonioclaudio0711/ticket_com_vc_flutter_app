import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {
  const DismissKeyboard({
    super.key,
    required this.childWidget,
  });

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: childWidget,
    );
  }
}
