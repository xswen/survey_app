import 'package:survey_app/barrels/page_imports_barrel.dart';

class StumpPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "stumpPlotSummary";
  final GoRouterState state;
  const StumpPlotSummaryPage(this.state, {super.key});

  @override
  StumpPlotSummaryPageState createState() => StumpPlotSummaryPageState();
}

class StumpPlotSummaryPageState extends ConsumerState<StumpPlotSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
