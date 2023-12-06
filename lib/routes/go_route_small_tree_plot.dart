import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/small_tree_plot/small_tree_plot_summary.dart';
import 'package:survey_app/pages/small_tree_plot/small_tree_species_entry_page.dart';

GoRoute goRouteSmallTreePlot = GoRoute(
    name: SmallTreePlotSummaryPage.routeName,
    path: "small_tree_plot",
    builder: (context, state) => SmallTreePlotSummaryPage(state),
    routes: [
      GoRoute(
          name: SmallTreeSpeciesEntryPage.routeName,
          path: "entry",
          builder: (context, state) => SmallTreeSpeciesEntryPage(state),
          routes: [])
    ]);
