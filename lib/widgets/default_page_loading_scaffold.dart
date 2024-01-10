import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_bar.dart';
import 'drawer_menu.dart';

class DefaultPageLoadingScaffold extends StatefulWidget {
  const DefaultPageLoadingScaffold({super.key, required this.title});

  final String title;

  @override
  State<DefaultPageLoadingScaffold> createState() =>
      _DefaultPageLoadingScaffoldState();
}

class _DefaultPageLoadingScaffoldState
    extends State<DefaultPageLoadingScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: OurAppBar(
          widget.title,
          backFn: () {
            context.pop();
          },
        ),
        endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
        body: const Center(child: CircularProgressIndicator()));
  }
}
