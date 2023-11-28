import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_feature_entry_page.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_feature_page.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_horizon_description_entry_page.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_horizon_description_page.dart';
import 'package:survey_app/routes/path_parameters/path_param_keys.dart';

import '../pages/soil_pit/soil_pit_site_info_page.dart';
import '../pages/soil_pit/soil_pit_summary_table.dart';

GoRoute goRouteSoilPit = GoRoute(
    name: SoilPitSummaryPage.routeName,
    path: "soil_pit/:${PathParamsKeys.soilPitSummaryId}",
    builder: (context, state) => SoilPitSummaryPage(state),
    routes: [
      GoRoute(
          name: SoilPitSiteInfoPage.routeName,
          path: "site_info",
          builder: (context, state) => SoilPitSiteInfoPage(state),
          routes: []),
      GoRoute(
          name: SoilPitFeaturePage.routeName,
          path: "pit_feature_list",
          builder: (context, state) => SoilPitFeaturePage(state),
          routes: [
            GoRoute(
                name: SoilPitFeatureEntryPage.routeName,
                path: "pit_feature",
                builder: (context, state) => SoilPitFeatureEntryPage(state),
                routes: [])
          ]),
      GoRoute(
          name: SoilPitHorizonDescriptionPage.routeName,
          path: "pit_horizon_list",
          builder: (context, state) => SoilPitHorizonDescriptionPage(state),
          routes: [
            GoRoute(
                name: SoilPitHorizonDescriptionEntryPage.routeName,
                path: "pit_horizon",
                builder: (context, state) =>
                    SoilPitHorizonDescriptionEntryPage(state),
                routes: [])
          ]),
    ]);
