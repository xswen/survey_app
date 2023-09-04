import 'package:go_router/go_router.dart';

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
);
