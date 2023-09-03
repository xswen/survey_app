import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopupContinue extends StatelessWidget {
  const PopupContinue(this.title,
      {super.key,
      this.contentText,
      this.contentWidget,
      this.cancelResult,
      this.rightBtnOnPressed});
  final String title;
  final String? contentText;
  final Widget? contentWidget;
  final Object? cancelResult;
  final VoidCallback? rightBtnOnPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: contentWidget ?? Text(contentText ?? ""),
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
  }
}
