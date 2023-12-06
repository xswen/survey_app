import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/small_tree_plot/small_tree_plot_summary.dart';

GoRoute goRouteSmallTreePlot = GoRoute(
    name: SmallTreePlotSummaryPage.routeName,
    path: "small_tree_plot",
    builder: (context, state) => SmallTreePlotSummaryPage(state),
    routes: []);
