import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_header_page.dart';
import 'package:survey_app/widgets/builders/set_transect_num_builder.dart';

import '../../widgets/date_select.dart';
import '../../widgets/tile_cards/tile_card_selection.dart';

part 'woody_debris_summary_page.g.dart';

@riverpod
Future<WoodyDebrisSummaryData> wdData(WdDataRef ref, int surveyId) => ref
    .read(databaseProvider)
    .woodyDebrisTablesDao
    .getWdSummaryFromSurveyId(surveyId);

@riverpod
Future<List<WoodyDebrisHeaderData>> transList(TransListRef ref, int wdId) =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdHeadersFromWdSId(wdId);

class WoodyDebrisSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "woodyDebrisSummary";
  final GoRouterState goRouterState;
  const WoodyDebrisSummaryPage(this.goRouterState, {super.key});

  @override
  WoodyDebrisSummaryPageState createState() => WoodyDebrisSummaryPageState();
}

class WoodyDebrisSummaryPageState
    extends ConsumerState<WoodyDebrisSummaryPage> {
  final String title = "Woody Debris";
  late final int surveyId;
  late final int wdId;

  @override
  void initState() {
    surveyId = RouteParams.getSurveyId(widget.goRouterState);
    wdId = RouteParams.getWdSummaryId(widget.goRouterState);
    super.initState();
  }

  Future<void> updateWdSummary(WoodyDebrisSummaryCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.woodyDebrisSummary)..where((t) => t.id.equals(wdId)))
        .write(entry);
    ref.refresh(wdDataProvider(surveyId));
  }

  void createTransect() {
    final db = ref.read(databaseProvider);
    WoodyDebrisHeaderCompanion wdhCompanion = WoodyDebrisHeaderCompanion(
        wdId: d.Value(wdId), complete: const d.Value(false));

    Popups.show(
        context,
        PopupContinue(
          "Select Transect Number",
          contentWidget: Card(
            elevation: 0,
            color: Colors.transparent,
            child: SetTransectNumBuilder(
              name: "",
              getUsedTransNums: db.woodyDebrisTablesDao.getUsedTransnums(wdId),
              startingTransNum: '',
              selectedItem: wdhCompanion.transNum.value?.toString() ?? "",
              transList: kTransectNumsList,
              updateTransNum: (int transNum) => wdhCompanion =
                  wdhCompanion.copyWith(transNum: d.Value(transNum)),
            ),
          ),
          rightBtnOnPressed: () => db.woodyDebrisTablesDao
              .addWdHeader(wdhCompanion)
              .then((wdhId) async {
            context.pop();
            goToWdhPage(wdhId);
          }),
        ));
  }

  void goToWdhPage(int wdhId) {
    print(RouteParams.generateWdHeaderParms(
        widget.goRouterState, wdhId.toString()));
    context
        .pushNamed(WoodyDebrisHeaderPage.routeName,
            pathParameters: RouteParams.generateWdHeaderParms(
                widget.goRouterState, wdhId.toString()))
        .then((value) {
      ref.refresh(transListProvider(wdId));
      ref.refresh(wdDataProvider(surveyId));
    });
  }

  SurveyStatus getStatus(WoodyDebrisHeaderData wdh) {
    if (wdh.complete) return SurveyStatus.complete;
    if (wdh.transNum == null) return SurveyStatus.notStarted;
    return SurveyStatus.inProgress;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");

    final db = ref.read(databaseProvider);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(title);

    AsyncValue<WoodyDebrisSummaryData> wdSummary =
        ref.watch(wdDataProvider(surveyId));
    AsyncValue<List<WoodyDebrisHeaderData>> transList =
        ref.watch(transListProvider(wdId));

    return Scaffold(
      appBar: OurAppBar(title),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
        child: wdSummary.when(
            error: (err, stack) => Text("Error: $err"),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (wd) {
              final PopupDismiss surveyCompleteWarningPopup =
                  Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

              return Column(
                children: [
                  CalendarSelect(
                    date: wd.measDate,
                    label: "Enter Measurement Date",
                    readOnly: wd.complete,
                    readOnlyPopup: completeWarningPopup,
                    setStateFn: (DateTime date) async => updateWdSummary(
                        WoodyDebrisSummaryCompanion(measDate: d.Value(date))),
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
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: transList.when(
                    data: (transList) {
                      bool checkHeadersComplete() {
                        for (int i = 0; i < transList.length; i++) {
                          if (!transList[i].complete) return false;
                        }
                        return true;
                      }

                      return Scaffold(
                        floatingActionButton: FloatingCompleteButton(
                          title: title,
                          complete: wd.complete,
                          onPressed: () {
                            db.surveyInfoTablesDao
                                .getSurvey(wd.surveyId)
                                .then((value) {
                              bool surveyComplete = value.complete;
                              if (surveyComplete) {
                                Popups.show(
                                    context, surveyCompleteWarningPopup);
                              } else if (wd.complete) {
                                updateWdSummary(
                                    const WoodyDebrisSummaryCompanion(
                                        complete: d.Value(false)));
                              } else if (transList.isEmpty) {
                                Popups.showMissingTransect(context);
                              } else {
                                checkHeadersComplete()
                                    ? updateWdSummary(
                                        const WoodyDebrisSummaryCompanion(
                                            complete: d.Value(true)))
                                    : Popups.showIncompleteTransect(context);
                              }
                            });
                          },
                        ),
                        body: ListView.builder(
                            itemCount: transList.length,
                            itemBuilder: (BuildContext cxt, int index) {
                              WoodyDebrisHeaderData wdh = transList[index];
                              return TileCardSelection(
                                  title: "Transect ${wdh.transNum}",
                                  onPressed: () async {
                                    wd.complete
                                        ? Popups.show(
                                            context,
                                            Popups.generateNoticeSurveyComplete(
                                              "Woody Debris",
                                              () => goToWdhPage(wdh.id),
                                            ))
                                        : goToWdhPage(wdh.id);
                                  },
                                  status: getStatus(wdh));
                            }),
                      );
                    },
                    error: (err, stack) => Text("Error: $err"),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ))
                ],
              );
            }),
      ),
    );
  }
}
