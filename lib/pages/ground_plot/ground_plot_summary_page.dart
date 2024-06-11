import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_origin_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_site_info_page.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_treatment_page.dart';
import 'package:survey_app/widgets/buttons/icon_nav_button.dart';

import '../../providers/survey_info_providers.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/popups/popup_marked_complete.dart';
import '../../widgets/text/text_header_separator.dart';

class GroundPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotSummary";
  final GoRouterState state;

  const GroundPlotSummaryPage(this.state, {super.key});

  @override
  GroundPlotSummaryPageState createState() => GroundPlotSummaryPageState();
}

class GroundPlotSummaryPageState extends ConsumerState<GroundPlotSummaryPage> {
  final String title = "Ground Plot Summary";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss popupSurveyComplete =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int gpId;
  late bool parentComplete = false;
  late GpSummaryCompanion gpS = const GpSummaryCompanion();

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    gpId = PathParamValue.getGpSummaryId(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    _loadData();

    super.initState();
  }

  void _loadData() async {
    final survey =
        await Database.instance.surveyInfoTablesDao.getSurvey(surveyId);
    final GpSummaryData data = await Database.instance.siteInfoTablesDao
        .getGpSummaryBySurveyId(surveyId);

    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        parentComplete = survey.complete;
        gpS = data.toCompanion(true);
      });
    }
  }

  void navToSiteInfo() => ref
          .read(databaseProvider)
          .siteInfoTablesDao
          .getGpSiteInfoFromSummaryId(gpId)
          .then((value) {
        GpSiteInfoCompanion data =
            GpSiteInfoCompanion(gpSummaryId: d.Value(gpId));

        if (value != null) {
          data = value.toCompanion(true);
        }

        context.pushNamed(GroundPlotSiteInfoPage.routeName,
            pathParameters: widget.state.pathParameters, extra: data);
      });

  void navToDisturbance() => context.pushNamed(
        GroundPlotDisturbancePage.routeName,
        pathParameters: widget.state.pathParameters,
      );

  void navToOrigin() => context.pushNamed(
        GroundPlotOriginPage.routeName,
        pathParameters: widget.state.pathParameters,
      );

  void navToTreatment() => context.pushNamed(
        GroundPlotTreatmentPage.routeName,
        pathParameters: widget.state.pathParameters,
      );

  void updateSummary(GpSummaryCompanion entry) {
    final db = ref.read(databaseProvider);

    (db.update(db.gpSummary)..where((t) => t.id.equals(gpId)))
        .write(entry)
        .then((value) => setState(() => gpS = entry));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    void markComplete() {
      if (parentComplete) {
        Popups.show(context, popupSurveyComplete);
        return;
      }

      gpS.complete.value
          ? updateSummary(gpS.copyWith(complete: const d.Value(false)))
          : db.siteInfoTablesDao.getGpSiteInfoFromSummaryId(gpId).then((value) {
              if (value == null) {
                Popups.show(
                    context,
                    const PopupDismiss(
                      "Error: Ground Plot Site Info",
                      contentText:
                          "Ground plot site info needs to be filled out before "
                          "this can be marked complete.",
                    ));
              } else {
                updateSummary(gpS.copyWith(complete: const d.Value(true)));
                Popups.show(context, PopupMarkedComplete(title: title));
              }
            });
    }

    return db.companionValueToStr(gpS.id).isEmpty
        ? DefaultPageLoadingScaffold(title: title)
        : Scaffold(
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
              onPressed: markComplete,
            ),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
              child: ListView(
                children: [
                  CalendarSelect(
                    date: gpS.measDate.value,
                    label: "Enter Measurement Date",
                    readOnly: gpS.complete.value,
                    readOnlyPopup: completeWarningPopup,
                    onDateSelected: (DateTime date) async =>
                        updateSummary(gpS.copyWith(measDate: d.Value(date))),
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
                  const TextHeaderSeparator(
                      title: "User information and Comments"),
                  const Text("TODO: Add Comment Box")
                ],
              ),
            )),
          );
  }
}
