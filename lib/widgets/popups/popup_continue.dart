import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopupContinue extends StatelessWidget {
  const PopupContinue(this.title, this.content,
      {super.key, this.cancelResult, this.rightBtnOnPressed});
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
