import 'package:survey_app/barrels/page_imports_barrel.dart';

class GroundPlotDisturbancePage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotDisturbance";
  final GoRouterState state;
  const GroundPlotDisturbancePage(this.state, {super.key});

  @override
  GroundPlotDisturbancePageState createState() =>
      GroundPlotDisturbancePageState();
}

class GroundPlotDisturbancePageState
    extends ConsumerState<GroundPlotDisturbancePage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
