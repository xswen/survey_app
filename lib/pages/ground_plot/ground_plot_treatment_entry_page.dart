import 'package:survey_app/barrels/page_imports_barrel.dart';

class GroundPlotTreatmentEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotTreatmentEntry";
  final GoRouterState state;
  const GroundPlotTreatmentEntryPage(this.state, {super.key});

  @override
  GroundPlotTreatmentEntryPageState createState() =>
      GroundPlotTreatmentEntryPageState();
}

class GroundPlotTreatmentEntryPageState
    extends ConsumerState<GroundPlotTreatmentEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar("Title"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ElevatedButton(
          child: const Text("tmp"),
          onPressed: () {},
        ),
      )),
    );
  }
}
