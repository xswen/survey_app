import 'package:go_router/go_router.dart';

import 'path_param_keys.dart';

class PathParamGenerator {
  static Map<String, String> surveyInfo(String surveyId) {
    return {PathParamsKeys.surveyId: surveyId};
  }

  //Woody Debris
  static Map<String, String> wdSummary(
          GoRouterState goRouterState, String wdSummaryId) =>
      {
        ...surveyInfo(goRouterState.pathParameters[PathParamsKeys.surveyId]!),
        ...{PathParamsKeys.wdSummaryId: wdSummaryId}
      };
  static Map<String, String> wdHeader(
          GoRouterState goRouterState, String wdHeaderId) =>
      {
        ...wdSummary(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.wdSummaryId]!),
        ...{PathParamsKeys.wdHeaderId: wdHeaderId}
      };
  static Map<String, String> wdSmall(
          GoRouterState goRouterState, String wdSmallId) =>
      {
        ...wdHeader(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.wdHeaderId]!),
        ...{PathParamsKeys.wdSmallId: wdSmallId}
      };

  //Surface Substrate
  static Map<String, String> ssSummary(
          GoRouterState goRouterState, String ssSummaryId) =>
      {
        ...surveyInfo(goRouterState.pathParameters[PathParamsKeys.surveyId]!),
        ...{PathParamsKeys.ssSummaryId: ssSummaryId}
      };
  static Map<String, String> ssHeader(
          GoRouterState goRouterState, String ssHeaderId) =>
      {
        ...ssSummary(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.ssSummaryId]!),
        ...{PathParamsKeys.ssHeaderId: ssHeaderId}
      };
  static Map<String, String> ssStationInfo(
          GoRouterState goRouterState, String ssStationNum) =>
      {
        ...ssHeader(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.ssHeaderId]!),
        ...{PathParamsKeys.ssStationNum: ssStationNum}
      };
}
