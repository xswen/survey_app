import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/surface_substrate/surface_substrate_header_page.dart';
import 'package:survey_app/pages/surface_substrate/surface_substrate_station_info_page.dart';

import '../pages/surface_substrate/surface_substrate_summary_page.dart';
import 'path_parameters/path_param_keys.dart';

GoRoute goRouteSurfaceSubstrate = GoRoute(
  name: SurfaceSubstrateSummaryPage.routeName,
  path: "surface-substrate/:${PathParamsKeys.ssSummaryId}",
  builder: (context, state) => SurfaceSubstrateSummaryPage(state),
  routes: [
    GoRoute(
        name: SurfaceSubstrateHeaderPage.routeName,
        path: "header/:${PathParamsKeys.ssHeaderId}",
        builder: (context, state) {
          return SurfaceSubstrateHeaderPage(state);
        },
        routes: [
          GoRoute(
            name: SurfaceSubstrateStationInfoPage.routeName,
            path: "station_info/:${PathParamsKeys.ssStationNum}",
            builder: (context, state) => SurfaceSubstrateStationInfoPage(state),
          ),
        ]),
  ],
);
