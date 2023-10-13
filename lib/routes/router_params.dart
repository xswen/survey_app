import 'package:go_router/go_router.dart';

class RouteParams {
  static const String surveyIdKey = "surveyId";
  static const String wdSummaryIdKey = "wdSummaryId";
  static const String wdHeaderIdKey = "wdHeaderId";

  static int getSurveyId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[surveyIdKey]!);
  static int getWdSummaryId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[wdSummaryIdKey]!);
  static int getWdHeaderId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[wdHeaderIdKey]!);

  static Map<String, String> generateSurveyInfoParams(String surveyId) {
    return {surveyIdKey: surveyId};
  }

  static Map<String, String> generateWdSummaryParams(
          GoRouterState goRouterState, String wdSummaryId) =>
      {
        ...generateSurveyInfoParams(goRouterState.pathParameters[surveyIdKey]!),
        ...{wdSummaryIdKey: wdSummaryId}
      };
  static Map<String, String> generateWdHeaderParms(
          GoRouterState goRouterState, String wdHeaderId) =>
      {
        ...generateWdSummaryParams(
            goRouterState, goRouterState.pathParameters[wdSummaryIdKey]!),
        ...{wdHeaderIdKey: wdHeaderId}
      };
}
