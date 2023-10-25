import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OurAppBar(this.title, {super.key, this.backFn, this.onLocaleChange});
  final VoidCallback? onLocaleChange;
  final String title;
  final void Function()? backFn;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      //     title: Text(title).tr(),
      leading: BackButton(
        onPressed: backFn ?? () => context.pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
