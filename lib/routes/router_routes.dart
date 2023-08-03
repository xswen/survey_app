import 'package:go_router/go_router.dart';

import '../main.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => MyHomePage(
        title: 'Test',
      ),
    ),
    // GoRoute(
    //   path: "/settings",
    //   builder: (context, state) => const SettingsPage(),
    // )
  ],
);
