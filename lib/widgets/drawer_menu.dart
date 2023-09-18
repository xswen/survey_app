import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:survey_app/constants/text_designs.dart';

import '../constants/constant_values.dart';
import '../constants/margins_padding.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key, this.onLocaleChange, this.tiles});
  final VoidCallback? onLocaleChange;
  final List<dynamic>? tiles;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Options',
              style: TextStyle(color: Colors.white, fontSize: kTextHeaderSize),
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(FontAwesomeIcons.globe),
                SizedBox(
                  width: kPaddingH,
                ),
                Text("Change Language")
              ],
            ),
            onTap: () {
              context.locale == kLocaleEn
                  ? context.setLocale(kLocaleFr)
                  : context.setLocale(kLocaleEn);
              onLocaleChange!();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Language has been changed to '
                      '${context.locale == kLocaleFr ? "French" : "English"}')));
            },
          ),
          ...?tiles,
        ],
      ),
    );
  }
}
