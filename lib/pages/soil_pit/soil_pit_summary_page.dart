import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_feature_page.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_horizon_description_page.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_site_info_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:survey_app/widgets/buttons/icon_nav_button.dart';

import '../../providers/survey_info_providers.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/popups/popup_marked_complete.dart';

class SoilPitSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitSummary";
  final GoRouterState state;

  const SoilPitSummaryPage(this.state, {super.key});

  @override
  SoilPitSummaryPageState createState() => SoilPitSummaryPageState();
}

class SoilPitSummaryPageState extends ConsumerState<SoilPitSummaryPage> {
  final String title = "Soil Pit";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss popupSurveyComplete =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int spId;
  late bool parentComplete = false;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    spId = PathParamValue.getSoilPitSummaryId(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    _loadData();

    super.initState();
  }

  void _loadData() async {
    final survey =
        await Database.instance.surveyInfoTablesDao.getSurvey(surveyId);

    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        parentComplete = survey.complete;
      });
    }
  }

  void navToSiteInfo() => ref
          .read(databaseProvider)
          .soilPitTablesDao
          .getSiteInfoFromSummaryId(spId)
          .then((value) {
        SoilSiteInfoCompanion data =
            SoilSiteInfoCompanion(soilPitSummaryId: d.Value(spId));
        if (value != null) {
          data = value.toCompanion(true);
        }
        context.pushNamed(SoilPitSiteInfoPage.routeName,
            pathParameters: PathParamGenerator.soilPitSummary(
                widget.state, spId.toString()),
            extra: data);
      });

  void navToFeature() => context.pushNamed(SoilPitFeaturePage.routeName,
      pathParameters:
          PathParamGenerator.soilPitSummary(widget.state, spId.toString()));

  void navToHorizon() =>
      context.pushNamed(SoilPitHorizonDescriptionPage.routeName,
          pathParameters:
              PathParamGenerator.soilPitSummary(widget.state, spId.toString()));

  Future<void> updateSpSummary(SoilPitSummaryCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.soilPitSummary)..where((t) => t.id.equals(spId)))
        .write(entry);
    ref.refresh(soilSummaryDataProvider(spId));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    AsyncValue<SoilPitSummaryData> spSummary =
        ref.watch(soilSummaryDataProvider(spId));

    return spSummary.when(
      error: (err, stack) => Text("Error: $err"),
      loading: () => DefaultPageLoadingScaffold(title: title),
      data: (spSummary) {
        void markComplete() {
          if (parentComplete) {
            Popups.show(context, popupSurveyComplete);
            return;
          }

          spSummary.complete
              ? updateSpSummary(
                  const SoilPitSummaryCompanion(complete: d.Value(false)))
              : db.soilPitTablesDao
                  .getSiteInfoFromSummaryId(spId)
                  .then((value) {
                  if (value == null) {
                    Popups.show(
                        context,
                        const PopupDismiss(
                          "Error: Soil Pit Site Info",
                          contentText:
                              "Soil site info needs to be filled out before soil pit can be marked complete.",
                        ));
                  } else {
                    updateSpSummary(SoilPitSummaryCompanion(
                        complete: d.Value(!spSummary.complete)));
                    Popups.show(context, PopupMarkedComplete(title: title));
                  }
                });
        }

        return Scaffold(
          appBar: OurAppBar(
            title,
            complete: spSummary.complete,
            backFn: () {
              ref.refresh(updateSurveyCardProvider(surveyId));
              context.pop();
            },
          ),
          endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
          bottomNavigationBar: MarkCompleteButton(
              title: title,
              complete: spSummary.complete,
              onPressed: () => markComplete()),
          body: Column(
            children: [
              CalendarSelect(
                date: spSummary.measDate,
                label: "Enter Measurement Date",
                readOnly: spSummary.complete,
                readOnlyPopup: completeWarningPopup,
                onDateSelected: (DateTime date) async => updateSpSummary(
                    SoilPitSummaryCompanion(measDate: d.Value(date))),
              ),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.file),
                space: kPaddingIcon,
                label: "Soil Pit Site Info",
                onPressed: () {
                  navToSiteInfo();
                },
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingV, horizontal: kPaddingH),
              ),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.objectGroup),
                space: kPaddingIcon,
                label: "Soil Pit Feature",
                onPressed: () async {
                  navToFeature();
                },
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingV, horizontal: kPaddingH),
              ),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.mountain),
                space: kPaddingIcon,
                label: "Pit Horizon Description",
                onPressed: () async {
                  navToHorizon();
                },
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingV, horizontal: kPaddingH),
              ),
            ],
          ),
        );
      },
    );
  }
}
