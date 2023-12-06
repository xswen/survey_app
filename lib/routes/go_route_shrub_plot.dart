import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/shrub_plot/shrub_plot_summary.dart';

GoRoute goRouteShrubPlot = GoRoute(
    name: ShrubPlotSummaryPage.routeName,
    path: "shrub_plot",
    builder: (context, state) => ShrubPlotSummaryPage(state),
    routes: []);
