import 'package:survey_app/barrels/page_imports_barrel.dart';

class EcologicalPlotSpeciesPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotSpecies";
  final GoRouterState state;
  const EcologicalPlotSpeciesPage(this.state, {super.key});

  @override
  EcologicalPlotSpeciesPageState createState() =>
      EcologicalPlotSpeciesPageState();
}

class EcologicalPlotSpeciesPageState
    extends ConsumerState<EcologicalPlotSpeciesPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
