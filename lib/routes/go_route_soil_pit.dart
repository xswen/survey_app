import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_depth_page.dart';
import 'package:survey_app/routes/path_parameters/path_param_keys.dart';

import '../pages/soil_pit/soil_pit_depth_entry_page.dart';
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
          name: SoilPitDepthPage.routeName,
          path: "pit_depth_list",
          builder: (context, state) => SoilPitDepthPage(state),
          routes: [
            GoRoute(
                name: SoilPitDepthEntryPage.routeName,
                path: "pit_depth",
                builder: (context, state) => SoilPitDepthEntryPage(state),
                routes: [])
          ])
    ]);
