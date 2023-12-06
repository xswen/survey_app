import 'package:survey_app/barrels/page_imports_barrel.dart';

class StumpPlotSpeciesEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "stumpPlotSpeciesEntry";
  final GoRouterState state;
  const StumpPlotSpeciesEntryPage(this.state, {super.key});

  @override
  StumpPlotSpeciesEntryPageState createState() =>
      StumpPlotSpeciesEntryPageState();
}

class StumpPlotSpeciesEntryPageState
    extends ConsumerState<StumpPlotSpeciesEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
