import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_header_page.dart';
import 'package:survey_app/widgets/builders/set_transect_num_builder.dart';
import 'package:survey_app/widgets/buttons/custom_button_styles.dart';
import 'package:survey_app/widgets/popups/popup_notice_survey_complete.dart';

import '../../providers/survey_info_providers.dart';
import '../../providers/woody_debris_providers.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/popups/popup_marked_complete.dart';
import '../../widgets/tile_cards/tile_card_transect.dart';
import '../delete_page.dart';
import 'woody_debris_header_measurements_page.dart';

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
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int wdId;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.goRouterState)!;

    wdId = PathParamValue.getWdSummaryId(widget.goRouterState);

    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

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
              getUsedTransNums: db.woodyDebrisTablesDao.getUsedTransNums(wdId),
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
    Database db = ref.read(databaseProvider);
    db.woodyDebrisTablesDao.getOrCreateWdSmallId(wdhId).then(
          (wdSmallId) => context
              .pushNamed(WoodyDebrisHeaderPage.routeName,
                  pathParameters: PathParamGenerator.wdHeader(
                      widget.goRouterState,
                      wdhId.toString(),
                      wdSmallId.toString()))
              .then((value) {
            ref.refresh(wdTransListProvider(wdId));
            ref.refresh(wdDataProvider(surveyId));
          }),
        );
  }

  SurveyStatus getStatus(WoodyDebrisHeaderData wdh) {
    if (wdh.complete) return SurveyStatus.complete;
    if (wdh.transNum == null) return SurveyStatus.notStarted;
    return SurveyStatus.inProgress;
  }

  bool checkHeadersComplete(List<WoodyDebrisHeaderData> transList) {
    for (int i = 0; i < transList.length; i++) {
      if (!transList[i].complete) return false;
    }
    return true;
  }

  void markComplete(
      WoodyDebrisSummaryData wd, List<WoodyDebrisHeaderData> transList) {
    final db = ref.read(databaseProvider);

    db.surveyInfoTablesDao.getSurvey(wd.surveyId).then((value) {
      bool surveyComplete = value.complete;
      if (surveyComplete) {
        Popups.show(context, surveyCompleteWarningPopup);
      } else if (wd.complete) {
        updateWdSummary(
            const WoodyDebrisSummaryCompanion(complete: d.Value(false)));
      } else if (transList.isEmpty) {
        Popups.showMissingTransect(context);
      } else {
        if (checkHeadersComplete(transList)) {
          updateWdSummary(
              const WoodyDebrisSummaryCompanion(complete: d.Value(true)));
          Popups.show(context,
              const PopupMarkedComplete(title: "Woody debris summary"));
        } else {
          Popups.showIncompleteTransect(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<WoodyDebrisSummaryData> wdSummary =
        ref.watch(wdDataProvider(surveyId));
    AsyncValue<List<WoodyDebrisHeaderData>> transList =
        ref.watch(wdTransListProvider(wdId));

    return wdSummary.when(
      error: (err, stack) => Text("Error: $err"),
      loading: () => DefaultPageLoadingScaffold(title: title),
      data: (wd) => transList.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => DefaultPageLoadingScaffold(title: title),
        data: (transList) => Scaffold(
          appBar: OurAppBar(
            title,
            complete: wd.complete,
            backFn: () {
              ref.refresh(updateSurveyCardProvider(surveyId));
              context.pop();
            },
          ),
          endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
          bottomNavigationBar: MarkCompleteButton(
              title: title,
              complete: wd.complete,
              onPressed: () => markComplete(wd, transList)),
          body: Column(
            children: [
              CalendarSelect(
                date: wd.measDate,
                label: "Enter Measurement Date",
                readOnly: wd.complete,
                readOnlyPopup: completeWarningPopup,
                onDateSelected: (DateTime date) async => updateWdSummary(
                    WoodyDebrisSummaryCompanion(measDate: d.Value(date))),
              ),
              const SizedBox(height: kPaddingV),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kPaddingH, 0, kPaddingH, kPaddingV / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        "Select a Transect to enter data for:",
                        style: TextStyle(fontSize: kTextHeaderSize),
                        maxLines: null,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => wd.complete
                            ? Popups.show(context, completeWarningPopup)
                            : context.pushNamed(
                                WoodyDebrisHeaderMeasurementsPage.routeName,
                                pathParameters: PathParamGenerator.wdHeader(
                                    widget.goRouterState,
                                    kParamMissing,
                                    kParamMissing)),
                        style: CustomButtonStyles.inactiveButton(
                            isActive: !wd.complete),
                        child: const Text("Add transect"))
                  ],
                ),
              ),
              Expanded(
                child: transList.isEmpty
                    ? const Center(
                        child:
                            Text("No transects created. Please add transect."))
                    : ListView.builder(
                        itemCount: transList.length,
                        itemBuilder: (BuildContext cxt, int index) {
                          WoodyDebrisHeaderData wdh = transList[index];
                          return TileCardTransect(
                            title: "Transect ${wdh.transNum}",
                            onPressed: () async {
                              wd.complete
                                  ? Popups.show(
                                      context,
                                      PopupNoticeSurveyComplete(
                                        title: title,
                                        rightBtnOnPressed: () {
                                          context.pop();
                                          goToWdhPage(wdh.id);
                                        },
                                      ))
                                  : goToWdhPage(wdh.id);
                            },
                            status: getStatus(wdh),
                            onDelete: () => Popups.show(
                              context,
                              PopupContinue(
                                  "Warning: Deleting Woody Debris Transect",
                                  contentText:
                                      "You are about to delete transect ${wdh.transNum}. "
                                      "Are you sure you want to continue?",
                                  rightBtnOnPressed: () {
                                //close popup
                                context.pop();
                                context.pushNamed(DeletePage.routeName, extra: {
                                  DeletePage.keyObjectName:
                                      "Woody Debris Transect ${wdh.transNum}",
                                  DeletePage.keyDeleteFn: () {
                                    Database.instance.woodyDebrisTablesDao
                                        .deleteWoodyDebrisTransect(wdh.id)
                                        .then((value) {
                                      ref.refresh(wdTransListProvider(wdId));
                                      context.goNamed(
                                          WoodyDebrisSummaryPage.routeName,
                                          pathParameters: widget
                                              .goRouterState.pathParameters);
                                    });
                                  },
                                });
                              }),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
