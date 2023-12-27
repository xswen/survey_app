import 'package:survey_app/barrels/page_imports_barrel.dart';

class LargeTreePlotTreeInfoListPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotTreeInfoList";
  final GoRouterState state;
  const LargeTreePlotTreeInfoListPage(this.state, {super.key});

  @override
  LargeTreePlotTreeInfoListPageState createState() =>
      LargeTreePlotTreeInfoListPageState();
}

class LargeTreePlotTreeInfoListPageState
    extends ConsumerState<LargeTreePlotTreeInfoListPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
