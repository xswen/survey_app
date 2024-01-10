import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MarkCompleteButton extends StatelessWidget {
  const MarkCompleteButton(
      {super.key,
      required this.title,
      required this.complete,
      required this.onPressed});

  final String title;
  final bool complete;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: complete ? Colors.grey : Colors.blue,
          onPrimary: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
        ),
        icon: Icon(
          complete
              ? FontAwesomeIcons.penToSquare
              : FontAwesomeIcons.solidFloppyDisk,
          size: 20, // Icon size
        ),
        label: Text(
          complete ? "Edit $title" : "Mark $title as Complete",
          style: const TextStyle(
            fontSize: 16, // Font size
            fontWeight: FontWeight.bold, // Bold font weight
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
