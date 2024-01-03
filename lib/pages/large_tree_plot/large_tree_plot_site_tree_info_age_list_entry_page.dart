import 'package:survey_app/barrels/page_imports_barrel.dart';

class LargeTreePlotSiteTreeInfoAgeListEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotSiteTreeInfoAgeListEntry";
  final GoRouterState state;
  const LargeTreePlotSiteTreeInfoAgeListEntryPage(this.state, {super.key});

  @override
  LargeTreePlotSiteTreeInfoAgeListEntryPageState createState() =>
      LargeTreePlotSiteTreeInfoAgeListEntryPageState();
}

class LargeTreePlotSiteTreeInfoAgeListEntryPageState
    extends ConsumerState<LargeTreePlotSiteTreeInfoAgeListEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
