import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/ecological_plot/ecological_plot_header_page.dart';
import 'package:survey_app/pages/ecological_plot/ecological_plot_summary_page.dart';
import 'package:survey_app/routes/path_parameters/path_param_keys.dart';

GoRoute goRouteEcp = GoRoute(
    name: EcologicalPlotSummaryPage.routeName,
    path: "ecological_plot/:${PathParamsKeys.ecpSummaryId}",
    builder: (context, state) => EcologicalPlotSummaryPage(state),
    routes: [
      GoRoute(
          name: EcologicalPlotHeaderPage.routeName,
          path: "header/:${PathParamsKeys.ecpHeaderId}",
          builder: (context, state) => EcologicalPlotHeaderPage(state),
          routes: const [])
    ]);
