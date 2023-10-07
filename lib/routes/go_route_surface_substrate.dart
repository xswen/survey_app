import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/surface_substrate/surface_substrate_header_page.dart';

import '../database/database.dart';
import '../pages/surface_substrate/surface_substrate_summary_page.dart';

GoRoute goRouteSurfaceSubstrate = GoRoute(
  name: SurfaceSubstrateSummaryPage.routeName,
  path: "surface-substrate",
  builder: (context, state) {
    Map<String, dynamic> data = state.extra as Map<String, dynamic>;
    SurfaceSubstrateSummaryData ss =
        data[SurfaceSubstrateSummaryPage.keySsSummary];
    List<SurfaceSubstrateHeaderData> transList =
        data[SurfaceSubstrateSummaryPage.keyTransList];
    return SurfaceSubstrateSummaryPage(ss: ss, transList: transList);
  },
  routes: [
    // GoRoute(
    //     name: SurfaceSubstrateHeaderMeasurementsPage.routeName,
    //     path: "measurements",
    //     builder: (context, state) {
    //       Map<String, dynamic> data = state.extra as Map<String, dynamic>;
    //
    //       SurfaceSubstrateHeaderCompanion ssh =
    //           data[SurfaceSubstrateHeaderMeasurementsPage.keySsHeaderCompanion]
    //               as SurfaceSubstrateHeaderCompanion;
    //       VoidCallback? updateSummaryPageTransList = data[
    //           SurfaceSubstrateHeaderMeasurementsPage
    //               .keyUpdateSummaryPageTransList] as VoidCallback?;
    //       return SurfaceSubstrateHeaderMeasurementsPage(
    //         ssh: ssh,
    //         updateSummaryPageTransList: updateSummaryPageTransList,
    //       );
    //     }),
    GoRoute(
        name: SurfaceSubstrateHeaderPage.routeName,
        path: "header",
        builder: (context, state) {
          Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          SurfaceSubstrateHeaderCompanion ssh = data[
                  SurfaceSubstrateHeaderPage.keySurfaceSubstrateHeaderCompanion]
              as SurfaceSubstrateHeaderCompanion;
          List<SurfaceSubstrateTallyData> stations =
              data[SurfaceSubstrateHeaderPage.keySurfaceSubstrateTalliesData]
                  as List<SurfaceSubstrateTallyData>;
          bool summaryComplete =
              data[SurfaceSubstrateHeaderPage.keySummaryComplete] as bool;

          return SurfaceSubstrateHeaderPage(
            ssh: ssh,
            stations: stations,
            summaryComplete: summaryComplete,
          );
        }),
  ],
);
