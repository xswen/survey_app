import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_summary.dart';

GoRoute goRouteLargeTreePlot = GoRoute(
    name: LargeTreePlotSummaryPage.routeName,
    path: "large_tree_plot",
    builder: (context, state) => LargeTreePlotSummaryPage(state),
    routes: []);
