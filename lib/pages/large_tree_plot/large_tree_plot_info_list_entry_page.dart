import 'package:survey_app/barrels/page_imports_barrel.dart';

class LargeTreePlotInfoListEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotInfoListEntry";
  final GoRouterState state;
  const LargeTreePlotInfoListEntryPage(this.state, {super.key});

  @override
  LargeTreePlotInfoListEntryPageState createState() =>
      LargeTreePlotInfoListEntryPageState();
}

class LargeTreePlotInfoListEntryPageState
    extends ConsumerState<LargeTreePlotInfoListEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
