import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/delete_page.dart';
import 'package:survey_app/pages/survey_info/create_survey_page.dart';
import 'package:survey_app/pages/survey_info/dashboard.dart';
import 'package:survey_app/pages/survey_info/survey_info_page.dart';
import 'package:survey_app/routes/go_route_surface_substrate.dart';
import 'package:survey_app/routes/go_route_woody_debris.dart';

import '../main.dart';
import '../wrappers/survey_card.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) => const MyHomePage(
              title: 'Test',
            ),
        routes: [
          GoRoute(
              name: DeletePage.routeName,
              path: "delete",
              builder: (context, state) {
                Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                String objectName = data[DeletePage.keyObjectName];
                void Function() deleteFn = data[DeletePage.keyDeleteFn];
                void Function()? afterDeleteFn =
                    data[DeletePage.keyAfterDeleteFn];

                return DeletePage(
                    objectName: objectName,
                    deleteFn: deleteFn,
                    afterDeleteFn: afterDeleteFn);
              }),
          GoRoute(
            name: DashboardPage.routeName,
            path: "dashboard",
            builder: (context, state) {
              return DashboardPage(title: "Dashboard");
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
                    void Function()? updateDashboard =
                        data[CreateSurveyPage.keyUpdateDash];
                    int? lastMeasNum = data[CreateSurveyPage.keyLastMeasNum];
                    return CreateSurveyPage(
                        surveyHeader: survey,
                        lastMeasNum: lastMeasNum,
                        province: state.uri.queryParameters[
                                CreateSurveyPage.keyProvinceName] ??
                            "",
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
                  goRouteWoodyDebris,
                  goRouteSurfaceSubstrate,
                ],
              )
            ],
          ),
        ]),
  ],
);
