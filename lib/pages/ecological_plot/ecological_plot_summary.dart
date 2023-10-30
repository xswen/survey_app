import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/providers/ecological_plot_providers.dart';

import '../../providers/survey_info_providers.dart';
import '../../widgets/builders/set_transect_num_builder.dart';
import '../../widgets/date_select.dart';
import '../../widgets/tile_cards/tile_card_selection.dart';

class EcologicalPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotSummary";
  final GoRouterState state;
  const EcologicalPlotSummaryPage(this.state, {super.key});

  @override
  EcologicalPlotSummaryPageState createState() =>
      EcologicalPlotSummaryPageState();
}

class EcologicalPlotSummaryPageState
    extends ConsumerState<EcologicalPlotSummaryPage> {
  final String title = "Ecological Plot";
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int ecpId;
  late final PopupDismiss completeWarningPopup;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    ecpId = PathParamValue.getEcpSummaryId(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    super.initState();
  }

  Future<void> updateEcpSummary(EcpSummaryCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.ecpSummary)..where((t) => t.id.equals(ecpId))).write(entry);
    ref.refresh(ecpDataProvider(surveyId));
  }

  void createTransect() {
    final db = ref.read(databaseProvider);
    EcpHeaderCompanion ecpHCompanion = EcpHeaderCompanion(
        ecpSummaryId: d.Value(ecpId), complete: const d.Value(false));

    Popups.show(
        context,
        PopupContinue(
          "Select Transect Number",
          contentWidget: Card(
            elevation: 0,
            color: Colors.transparent,
            child: SetTransectNumBuilder(
              name: "",
              getUsedTransNums:
                  db.ecologicalPlotTablesDao.getUsedTransNums(ecpId),
              startingTransNum: '',
              selectedItem: db.companionValueToStr(ecpHCompanion.ecpNum),
              transList: kTransectNumsList,
              updateTransNum: (int transNum) => ecpHCompanion =
                  ecpHCompanion.copyWith(ecpNum: d.Value(transNum)),
            ),
          ),
          rightBtnOnPressed: () => db.ecologicalPlotTablesDao
              .addHeader(ecpHCompanion)
              .then((wdhId) async {
            context.pop();
            //TODO: add go to page
            //goToWdhPage(wdhId);
          }),
        ));
  }

  //TODO: Implement
  // void goToEcpHPage(int ecpHId) => context
  //     .pushNamed(WoodyDebrisHeaderPage.routeName,
  //     pathParameters: PathParamGenerator.wdHeader(
  //         widget.goRouterState, wdhId.toString()))
  //     .then((value) {
  //   ref.refresh(wdTransListProvider(wdId));
  //   ref.refresh(wdDataProvider(surveyId));
  // });

  SurveyStatus getStatus(EcpHeaderData ecpH) {
    if (ecpH.complete) return SurveyStatus.complete;
    if (ecpH.ecpNum == null) return SurveyStatus.notStarted;
    return SurveyStatus.inProgress;
  }

  bool checkHeadersComplete(List<EcpHeaderData> transList) {
    for (int i = 0; i < transList.length; i++) {
      if (!transList[i].complete) return false;
    }
    return true;
  }

  void markComplete(EcpSummaryData ecp, List<EcpHeaderData> transList) {
    final db = ref.read(databaseProvider);

    db.surveyInfoTablesDao.getSurvey(ecp.surveyId).then((value) {
      bool surveyComplete = value.complete;
      if (surveyComplete) {
        Popups.show(context, surveyCompleteWarningPopup);
      } else if (ecp.complete) {
        updateEcpSummary(const EcpSummaryCompanion(complete: d.Value(false)));
      } else if (transList.isEmpty) {
        Popups.showMissingTransect(context);
      } else {
        checkHeadersComplete(transList)
            ? updateEcpSummary(
                const EcpSummaryCompanion(complete: d.Value(true)))
            : Popups.showIncompleteTransect(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    AsyncValue<EcpSummaryData> ecpSummary = ref.watch(ecpDataProvider(ecpId));
    AsyncValue<List<EcpHeaderData>> transList =
        ref.watch(ecpTransListProvider(ecpId));

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
        child: ecpSummary.when(
            error: (err, stack) => Text("Error: $err"),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (ecp) => Column(
                  children: [
                    CalendarSelect(
                      date: ecp.measDate,
                      label: "Enter Measurement Date",
                      readOnly: ecp.complete,
                      readOnlyPopup: completeWarningPopup,
                      setStateFn: (DateTime date) async => updateEcpSummary(
                          EcpSummaryCompanion(measDate: d.Value(date))),
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
                              onPressed: () => null,
                              // context.pushNamed(
                              //     WoodyDebrisHeaderMeasurementsPage.routeName,
                              //     pathParameters: PathParamGenerator.wdHeader(
                              //         widget.goRouterState, kParamMissing)),
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
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: transList.when(
                      data: (transList) {
                        return Scaffold(
                          floatingActionButton: FloatingCompleteButton(
                            title: title,
                            complete: ecp.complete,
                            onPressed: () => markComplete(ecp, transList),
                          ),
                          body: transList.isEmpty
                              ? const Center(
                                  child: Text(
                                      "No transects created. Please add transect."))
                              : ListView.builder(
                                  itemCount: transList.length,
                                  itemBuilder: (BuildContext cxt, int index) {
                                    EcpHeaderData ecpH = transList[index];
                                    return TileCardSelection(
                                        title: "Transect ${ecpH.ecpNum}",
                                        onPressed: () async {
                                          ecp.complete
                                              ? Popups.show(
                                                  context,
                                                  Popups
                                                      .generateNoticeSurveyComplete(
                                                    "Woody Debris",
                                                    () =>
                                                        null, //goToWdhPage(wdh.id),
                                                  ))
                                              : null; //goToWdhPage(wdh.id);
                                        },
                                        status: getStatus(ecpH));
                                  }),
                        );
                      },
                      error: (err, stack) => Text("Error: $err"),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ))
                  ],
                )),
      ),
    );
  }
}
