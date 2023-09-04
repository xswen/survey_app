import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/surface_substrate/surface_substrate_summary_page.dart';
import 'package:survey_app/pages/survey_info/create_survey_page.dart';
import 'package:survey_app/pages/survey_info/dashboard.dart';
import 'package:survey_app/pages/survey_info/survey_info_page.dart';
import 'package:survey_app/pages/woody_debris/wood_debris_header_measurements_page.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_header_page.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_piece_measurements/woody_debris_header_piece_main.dart';
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
            name: DashboardPage.routeName,
            path: "dashboard",
            builder: (context, state) {
              List<SurveyHeader> surveys = state.extra as List<SurveyHeader>;
              return DashboardPage(
                title: "Dashboard",
                surveys: surveys,
              );
            },
            routes: [
              GoRoute(
                  name: CreateSurveyPage.routeName,
                  path: "create-survey",
                  builder: (context, state) {
                    Map<String, dynamic> data =
                        state.extra as Map<String, dynamic>;
                    SurveyHeadersCompanion survey =
                        data[CreateSurveyPage.keySurvey];
                    void Function() updateDashboard =
                        data[CreateSurveyPage.keyUpdateDash];
                    return CreateSurveyPage(
                        surveyHeader: survey,
                        province: state.uri.queryParameters["province"] ?? "",
                        updateDashboard: updateDashboard);
                  }),
              GoRoute(
                name: SurveyInfoPage.routeName,
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
                      name: WoodyDebrisSummaryPage.routeName,
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
                            name: WoodyDebrisHeaderPage.routeName,
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
                            },
                            routes: [
                              GoRoute(
                                  name: WoodyDebrisHeaderMeasurements.routeName,
                                  path: "measurements",
                                  builder: (context, state) {
                                    WoodyDebrisHeaderData data =
                                        state.extra as WoodyDebrisHeaderData;
                                    return WoodyDebrisHeaderMeasurements(
                                        wdh: data);
                                  }),
                              GoRoute(
                                  name: WoodyDebrisHeaderPieceMain.routeName,
                                  path: "piece-main",
                                  builder: (context, state) {
                                    Map<String, dynamic> data =
                                        state.extra as Map<String, dynamic>;
                                    WoodyDebrisSmallData wdSm = data[
                                        WoodyDebrisHeaderPieceMain.keyWdSmall];
                                    int transNum = data[
                                        WoodyDebrisHeaderPieceMain.keyTransNum];
                                    bool transComplete = data[
                                        WoodyDebrisHeaderPieceMain
                                            .keyTransComplete];
                                    return WoodyDebrisHeaderPieceMain(
                                        wdSmall: wdSm,
                                        transNum: transNum,
                                        transComplete: transComplete);
                                  }),
                            ])
                      ]),
                  GoRoute(
                    name: SurfaceSubstrateSummaryPage.routeName,
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
