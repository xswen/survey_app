import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_origin_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_site_info_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_treatment_page.dart';

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
      appBar: const OurAppBar("Ground Plot Info Summary"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Site Info"),
              onPressed: () {
                context.pushNamed(GroundPlotSiteInfoPage.routeName,
                    pathParameters: widget.state.pathParameters);
              },
            ),
            ElevatedButton(
              child: const Text("Disturbance"),
              onPressed: () {
                context.pushNamed(GroundPlotDisturbancePage.routeName,
                    pathParameters: widget.state.pathParameters);
              },
            ),
            ElevatedButton(
              child: const Text("Tree Cover Origin"),
              onPressed: () {
                context.pushNamed(GroundPlotOriginPage.routeName,
                    pathParameters: widget.state.pathParameters);
              },
            ),
            ElevatedButton(
              child: const Text("Plot Treatment and Activity"),
              onPressed: () {
                context.pushNamed(GroundPlotTreatmentPage.routeName,
                    pathParameters: widget.state.pathParameters);
              },
            ),
          ],
        ),
      )),
    );
  }
}
