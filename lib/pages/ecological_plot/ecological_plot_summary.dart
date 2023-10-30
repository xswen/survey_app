import 'package:survey_app/barrels/page_imports_barrel.dart';

class EcologicalPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotSummary";
  final GoRouterState state;
  const EcologicalPlotSummaryPage(this.state, {super.key});

  @override
  EcologicalPlotSummaryPageState createState() =>
      EcologicalPlotSummaryPageState();
}

class EcologicalPlotSummaryPageState
    extends ConsumerState<EcologicalPlotSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
