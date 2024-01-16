import 'package:survey_app/barrels/page_imports_barrel.dart';

class GroundPlotTreatmentPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotTreatment";
  final GoRouterState state;
  const GroundPlotTreatmentPage(this.state, {super.key});

  @override
  GroundPlotTreatmentPageState createState() => GroundPlotTreatmentPageState();
}

class GroundPlotTreatmentPageState
    extends ConsumerState<GroundPlotTreatmentPage> {
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
