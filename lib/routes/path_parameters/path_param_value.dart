import 'package:go_router/go_router.dart';
import 'package:survey_app/routes/path_parameters/path_param_keys.dart';

import '../../constants/constant_values.dart';

class PathParamValue {
  static int? getSurveyId(GoRouterState goRouterState) =>
      goRouterState.pathParameters[PathParamsKeys.surveyId]! == kParamMissing
          ? null
          : int.parse(goRouterState.pathParameters[PathParamsKeys.surveyId]!);

  //Woody Debris
  static int getWdSummaryId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[PathParamsKeys.wdSummaryId]!);
  static int? getWdHeaderId(GoRouterState goRouterState) =>
      goRouterState.pathParameters[PathParamsKeys.wdHeaderId]! == kParamMissing
          ? null
          : int.parse(goRouterState.pathParameters[PathParamsKeys.wdHeaderId]!);
  static int getWdSmallId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[PathParamsKeys.wdSmallId]!);

  //Surface Substrate
  static int getSsSummaryId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[PathParamsKeys.ssSummaryId]!);
  static int getSsHeaderId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[PathParamsKeys.ssHeaderId]!);
  static int getSsTallyId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[PathParamsKeys.ssStationNum]!);

  //Ecological Plot
  static int getEcpSummaryId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[PathParamsKeys.ecpSummaryId]!);
  static int getEcpHeaderId(GoRouterState goRouterState) =>
      int.parse(goRouterState.pathParameters[PathParamsKeys.ecpHeaderId]!);
}
