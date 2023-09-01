import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/surface_substrate/surface_substrate_summary_page.dart';
import 'package:survey_app/pages/survey_info/create_survey_page.dart';
import 'package:survey_app/pages/survey_info/dashboard.dart';
import 'package:survey_app/pages/survey_info/survey_info_page.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_header_page.dart';
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
                    SurveyHeadersCompanion survey =
                        data[CreateSurvey.keySurvey];
                    void Function() updateDashboard =
                        data[CreateSurvey.keyUpdateDash];
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
                  SurveyHeader survey = data[SurveyInfoPage.keySurvey];
                  List<SurveyCard> cards = data[SurveyInfoPage.keyCards];
                  void Function() updateDashboard =
                      data[SurveyInfoPage.keyUpdateDash];
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
                        WoodyDebrisSummaryData wd =
                            data[WoodyDebrisSummaryPage.keyWdSummary];
                        List<WoodyDebrisHeaderData> transList =
                            data[WoodyDebrisSummaryPage.keyTransList];
                        return WoodyDebrisSummaryPage(
                            wd: wd, transList: transList);
                      },
                      routes: [
                        GoRoute(
                            name: Routes.woodyDebrisHeader,
                            path: "header",
                            builder: (context, state) {
                              Map<String, dynamic> data =
                                  state.extra as Map<String, dynamic>;
                              WoodyDebrisHeaderData wdh =
                                  data[WoodyDebrisHeaderPage.keyWdHeader];
                              bool summaryComplete = data[
                                  WoodyDebrisHeaderPage.keySummaryComplete];

                              return WoodyDebrisHeaderPage(
                                  wdh: wdh, summaryComplete: summaryComplete);
                            })
                      ]),
                  GoRoute(
                    name: Routes.surfaceSubstrate,
                    path: "surface-substrate",
                    builder: (context, state) {
                      Map<String, dynamic> data =
                          state.extra as Map<String, dynamic>;
                      SurfaceSubstrateSummaryData ss =
                          data[SurfaceSubstrateSummaryPage.keySsSummary];
                      List<SurfaceSubstrateHeaderData> transList =
                          data[SurfaceSubstrateSummaryPage.keyTransList];
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
