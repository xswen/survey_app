import 'package:go_router/go_router.dart';

class RouteParams {
  static const surveyIdKey = "surveyId";
  static const wdSummaryIdKey = "wdSummaryId";
  static const wdHeaderIdKey = "wdHeaderId";

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
