import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatingCompleteButton extends StatelessWidget {
  const FloatingCompleteButton(
      {Key? key,
      required this.title,
      required this.complete,
      required this.onPressed})
      : super(key: key);

  final String title;
  final bool complete;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: complete ? Text("Edit $title") : Text("Mark $title as Complete"),
      icon: complete
          ? const Icon(FontAwesomeIcons.penToSquare)
          : const Icon(FontAwesomeIcons.solidFloppyDisk),
      backgroundColor: Colors.pink,
    );
  }
}
