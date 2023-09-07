import 'package:flutter/material.dart';

import '../../constants/margins_padding.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton(
      {super.key,
      this.title = "Delete",
      this.padding = const EdgeInsets.only(top: kPaddingV * 2),
      required this.delete});

  final String title;
  final EdgeInsets padding;
  final void Function() delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: () => delete(),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: Colors.red // NEW
            ),
        child: Text(title),
      ),
    );
  }
}
