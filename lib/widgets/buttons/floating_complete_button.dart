import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Mostly been deprecated by mark_complete_button

class FloatingCompleteButton extends StatelessWidget {
  const FloatingCompleteButton(
      {super.key,
      required this.title,
      required this.complete,
      required this.onPressed});

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
