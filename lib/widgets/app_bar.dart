import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OurAppBar(this.title, {super.key, this.backFn});
  final String title;
  final void Function()? backFn;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: BackButton(
        onPressed: backFn ?? () => Get.back(),
        //
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(FontAwesomeIcons.bars),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(FontAwesomeIcons.bars),
      onPressed: () {
        log("hello");
      },
      tooltip: 'Menu',
    );
  }
}
