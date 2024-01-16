import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_entry_page.dart';

class GroundPlotDisturbancePage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotDisturbance";
  final GoRouterState state;
  const GroundPlotDisturbancePage(this.state, {super.key});

  @override
  GroundPlotDisturbancePageState createState() =>
      GroundPlotDisturbancePageState();
}

class GroundPlotDisturbancePageState
    extends ConsumerState<GroundPlotDisturbancePage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar("Natural Disturbance to Plot Vegetation"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ElevatedButton(
          child: const Text("tmp"),
          onPressed: () {
            context.pushNamed(GroundPlotDisturbanceEntryPage.routeName,
                pathParameters: widget.state.pathParameters);
          },
        ),
      )),
    );
  }
}
