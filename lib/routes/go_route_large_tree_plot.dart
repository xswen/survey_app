import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_site_tree_info_age_list_entry_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_site_tree_info_age_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_summary.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_info_list_entry_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_info_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_removed_list_entry_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_removed_list_page.dart';

import 'path_parameters/path_param_keys.dart';

GoRoute goRouteLargeTreePlot = GoRoute(
    name: LargeTreePlotSummaryPage.routeName,
    path: "large_tree_plot/:${PathParamsKeys.ltpSummaryId}",
    builder: (context, state) => LargeTreePlotSummaryPage(state),
    routes: [
      GoRoute(
          name: LargeTreePlotTreeInfoListPage.routeName,
          path: "tree_info_list/:${PathParamsKeys.ltpInfoListId}",
          builder: (context, state) => LargeTreePlotTreeInfoListPage(state),
          routes: [
            GoRoute(
                name: LargeTreePlotTreeInfoListEntryPage.routeName,
                path: "entry",
                builder: (context, state) =>
                    LargeTreePlotTreeInfoListEntryPage(state),
                routes: const []),
          ]),
      GoRoute(
          name: LargeTreePlotTreeRemovedListPage.routeName,
          path: "tree_removed_list/:${PathParamsKeys.ltpRemovedListId}",
          builder: (context, state) => LargeTreePlotTreeRemovedListPage(state),
          routes: [
            GoRoute(
                name: LargeTreePlotTreeRemovedListEntryPage.routeName,
                path: "entry",
                builder: (context, state) =>
                    LargeTreePlotTreeRemovedListEntryPage(state),
                routes: const []),
          ]),
      GoRoute(
          name: LargeTreePlotSiteTreeInfoAgeListPage.routeName,
          path: "tree_info_age_list/:${PathParamsKeys.ltpInfoAgeListId}",
          builder: (context, state) =>
              LargeTreePlotSiteTreeInfoAgeListPage(state),
          routes: [
            GoRoute(
                name: LargeTreePlotSiteTreeInfoAgeListEntryPage.routeName,
                path: "entry",
                builder: (context, state) =>
                    LargeTreePlotSiteTreeInfoAgeListEntryPage(state),
                routes: const []),
          ]),
    ]);
