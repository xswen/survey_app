import 'package:survey_app/barrels/page_imports_barrel.dart';

class LargeTreePlotSiteTreeInfoAgeListPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotSiteTreeInfoAgeList";
  final GoRouterState state;
  const LargeTreePlotSiteTreeInfoAgeListPage(this.state, {super.key});

  @override
  LargeTreePlotSiteTreeInfoAgeListPageState createState() =>
      LargeTreePlotSiteTreeInfoAgeListPageState();
}

class LargeTreePlotSiteTreeInfoAgeListPageState
    extends ConsumerState<LargeTreePlotSiteTreeInfoAgeListPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
