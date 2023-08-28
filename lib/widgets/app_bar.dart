import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../constants/constant_values.dart';

class OurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OurAppBar(this.title, {super.key, this.backFn, this.onLocaleChange});
  final VoidCallback? onLocaleChange;
  final String title;
  final void Function()? backFn;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title).tr(),
      leading: BackButton(
        onPressed: backFn ?? () => context.pop(),
        //
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(FontAwesomeIcons.bars),
          tooltip: 'Show Snackbar',
          onPressed: () {
            context.locale == kLocaleEn
                ? context.setLocale(kLocaleFr)
                : context.setLocale(kLocaleEn);
            onLocaleChange!();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Language has been changed to '
                    '${context.locale == kLocaleFr ? "French" : "English"}')));
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
        context.locale == kLocaleEn
            ? context.setLocale(kLocaleFr)
            : context.setLocale(kLocaleEn);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Language has been changed to ${context.locale == kLocaleFr ? "French" : "English"}')));
      },
      tooltip: 'Menu',
    );
  }
}
