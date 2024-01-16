import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_entry_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_origin_entry_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_origin_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_site_info_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_summary_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_treatment_entry_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_treatment_page.dart';

GoRoute goRouteGroundPlot = GoRoute(
    name: GroundPlotSummaryPage.routeName,
    path: "ground_plot",
    builder: (context, state) => GroundPlotSummaryPage(state),
    routes: [
      GoRoute(
          name: GroundPlotSiteInfoPage.routeName,
          path: "site_info",
          builder: (context, state) => GroundPlotSiteInfoPage(state)),
      GoRoute(
        name: GroundPlotDisturbancePage.routeName,
        path: "disturbance",
        builder: (context, state) => GroundPlotDisturbancePage(state),
        routes: [
          GoRoute(
            name: GroundPlotDisturbanceEntryPage.routeName,
            path: "entry_page",
            builder: (context, state) => GroundPlotDisturbanceEntryPage(state),
          ),
        ],
      ),
      GoRoute(
          name: GroundPlotOriginPage.routeName,
          path: "origin",
          builder: (context, state) => GroundPlotOriginPage(state),
          routes: [
            GoRoute(
              name: GroundPlotOriginEntryPage.routeName,
              path: "entry_page",
              builder: (context, state) => GroundPlotOriginEntryPage(state),
            ),
          ]),
      GoRoute(
          name: GroundPlotTreatmentPage.routeName,
          path: "treatment",
          builder: (context, state) => GroundPlotTreatmentPage(state),
          routes: [
            GoRoute(
              name: GroundPlotTreatmentEntryPage.routeName,
              path: "entry_page",
              builder: (context, state) => GroundPlotTreatmentEntryPage(state),
            ),
          ]),
    ]);
