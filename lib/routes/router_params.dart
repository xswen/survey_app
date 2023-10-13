import 'package:go_router/go_router.dart';

const String _kSurveyIdKey = "surveyId";
const String _kWdSummaryIdKey = "wdSummaryId";
const String _kWdHeaderIdKey = "wdHeaderId";

class RouteParams {
  static int getSurveyId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[_kSurveyIdKey]!);
  static int getWdSummaryId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[_kWdSummaryIdKey]!);
  static int getWdHeaderId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[_kWdHeaderIdKey]!);

  static Map<String, String> generateSurveyInfoParams(String surveyId) {
    return {_kSurveyIdKey: surveyId};
  }

  static Map<String, String> generateWdSummaryParams(
          GoRouterState goRouterState, String wdSummaryId) =>
      {
        ...generateSurveyInfoParams(
            goRouterState.pathParameters[_kSurveyIdKey]!),
        ...{_kWdSummaryIdKey: wdSummaryId}
      };
  static Map<String, String> generateWdHeaderParms(
          GoRouterState goRouterState, String wdHeaderId) =>
      {
        ...generateWdSummaryParams(
            goRouterState, goRouterState.pathParameters[_kWdSummaryIdKey]!),
        ...{_kWdHeaderIdKey: wdHeaderId}
      };
}
