import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_text_formField.dart';

class customDialogAlert extends StatelessWidget {
  const customDialogAlert({
    super.key,
    required this.categoryControllerName,
    required this.categoryControllerSubTitle,
  });

  final TextEditingController categoryControllerName;
  final TextEditingController categoryControllerSubTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Quiz'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            text: "Enter the category name",
            userController: categoryControllerName,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            text: "Enter the category subtitle",
            userController: categoryControllerSubTitle,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            log(categoryControllerName.text);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
