import 'package:survey_app/barrels/page_imports_barrel.dart';

class GroundPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotSummary";
  final GoRouterState state;
  const GroundPlotSummaryPage(this.state, {super.key});

  @override
  GroundPlotSummaryPageState createState() => GroundPlotSummaryPageState();
}

class GroundPlotSummaryPageState extends ConsumerState<GroundPlotSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar("Ground Plot Info Summary"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ElevatedButton(
          child: Text("tmp"),
          onPressed: () {},
        ),
      )),
    );
  }
}
