import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';

import '../../providers/survey_info_providers.dart';
import '../../widgets/date_select.dart';

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
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int spId;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    spId = PathParamValue.getSoilPitSummary(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    super.initState();
  }

  Future<void> updateSpSummary(SoilPitSummaryCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.soilPitSummary)..where((t) => t.id.equals(spId)))
        .write(entry);
    ref.refresh(soilSiteInfoDataProvider(surveyId));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    AsyncValue<SoilPitSummaryData> spSummary =
        ref.watch(soilSiteInfoDataProvider(surveyId));

    return Scaffold(
      appBar: OurAppBar(
        title,
        backFn: () {
          ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: spSummary.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (spSummary) => Column(
          children: [
            CalendarSelect(
              date: spSummary.measDate,
              label: "Enter Measurement Date",
              readOnly: spSummary.complete,
              readOnlyPopup: completeWarningPopup,
              setStateFn: (DateTime date) async => updateSpSummary(
                  SoilPitSummaryCompanion(measDate: d.Value(date))),
            ),
          ],
        ),
      )),
    );
  }
}
