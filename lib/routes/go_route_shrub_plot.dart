import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/shrub_plot/shrub_plot_species_entry_page.dart';
import 'package:survey_app/pages/shrub_plot/shrub_plot_summary.dart';

import 'path_parameters/path_param_keys.dart';

GoRoute goRouteShrubPlot = GoRoute(
    name: ShrubPlotSummaryPage.routeName,
    path: "shrub_plot/:${PathParamsKeys.shrubSummaryId}",
    builder: (context, state) => ShrubPlotSummaryPage(state),
    routes: [
      GoRoute(
          name: ShrubPlotSpeciesEntryPage.routeName,
          path: "species/:${PathParamsKeys.shrubSpeciesId}",
          builder: (context, state) => ShrubPlotSpeciesEntryPage(state),
          routes: [])
    ]);
