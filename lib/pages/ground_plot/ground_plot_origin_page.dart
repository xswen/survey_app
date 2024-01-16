import 'package:survey_app/barrels/page_imports_barrel.dart';

class GroundPlotOriginPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotOrigin";
  final GoRouterState state;
  const GroundPlotOriginPage(this.state, {super.key});

  @override
  GroundPlotOriginPageState createState() => GroundPlotOriginPageState();
}

class GroundPlotOriginPageState extends ConsumerState<GroundPlotOriginPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
