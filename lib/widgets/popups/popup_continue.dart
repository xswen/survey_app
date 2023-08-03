import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupContinue extends StatelessWidget {
  const PopupContinue({
    super.key,
    required this.title,
    required this.content,
    this.cancelResult = "Cancel",
    required this.rightBtnOnPressed,
  });

  final String title;
  final String content;
  final Object? cancelResult;
  final VoidCallback? rightBtnOnPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(result: cancelResult),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: rightBtnOnPressed,
          child: const Text('Continue'),
        ),
      ],
    );
  }
}
