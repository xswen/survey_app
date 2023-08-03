import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton(
      {Key? key,
      required this.icon,
      required this.onPressed,
      this.size = 56.0,
      this.color = Colors.blue})
      : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: size,
        height: size,
      ),
      shape: const CircleBorder(),
      fillColor: color,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
