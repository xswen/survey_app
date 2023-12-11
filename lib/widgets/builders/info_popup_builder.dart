import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../popups/popups.dart';

class InfoPopupBuilder extends StatelessWidget {
  const InfoPopupBuilder({super.key, required this.popup});

  final AlertDialog popup;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Popups.show(context, popup),
        icon: const Icon(
          FontAwesomeIcons.circleInfo,
          color: Colors.blue,
        ));
  }
}
