import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_origin_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_site_info_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_treatment_page.dart';
import 'package:survey_app/widgets/buttons/icon_nav_button.dart';

import '../../providers/survey_info_providers.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/text/text_header_separator.dart';

class GroundPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotSummary";
  final GoRouterState state;
  const GroundPlotSummaryPage(this.state, {super.key});

  @override
  GroundPlotSummaryPageState createState() => GroundPlotSummaryPageState();
}

class GroundPlotSummaryPageState extends ConsumerState<GroundPlotSummaryPage> {
  late final int surveyId;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Ground Plot Info Summary",
        backFn: () {
          ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      bottomNavigationBar: MarkCompleteButton(
        title: "Ground Plot Info Summary",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            CalendarSelect(
              date: DateTime.now(),
              label: "Enter Measurement Date",
              readOnly: false,
              // readOnlyPopup: completeWarningPopup,
              onDateSelected: (DateTime date) async => null,
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.info),
              label: 'Site Info',
              onPressed: () {
                context.pushNamed(GroundPlotSiteInfoPage.routeName,
                    pathParameters: widget.state.pathParameters);
              },
            ),
            IconNavButton(
              label: 'Disturbance',
              icon: const Icon(FontAwesomeIcons.fire),
              onPressed: () {
                context.pushNamed(GroundPlotDisturbancePage.routeName,
                    pathParameters: widget.state.pathParameters);
              },
            ),
            IconNavButton(
              label: 'Tree Cover Origin',
              icon: const Icon(FontAwesomeIcons.tree),
              onPressed: () {
                context.pushNamed(GroundPlotOriginPage.routeName,
                    pathParameters: widget.state.pathParameters);
              },
            ),
            IconNavButton(
              label: 'Plot Treatment and Activity',
              icon: const Icon(FontAwesomeIcons.file),
              onPressed: () {
                context.pushNamed(GroundPlotTreatmentPage.routeName,
                    pathParameters: widget.state.pathParameters);
              },
            ),
            const TextHeaderSeparator(title: "User information and Comments"),
            const Text("TODO: Add Comment Box")
          ],
        ),
      )),
    );
  }
}
