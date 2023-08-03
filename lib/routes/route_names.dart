class Routes {
  static const String error = _Paths.error;
  static const String main = _Paths.main;

  static const String surveySelect = _Paths.surveySelect;
  static const String surveyInfoPage = _Paths.surveyInfo;
  static const String surveyInfoCreate = "${_Paths.surveyInfo}/create";

  static const String woodyDebris = _Paths.woodyDebris;
  static const String woodyDebrisHeader = "${_Paths.woodyDebris}/header";
  static const String woodyDebrisTransectMeasurement =
      "${_Paths.woodyDebris}/transectMeasurements";
  static const String woodyDebrisPieceMain = "${_Paths.woodyDebris}/piecesMain";
  static const String woodyDebrisPieceAddRound =
      "${_Paths.woodyDebris}/pieceAddRound";
  static const String woodyDebrisPieceAddOddAccu =
      "${_Paths.woodyDebris}/pieceAddOddAccu";

  static const String surfaceSubstrate = _Paths.surfaceSubstrate;
  static const String surfaceSubstrateTransect =
      "${_Paths.surfaceSubstrate}/transect";
  static const String surfaceSubstrateStationInfo =
      "${_Paths.surfaceSubstrate}/stationInfo";

  static const String ecologicalPlot = _Paths.ecologicalPlot;
  static const String ecologicalPlotHeader = "${_Paths.ecologicalPlot}/ECPNum";
  static const String ecologicalPlotSpecies =
      "${_Paths.ecologicalPlot}/ECPSpecies";

  static const String siteInfo = _Paths.siteInfo;
  static const String siteInfoDetails = "${_Paths.siteInfo}/Details";
  static const String siteInfoTreatment = "${_Paths.siteInfo}/Treatment";
  static const String siteInfoDisturbance = "${_Paths.siteInfo}/Disturbance";
  static const String siteInfoOrigin = "${_Paths.siteInfo}/Origin";

  static const String soilPit = _Paths.soilPit;
  static const String soilPitSummary = "${_Paths.soilPit}/Summary";
  static const String soilPitSiteInfo = "${_Paths.soilPit}/SiteInfo";
  static const String soilPitAttributes = "${_Paths.soilPit}/Attributes";
  static const String soilPitAttributesInput =
      "${_Paths.soilPit}/Attributes/Input";

  static const String microplot = _Paths.microplot;
  static const String microplotSummary = "${_Paths.microplot}/Summary";
  static const String microplotMeasurements =
      "${_Paths.microplot}/Measurements";
}

abstract class _Paths {
  static const String error = "/error";
  static const String main = "/";
  static const String surveySelect = "/surveySelect";
  static const String surveyInfo = "/surveyInfo";
  static const String woodyDebris = "/woodyDebris";
  static const String surfaceSubstrate = "/surfaceSubstrate";
  static const String ecologicalPlot = "/ecologicalPlot";
  static const String siteInfo = "/siteInfo";
  static const String soilPit = "/soilPit";
  static const String microplot = "/microplot";
}