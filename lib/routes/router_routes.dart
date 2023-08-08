import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/survey_info/survey_info_select.dart';

import '../main.dart';
import 'route_names.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
        name: Routes.main,
        path: "/",
        builder: (context, state) => const MyHomePage(
              title: 'Test',
            ),
        routes: [
          GoRoute(
              name: Routes.dashboard,
              path: Routes.dashboard,
              builder: (context, state) {
                List<SurveyHeader>? surveys =
                    state.extra as List<SurveyHeader>?;
                return Dashboard(
                  title: "Dashboard",
                  surveys: surveys,
                );
              }),
        ]),
  ],
);
