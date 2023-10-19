import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/providers/surface_substrate_providers.dart';
import 'package:survey_app/widgets/popups/popup_create_transect.dart';

import '../../widgets/date_select.dart';
import '../../widgets/tile_cards/tile_card_selection.dart';

class SurfaceSubstrateSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "surfaceSubstrateSummary";
  final GoRouterState state;
  const SurfaceSubstrateSummaryPage(this.state, {super.key});

  @override
  SurfaceSubstrateSummaryPageState createState() =>
      SurfaceSubstrateSummaryPageState();
}

class SurfaceSubstrateSummaryPageState
    extends ConsumerState<SurfaceSubstrateSummaryPage> {
  final String title = "Surface Substrate";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int ssId;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    ssId = PathParamValue.getSsSummaryId(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    super.initState();
  }

  Future<void> updateSsSummary(SurfaceSubstrateSummaryCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.surfaceSubstrateSummary)..where((t) => t.id.equals(ssId)))
        .write(entry);
    ref.refresh(ssDataProvider(surveyId));
  }

  void createTransect() {
    final db = ref.read(databaseProvider);
    SurfaceSubstrateHeaderCompanion sshC = SurfaceSubstrateHeaderCompanion(
        ssId: d.Value(ssId), complete: const d.Value(false));

    Popups.show(
        context,
        PopupCreateTransect(
          getUsedTransNums: db.surfaceSubstrateTablesDao.getUsedTransNums(ssId),
          selectedItem: db.companionValueToStr(sshC.transNum),
          transList: kTransectNumsList,
          updateTransNum: (int transNum) =>
              sshC = sshC.copyWith(transNum: d.Value(transNum)),
          onSave: () => db.surfaceSubstrateTablesDao
              .addSsHeader(sshC)
              .then((sshId) => print("working'")),
        ));
  }

  //TODO: fill out
  void goToSshPage(int sshId) => null;

  SurveyStatus getStatus(SurfaceSubstrateHeaderData data) {
    if (data.complete) return SurveyStatus.complete;
    if (data.transNum == null) return SurveyStatus.notStarted;
    return SurveyStatus.inProgress;
  }

  bool checkHeadersComplete(List<SurfaceSubstrateHeaderData> transList) {
    for (int i = 0; i < transList.length; i++) {
      if (!transList[i].complete) return false;
    }
    return true;
  }

  void markComplete(SurfaceSubstrateSummaryData ss,
      List<SurfaceSubstrateHeaderData> transList) {
    final db = ref.read(databaseProvider);

    db.surveyInfoTablesDao.getSurvey(surveyId).then((value) {
      bool surveyComplete = value.complete;
      if (surveyComplete) {
        Popups.show(context, surveyCompleteWarningPopup);
      } else if (ss.complete) {
        updateSsSummary(
            const SurfaceSubstrateSummaryCompanion(complete: d.Value(false)));
      } else if (transList.isEmpty) {
        Popups.showMissingTransect(context);
      } else {
        checkHeadersComplete(transList)
            ? updateSsSummary(
                const SurfaceSubstrateSummaryCompanion(complete: d.Value(true)))
            : Popups.showIncompleteTransect(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    AsyncValue<SurfaceSubstrateSummaryData> ssSummary =
        ref.watch(ssDataProvider(surveyId));
    AsyncValue<List<SurfaceSubstrateHeaderData>> transList =
        ref.watch(ssTransListProvider(ssId));

    return Scaffold(
        appBar: OurAppBar(title),
        endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
        body: Center(
          child: ssSummary.when(
            error: (err, stack) => Text("Error: $err"),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (ss) => Column(
              children: [
                CalendarSelect(
                  date: ss.measDate,
                  label: "Enter Measurement Date",
                  readOnly: ss.complete,
                  readOnlyPopup: completeWarningPopup,
                  setStateFn: (DateTime date) async => updateSsSummary(
                      SurfaceSubstrateSummaryCompanion(
                          measDate: d.Value(date))),
                ),
                const SizedBox(height: kPaddingV),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      kPaddingH, 0, kPaddingH, kPaddingV / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Select a Transect to enter data for:",
                        style: TextStyle(fontSize: kTextHeaderSize),
                      ),
                      ElevatedButton(
                          onPressed: () => createTransect(),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: kPaddingH),
                                child: Icon(
                                  FontAwesomeIcons.circlePlus,
                                  size: 20,
                                ),
                              ),
                              Text("Add transect")
                            ],
                          )),
                    ],
                  ),
                ),
                Expanded(
                    child: transList.when(
                  data: (transList) {
                    return Scaffold(
                      floatingActionButton: FloatingCompleteButton(
                        title: title,
                        complete: ss.complete,
                        onPressed: () => markComplete(ss, transList),
                      ),
                      body: transList.isEmpty
                          ? const Center(
                              child: Text(
                                  "No transects created. Please add transect."))
                          : ListView.builder(
                              itemCount: transList.length,
                              itemBuilder: (BuildContext cxt, int index) {
                                SurfaceSubstrateHeaderData header =
                                    transList[index];
                                return TileCardSelection(
                                    title: "Transect ${header.transNum}",
                                    onPressed: () async {
                                      ss.complete
                                          ? Popups.show(
                                              context,
                                              Popups
                                                  .generateNoticeSurveyComplete(
                                                "Woody Debris",
                                                () => goToSshPage(header.id),
                                              ))
                                          : goToSshPage(header.id);
                                    },
                                    status: getStatus(header));
                              }),
                    );
                  },
                  error: (err, stack) => Text("Error: $err"),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                )),
              ],
            ),
          ),
        ));
  }
}
