import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Popups {
  static showDismiss(BuildContext context, String title,
      {String? contentText, Widget? contentWidget, String? buttonTitle}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
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
                onPressed: () => context.pop(),
                child: Text(buttonTitle ?? "Ok"),
              ),
            ],
          );
        });
  }

  static showContinue(BuildContext context, String title, String content,
      {Object? cancelResult, VoidCallback? rightBtnOnPressed}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () => context.pop(cancelResult),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: rightBtnOnPressed,
                child: const Text('Continue'),
              ),
            ],
          );
        });
  }
}
