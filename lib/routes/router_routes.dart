import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/enums/enum_router_extra_key_names.dart';
import 'package:survey_app/pages/surface_substrate/surface_substrate_summary_page.dart';
import 'package:survey_app/pages/survey_info/create_survey_page.dart';
import 'package:survey_app/pages/survey_info/dashboard.dart';
import 'package:survey_app/pages/survey_info/survey_info_page.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_summary_page.dart';

import '../main.dart';
import '../wrappers/survey_card.dart';
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
            path: "dashboard",
            builder: (context, state) {
              List<SurveyHeader> surveys = state.extra as List<SurveyHeader>;
              return Dashboard(
                title: "Dashboard",
                surveys: surveys,
              );
            },
            routes: [
              GoRoute(
                  name: Routes.createSurvey,
                  path: "create-survey",
                  builder: (context, state) {
                    Map<String, dynamic> data =
                        state.extra as Map<String, dynamic>;
                    SurveyHeadersCompanion survey = data["survey"];
                    void Function() updateDashboard = data["updateDashboard"];
                    return CreateSurvey(
                        surveyHeader: survey,
                        province: state.uri.queryParameters["province"] ?? "",
                        updateDashboard: updateDashboard);
                  }),
              GoRoute(
                name: Routes.surveyInfo,
                path: "survey-info",
                builder: (context, state) {
                  Map<String, dynamic> data =
                      state.extra as Map<String, dynamic>;
                  SurveyHeader survey = data["survey"];
                  List<SurveyCard> cards = data["cards"];
                  void Function() updateDashboard = data["updateDashboard"];
                  return SurveyInfoPage(
                      surveyHeader: survey,
                      cards: cards,
                      updateDashboard: updateDashboard);
                },
                routes: [
                  GoRoute(
                    name: Routes.woodyDebris,
                    path: "woody-debris",
                    builder: (context, state) {
                      Map<String, dynamic> data =
                          state.extra as Map<String, dynamic>;
                      WoodyDebrisSummaryData wd = data["wdSummaryData"];
                      List<WoodyDebrisHeaderData> transList = data["transList"];
                      return WoodyDebrisSummaryPage(
                          wd: wd, transList: transList);
                    },
                  ),
                  GoRoute(
                    name: Routes.surfaceSubstrate,
                    path: "surface-substrate",
                    builder: (context, state) {
                      Map<RouterExtraKeys, dynamic> data =
                          state.extra as Map<RouterExtraKeys, dynamic>;
                      SurfaceSubstrateSummaryData ss =
                          data[RouterExtraKeys.surfaceSubstrateSummary];
                      List<SurfaceSubstrateHeaderData> transList =
                          data[RouterExtraKeys.transList];
                      return SurfaceSubstrateSummaryPage(
                          ss: ss, transList: transList);
                    },
                  )
                ],
              )
            ],
          ),
        ]),
  ],
);
