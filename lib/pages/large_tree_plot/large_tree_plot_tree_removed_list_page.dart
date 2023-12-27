import 'package:survey_app/barrels/page_imports_barrel.dart';

class LargeTreePlotTreeRemovedListPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotTreeRemovedList";
  final GoRouterState state;
  const LargeTreePlotTreeRemovedListPage(this.state, {super.key});

  @override
  LargeTreePlotTreeRemovedListPageState createState() =>
      LargeTreePlotTreeRemovedListPageState();
}

class LargeTreePlotTreeRemovedListPageState
    extends ConsumerState<LargeTreePlotTreeRemovedListPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
