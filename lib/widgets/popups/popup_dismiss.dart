import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopupDismiss extends StatelessWidget {
  const PopupDismiss(this.title,
      {super.key, this.contentText, this.contentWidget, this.buttonTitle});
  final String title;
  final String? contentText;
  final Widget? contentWidget;
  final String? buttonTitle;

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
        CupertinoDialogAction(
          onPressed: () => context.pop(),
          child: Text(buttonTitle ?? "Ok"),
        ),
      ],
    );
  }
}
