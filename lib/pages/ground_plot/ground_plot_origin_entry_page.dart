import 'package:survey_app/barrels/page_imports_barrel.dart';

class GroundPlotOriginEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotOriginEntry";
  final GoRouterState state;
  const GroundPlotOriginEntryPage(this.state, {super.key});

  @override
  GroundPlotOriginEntryPageState createState() =>
      GroundPlotOriginEntryPageState();
}

class GroundPlotOriginEntryPageState
    extends ConsumerState<GroundPlotOriginEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
