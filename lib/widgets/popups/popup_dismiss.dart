import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupDismiss extends StatelessWidget {
  const PopupDismiss(
      {super.key,
      required this.title,
      this.contentText,
      this.contentWidget,
      this.buttonTitle = "Ok"});
  final String title;
  final String? contentText;
  final Widget? contentWidget;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: contentWidget ??
          Text(
            contentText ?? "",
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(result: buttonTitle),
          child: Text(buttonTitle),
        ),
      ],
    );
  }
}
