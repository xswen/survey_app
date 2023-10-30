import 'package:survey_app/barrels/page_imports_barrel.dart';

class EcologicalPlotHeaderPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotHeader";
  final GoRouterState state;
  const EcologicalPlotHeaderPage(this.state, {super.key});

  @override
  EcologicalPlotHeaderPageState createState() =>
      EcologicalPlotHeaderPageState();
}

class EcologicalPlotHeaderPageState
    extends ConsumerState<EcologicalPlotHeaderPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
