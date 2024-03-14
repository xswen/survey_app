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
          GoRouterState goRouterState, String wdHeaderId, String wdSmallId) =>
      {
        ...wdSummary(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.wdSummaryId]!),
        ...{
          PathParamsKeys.wdHeaderId: wdHeaderId,
          PathParamsKeys.wdSmallId: wdSmallId
        }
      };

  static Map<String, String> wdSmall(
          GoRouterState goRouterState, String wdSmallId) =>
      {
        ...wdHeader(
            goRouterState,
            goRouterState.pathParameters[PathParamsKeys.wdHeaderId]!,
            goRouterState.pathParameters[PathParamsKeys.wdSmallId]!),
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

  //Ecological Plot
  static Map<String, String> ecpSummary(
          GoRouterState goRouterState, String ecpSummaryId) =>
      {
        ...surveyInfo(goRouterState.pathParameters[PathParamsKeys.surveyId]!),
        ...{PathParamsKeys.ecpSummaryId: ecpSummaryId}
      };

  static Map<String, String> ecpHeader(
          GoRouterState goRouterState, String ecpHeaderId) =>
      {
        ...ecpSummary(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.ecpSummaryId]!),
        ...{PathParamsKeys.ecpHeaderId: ecpHeaderId}
      };

  static Map<String, String> ecpSpecies(
          GoRouterState goRouterState, String ecpSpeciesId) =>
      {
        ...ecpHeader(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.ecpHeaderId]!),
        ...{PathParamsKeys.ecpSpeciesNum: ecpSpeciesId}
      };

  //Soil Pit
  static Map<String, String> soilPitSummary(
          GoRouterState goRouterState, String soilPitSummaryId) =>
      {
        ...surveyInfo(goRouterState.pathParameters[PathParamsKeys.surveyId]!),
        ...{PathParamsKeys.soilPitSummaryId: soilPitSummaryId}
      };
  static Map<String, String> soilSiteInfo(
          GoRouterState goRouterState, String soilSiteInfoId) =>
      {
        ...soilPitSummary(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.soilPitSummaryId]!),
        ...{PathParamsKeys.soilSiteInfoId: soilSiteInfoId}
      };

  //STP
  static Map<String, String> stpSummary(
          GoRouterState goRouterState, String stpSummaryId) =>
      {
        ...surveyInfo(goRouterState.pathParameters[PathParamsKeys.surveyId]!),
        ...{PathParamsKeys.stpSummaryId: stpSummaryId}
      };

  static Map<String, String> stpSpecies(
          GoRouterState goRouterState, String stpSpeciesId) =>
      {
        ...stpSummary(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.stpSummaryId]!),
        ...{PathParamsKeys.stpSpeciesId: stpSpeciesId}
      };

  //Shrub
  static Map<String, String> shrubSummary(
          GoRouterState goRouterState, String shrubSummaryId) =>
      {
        ...surveyInfo(goRouterState.pathParameters[PathParamsKeys.surveyId]!),
        ...{PathParamsKeys.shrubSummaryId: shrubSummaryId}
      };

  static Map<String, String> shrubSpecies(
          GoRouterState goRouterState, String shrubSpeciesId) =>
      {
        ...shrubSummary(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.shrubSummaryId]!),
        ...{PathParamsKeys.shrubSpeciesId: shrubSpeciesId}
      };

  //Stump
  static Map<String, String> stumpSummary(
          GoRouterState goRouterState, String stumpSummaryId) =>
      {
        ...surveyInfo(goRouterState.pathParameters[PathParamsKeys.surveyId]!),
        ...{PathParamsKeys.stumpSummaryId: stumpSummaryId}
      };

  static Map<String, String> stumpSpecies(
          GoRouterState goRouterState, String stumpSpeciesId) =>
      {
        ...stumpSummary(goRouterState,
            goRouterState.pathParameters[PathParamsKeys.stumpSummaryId]!),
        ...{PathParamsKeys.stumpSpeciesId: stumpSpeciesId}
      };
}
