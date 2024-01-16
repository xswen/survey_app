import 'package:survey_app/barrels/page_imports_barrel.dart';

class GroundPlotDisturbanceEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotDisturbanceEntry";
  final GoRouterState state;
  const GroundPlotDisturbanceEntryPage(this.state, {super.key});

  @override
  GroundPlotDisturbanceEntryPageState createState() =>
      GroundPlotDisturbanceEntryPageState();
}

class GroundPlotDisturbanceEntryPageState
    extends ConsumerState<GroundPlotDisturbanceEntryPage> {
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
