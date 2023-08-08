import 'package:get/get.dart';

import '../main.dart';
import '../pages/ecological_plot/ecological_plot_header_page.dart';
import '../pages/ecological_plot/ecological_plot_summary_page.dart';
import '../pages/ecological_plot/ecoloigcal_plot_species_page.dart';
import '../pages/microplot/microplot_measurements_page.dart';
import '../pages/microplot/microplot_summary_page.dart';
import '../pages/site_info/site_info_details_page.dart';
import '../pages/site_info/site_info_disturbance_page.dart';
import '../pages/site_info/site_info_origin_page.dart';
import '../pages/site_info/site_info_summary_page.dart';
import '../pages/site_info/site_info_treatment_page.dart';
import '../pages/soil_pit/soil_pit_attributes_input_page.dart';
import '../pages/soil_pit/soil_pit_attributes_page.dart';
import '../pages/soil_pit/soil_pit_site_info_page.dart';
import '../pages/soil_pit/soil_pit_summary_page.dart';
import '../pages/surface_substrate/surface_substrate_header_page.dart';
import '../pages/surface_substrate/surface_substrate_station_info_page.dart';
import '../pages/surface_substrate/surface_substrate_summary_page.dart';
import '../pages/survey_info/survey_info_create.dart';
import '../pages/survey_info/survey_info_page.dart';
import '../pages/survey_info/survey_info_select.dart';
import '../pages/woody_debris/piece_measurements/woody_debris_piece_add_odd_accu_page.dart';
import '../pages/woody_debris/piece_measurements/woody_debris_piece_add_round_page.dart';
import '../pages/woody_debris/piece_measurements/woody_debris_piece_main_page.dart';
import '../pages/woody_debris/woody_debris_header_page.dart';
import '../pages/woody_debris/woody_debris_summary_page.dart';
import '../pages/woody_debris/woody_debris_transect_measurement_page.dart';
import '../routes/route_names.dart';

List<GetPage> pages = [
  GetPage(
    name: Routes.main,
    page: () => MyHomePage(title: "appTitle"),
  ),
  GetPage(
    name: Routes.surveySelect,
    page: () => Dashboard(
      title: "Survey Info",
      surveys: [],
    ),
  ),
  GetPage(
    name: Routes.surveyInfoPage,
    page: () => const SurveyInfoPage(title: "Survey Info"),
  ),
  GetPage(
    name: Routes.surveyInfoCreate,
    page: () => const SurveyInfoCreate(),
  ),
  //Woody Debris
  GetPage(
    name: Routes.woodyDebris,
    page: () => const WoodyDebrisSummaryPage(title: "Woody Debris"),
  ),
  GetPage(
    name: Routes.woodyDebrisHeader,
    page: () => const WoodyDebrisHeaderPage(),
  ),
  GetPage(
    name: Routes.woodyDebrisTransectMeasurement,
    page: () => const WoodyDebrisTransectMeasurementPage(),
  ),
  GetPage(
    name: Routes.woodyDebrisPieceMain,
    page: () => const WoodyDebrisPieceMainPage(),
  ),
  GetPage(
    name: Routes.woodyDebrisPieceAddRound,
    page: () => const WoodyDebrisPieceAddRoundPage(),
  ),
  GetPage(
    name: Routes.woodyDebrisPieceAddOddAccu,
    page: () => const WoodyDebrisPieceAddOddAccuPage(),
  ),

  //Surface Substrate
  GetPage(
    name: Routes.surfaceSubstrate,
    page: () => const SurfaceSubstrateSummaryPage(title: "Surface Substrate"),
  ),
  GetPage(
    name: Routes.surfaceSubstrateTransect,
    page: () => const SurfaceSubstrateHeaderPage(),
  ),
  GetPage(
    name: Routes.surfaceSubstrateStationInfo,
    page: () => const SurfaceSubstrateStationInfoPage(),
  ),

  //ECP
  GetPage(
    name: Routes.ecologicalPlot,
    page: () => const EcologicalPlotSummaryPage(title: "Ecological Plot"),
  ),
  GetPage(
    name: Routes.ecologicalPlotHeader,
    page: () => const EcologicalPlotHeaderPage(),
  ),
  GetPage(
    name: Routes.ecologicalPlotSpecies,
    page: () => const EcologicalPlotSpeciesPage(),
  ),
  GetPage(
    name: Routes.siteInfo,
    page: () => const SiteInfoSummary(title: "Site Info"),
  ),

  GetPage(
    name: Routes.siteInfoDetails,
    page: () => const SiteInfoDetailsPage(title: "Site Info Details"),
  ),
  GetPage(
    name: Routes.siteInfoDisturbance,
    page: () => const SiteInfoDisturbancePage(title: "Site Info Disturbances"),
  ),
  GetPage(
    name: Routes.siteInfoOrigin,
    page: () => const SiteInfoOriginPage(title: "Site Info Origin"),
  ),
  GetPage(
    name: Routes.siteInfoTreatment,
    page: () => const SiteInfoTreatmentPage(title: "Site Info Treatment"),
  ),

  GetPage(
    name: Routes.soilPit,
    page: () => const SoilPitSummaryPage(),
  ),
  GetPage(
    name: Routes.soilPitSiteInfo,
    page: () => const SoilPitSiteInfo(),
  ),
  GetPage(
    name: Routes.soilPitAttributes,
    page: () => const SoilPitAttributesPage(),
  ),
  GetPage(
    name: Routes.soilPitAttributesInput,
    page: () => const SoilPitAttributesInputPage(),
  ),
  GetPage(
    name: Routes.microplotSummary,
    page: () => const MicroplotSummaryPage(),
  ),
  GetPage(
    name: Routes.microplotMeasurements,
    page: () => const MicroplotMeasurementsPage(),
  ),
];
