import 'package:go_router/go_router.dart';

import '../pages/micro_plot/micro_plot_summary.dart';

GoRoute goRouteMicroPlot = GoRoute(
    name: MicroPlotSummaryPage.routeName,
    path: "microplot",
    builder: (context, state) => MicroPlotSummaryPage(state),
    routes: const [
      // GoRoute(
      //     name: ShrubPlotSpeciesEntryPage.routeName,
      //     path: "entry",
      //     builder: (context, state) => ShrubPlotSpeciesEntryPage(state),
      //     routes: [])
    ]);
