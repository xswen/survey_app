import 'package:survey_app/barrels/page_imports_barrel.dart';

class LargeTreePlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotSummary";
  final GoRouterState state;
  const LargeTreePlotSummaryPage(this.state, {super.key});

  @override
  LargeTreePlotSummaryPageState createState() =>
      LargeTreePlotSummaryPageState();
}

class LargeTreePlotSummaryPageState
    extends ConsumerState<LargeTreePlotSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
