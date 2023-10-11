import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/providers/providers.dart';
import 'package:survey_app/routes/router_routes_main.dart';

class WoodyDebrisSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "woodyDebrisSummary";
  final GoRouterState goRouterState;
  const WoodyDebrisSummaryPage(this.goRouterState, {super.key});

  @override
  WoodyDebrisSummaryPageState createState() => WoodyDebrisSummaryPageState();
}

class WoodyDebrisSummaryPageState
    extends ConsumerState<WoodyDebrisSummaryPage> {
  final String title = "Woody Debris";
  late final int wdId;
  late final FutureProvider<WoodyDebrisSummaryData> woodyDebrisProvider;
  late final FutureProvider<List<WoodyDebrisHeaderData>> transListProvider;

  @override
  void initState() {
    wdId = int.parse(
        widget.goRouterState.pathParameters[RouteParams.wdSummaryIdKey]!);
    woodyDebrisProvider = FutureProvider<WoodyDebrisSummaryData>((ref) => ref
        .read(databaseProvider)
        .woodyDebrisTablesDao
        .getWdSummary(int.parse(
            widget.goRouterState.pathParameters[RouteParams.surveyIdKey]!)));
    transListProvider = FutureProvider<List<WoodyDebrisHeaderData>>((ref) => ref
        .read(databaseProvider)
        .woodyDebrisTablesDao
        .getWdHeadersFromWdSId(int.parse(
            widget.goRouterState.pathParameters[RouteParams.wdSummaryIdKey]!)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<WoodyDebrisSummaryData> wdSummary =
        ref.watch(woodyDebrisProvider);
    AsyncValue<List<WoodyDebrisHeaderData>> transList =
        ref.watch(transListProvider);
    return const Placeholder();
  }
}
