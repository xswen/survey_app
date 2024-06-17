import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/stump_plot/stump_plot_species_entry_page.dart';
import 'package:survey_app/pages/stump_plot/stump_plot_summary_page.dart';

import 'path_parameters/path_param_keys.dart';

GoRoute goRouteStumpPlot = GoRoute(
    name: StumpPlotSummaryPage.routeName,
    path: "stump_plot/:${PathParamsKeys.stumpSummaryId}",
    builder: (context, state) => StumpPlotSummaryPage(state),
    routes: [
      GoRoute(
          name: StumpPlotSpeciesEntryPage.routeName,
          path: "species",
          builder: (context, state) => StumpPlotSpeciesEntryPage(state),
          routes: const [])
    ]);
