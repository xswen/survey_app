import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditIconButton extends StatelessWidget {
  const EditIconButton({super.key, required this.onPressed, this.size = 15.0});
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          FontAwesomeIcons.penToSquare,
          size: size,
        ));
  }
}
