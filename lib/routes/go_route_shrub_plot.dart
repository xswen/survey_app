import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/shrub_plot/shrub_plot_species_entry_page.dart';
import 'package:survey_app/pages/shrub_plot/shrub_plot_summary.dart';

GoRoute goRouteShrubPlot = GoRoute(
    name: ShrubPlotSummaryPage.routeName,
    path: "shrub_plot",
    builder: (context, state) => ShrubPlotSummaryPage(state),
    routes: [
      GoRoute(
          name: ShrubPlotSpeciesEntryPage.routeName,
          path: "shrub_plot",
          builder: (context, state) => ShrubPlotSpeciesEntryPage(state),
          routes: [])
    ]);
