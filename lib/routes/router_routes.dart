import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/survey_info/create_survey_page.dart';
import 'package:survey_app/pages/survey_info/dashboard.dart';

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
                List<SurveyHeader> surveys = state.extra as List<SurveyHeader>;
                return Dashboard(
                  title: "Dashboard",
                  surveys: surveys,
                );
              }),
          GoRoute(
              name: Routes.createSurvey,
              path: Routes.createSurvey,
              builder: (context, state) {
                SurveyHeadersCompanion survey =
                    state.extra as SurveyHeadersCompanion;
                return CreateSurvey(
                    surveyHeader: survey,
                    province: state.uri.queryParameters["province"] ?? "");
              })
        ]),
  ],
);
