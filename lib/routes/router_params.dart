import 'package:survey_app/barrels/page_imports_barrel.dart';

class RouteParams {
  static const String surveyIdKey = "surveyId";
  static const String wdSummaryIdKey = "wdSummaryId";
  static const String wdHeaderIdKey = "wdHeaderId";
  static const String wdSmallIdKey = "wdSmallId";

  static int? getSurveyId(GoRouterState goRouterState) =>
      goRouterState.pathParameters[surveyIdKey]! == kParamMissing
          ? null
          : int.parse(goRouterState.pathParameters[surveyIdKey]!);
  static int getWdSummaryId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[wdSummaryIdKey]!);
  static int? getWdHeaderId(GoRouterState goRouterState) =>
      goRouterState.pathParameters[wdHeaderIdKey]! == kParamMissing
          ? null
          : int.parse(goRouterState.pathParameters[wdHeaderIdKey]!);
  static int getWdSmallId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[wdSmallIdKey]!);

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
  static Map<String, String> generateWdSmallParms(
          GoRouterState goRouterState, String wdSmallId) =>
      {
        ...generateWdHeaderParms(
            goRouterState, goRouterState.pathParameters[wdHeaderIdKey]!),
        ...{wdSmallIdKey: wdSmallId}
      };
}
