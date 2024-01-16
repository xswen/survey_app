import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/margins_padding.dart';

class IconNavButton extends StatelessWidget {
  const IconNavButton(
      {super.key,
      this.icon = const SizedBox.shrink(),
      this.space = kPaddingIcon,
      this.padding = const EdgeInsets.all(0),
      required this.label,
      required this.onPressed});

  //Default to empty sized box in case where no Icon is needed
  final Widget icon;
  //Default to 0 for when no Icon is provided
  final double space;
  final String label;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                icon,
                SizedBox(
                  width: space,
                ),
                Text(label)
              ]),
              const Icon(FontAwesomeIcons.angleRight)
            ],
          )),
    );
  }
}
