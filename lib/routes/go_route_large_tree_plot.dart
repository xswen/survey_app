import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_site_tree_info_age_list_entry_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_site_tree_info_age_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_summary.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_info_list_entry_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_info_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_removed_list_entry_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_removed_list_page.dart';

GoRoute goRouteLargeTreePlot = GoRoute(
    name: LargeTreePlotSummaryPage.routeName,
    path: "large_tree_plot",
    builder: (context, state) => LargeTreePlotSummaryPage(state),
    routes: [
      GoRoute(
          name: LargeTreePlotTreeInfoListPage.routeName,
          path: "tree_info_list",
          builder: (context, state) => LargeTreePlotTreeInfoListPage(state),
          routes: [
            GoRoute(
                name: LargeTreePlotTreeInfoListEntryPage.routeName,
                path: "entry",
                builder: (context, state) =>
                    LargeTreePlotTreeInfoListEntryPage(state),
                routes: []),
          ]),
      GoRoute(
          name: LargeTreePlotTreeRemovedListPage.routeName,
          path: "tree_removed_list",
          builder: (context, state) => LargeTreePlotTreeRemovedListPage(state),
          routes: [
            GoRoute(
                name: LargeTreePlotTreeRemovedListEntryPage.routeName,
                path: "entry",
                builder: (context, state) =>
                    LargeTreePlotTreeRemovedListEntryPage(state),
                routes: []),
          ]),
      GoRoute(
          name: LargeTreePlotSiteTreeInfoAgeListPage.routeName,
          path: "tree_info_age_list",
          builder: (context, state) =>
              LargeTreePlotSiteTreeInfoAgeListPage(state),
          routes: [
            GoRoute(
                name: LargeTreePlotSiteTreeInfoAgeListEntryPage.routeName,
                path: "entry",
                builder: (context, state) =>
                    LargeTreePlotSiteTreeInfoAgeListEntryPage(state),
                routes: []),
          ]),
    ]);
