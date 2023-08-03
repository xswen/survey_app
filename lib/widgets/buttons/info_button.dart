import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key, required this.content, this.size = 15.0});
  final Text content;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => CupertinoAlertDialog(
              content: content,
            ),
        icon: Icon(
          FontAwesomeIcons.info,
          size: size,
        ));
  }
}
