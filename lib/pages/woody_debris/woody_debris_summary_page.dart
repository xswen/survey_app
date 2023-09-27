import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/constants/text_designs.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/enums/enums.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_header_page.dart';
import 'package:survey_app/widgets/tile_cards/tile_card_selection.dart';

import '../../constants/margins_padding.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/popups/popups.dart';

class WoodyDebrisSummaryPage extends StatefulWidget {
  static const String routeName = "woodyDebrisSummary";
  static const String keyWdSummary = "wdHeader";
  static const String keyTransList = "transList";

  const WoodyDebrisSummaryPage(
      {Key? key, required this.wd, required this.transList})
      : super(key: key);

  final WoodyDebrisSummaryData wd;
  final List<WoodyDebrisHeaderData> transList;

  @override
  State<WoodyDebrisSummaryPage> createState() => _WoodyDebrisSummaryPageState();
}

class _WoodyDebrisSummaryPageState extends State<WoodyDebrisSummaryPage> {
  String title = "Woody Debris";
  late WoodyDebrisSummaryData wd;
  late List<WoodyDebrisHeaderData> transList;

  @override
  void initState() {
    wd = widget.wd;
    transList = widget.transList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

    void updateTransList() {
      db.woodyDebrisTablesDao.getWdHeadersFromWdSId(wd.id).then((value) {
        setState(() => transList = value);
        updateWdSummary(
            db,
            WoodyDebrisSummaryCompanion(
                id: d.Value(wd.id),
                numTransects: value.isEmpty
                    ? const d.Value(null)
                    : d.Value(value.length)));
      });
    }

    void goToWdhPage(WoodyDebrisHeaderData wdh) =>
        context.pushNamed(WoodyDebrisHeaderPage.routeName, extra: {
          WoodyDebrisHeaderPage.keyWdHeader: wdh,
          WoodyDebrisHeaderPage.keySummaryComplete: wd.complete,
          WoodyDebrisHeaderPage.keyUpdateSummaryPageTransList: updateTransList,
        });

    void goAndHandleUninitializedTransect(WoodyDebrisHeaderData wdh) {
      int? transNum;
      // db.woodyDebrisTablesDao.getUsedTransnums(wd.id).then(
      //       (usedTransNums) => Popups.show(
      //           context,
      //           SetTransectNumBuilder(
      //             selectedItem: "PLease select a transect number",
      //             disabledFn: (s) =>
      //                 usedTransNums.contains(int.tryParse(s) ?? -1),
      //             onChanged: (s) => transNum = int.tryParse(s ?? "-1"),
      //             onSubmit: () {
      //               if (transNum == null || transNum! < 1) {
      //                 debugPrint("Error: selected item didn't parse correctly");
      //                 Popups.show(
      //                     context,
      //                     const PopupDismiss(
      //                       "Error: in parsing",
      //                       contentText: "There was a system error. "
      //                           "Request cannot be completed",
      //                     ));
      //                 context.pop();
      //               } else {
      //                 db.woodyDebrisTablesDao
      //                     .updateWdHeaderTransNum(wdh.id, transNum!)
      //                     .then((newWdh) => goToWdhPage(newWdh));
      //                 context.pop();
      //               }
      //             },
      //           )),
      //     );
    }

    return Scaffold(
      appBar: OurAppBar(title),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      floatingActionButton: FloatingCompleteButton(
        title: title,
        complete: wd.complete,
        onPressed: () {
          db.surveyInfoTablesDao.getSurvey(wd.surveyId).then((value) {
            bool surveyComplete = value.complete;
            if (surveyComplete) {
              Popups.show(context, surveyCompleteWarningPopup);
            } else if (wd.complete) {
              updateWdSummary(db,
                  const WoodyDebrisSummaryCompanion(complete: d.Value(false)));
            } else if (transList.isEmpty) {
              Popups.showMissingTransect(context);
            } else {
              checkHeadersComplete()
                  ? updateWdSummary(
                      db,
                      const WoodyDebrisSummaryCompanion(
                          complete: d.Value(true)))
                  : Popups.showIncompleteTransect(context);
            }
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            CalendarSelect(
              date: wd.measDate,
              label: "Enter Measurement Date",
              readOnly: wd.complete,
              readOnlyPopup: completeWarningPopup,
              setStateFn: (DateTime date) async => updateWdSummary(
                  db, WoodyDebrisSummaryCompanion(measDate: d.Value(date))),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              // child: DropDownDefault(
              //     title: "Number of Transects Assessed",
              //     onBeforePopup: (String? s) async {
              //       if (wd.complete) {
              //         Popups.show(context, completeWarningPopup);
              //         return false;
              //       }
              //       return true;
              //     },
              //     onChangedFn: (String? s) async {
              //       int i = int.parse(s!);
              //       int transListLen = transList.length;
              //       for (int idx = transListLen; idx < i; idx++) {
              //         var tmp = createWdhData(db, idx + 1);
              //       }
              //       updateTransList();
              //     },
              //     disabledFn: (String? s) =>
              //         int.parse(s!) < (wd.numTransects ?? 0),
              //     itemsList: kTransectNumsList,
              //     selectedItem: wd.numTransects?.toString() ??
              //         "No transects exists, please add"),
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
                      onPressed: () {},
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
              child: ListView.builder(
                  itemCount: transList.length,
                  itemBuilder: (BuildContext cxt, int index) {
                    WoodyDebrisHeaderData wdh = transList[index];
                    return TileCardSelection(
                        title:
                            "Transect ${wdh.transNum ?? "not yet initialized"}",
                        onPressed: () async {
                          if (wd.complete) {
                            Popups.show(
                                context,
                                Popups.generateNoticeSurveyComplete(
                                  "Woody Debris",
                                  () {
                                    context.pop();
                                    context.pushNamed(
                                        WoodyDebrisHeaderPage.routeName,
                                        extra: {
                                          WoodyDebrisHeaderPage.keyWdHeader:
                                              wdh,
                                          WoodyDebrisHeaderPage
                                              .keySummaryComplete: wd.complete
                                        }).then((value) => db
                                        .woodyDebrisTablesDao
                                        .getWdHeaderFromId(wdh.id)
                                        .then((value) => setState(
                                            () => transList[index] = value)));
                                  },
                                ));
                          } else {
                            if (wdh.transNum == null) {
                              goAndHandleUninitializedTransect(wdh);
                            } else {
                              goToWdhPage(wdh);
                            }
                          }
                        },
                        status: getStatus(wdh));
                  }),
            )
          ],
        ),
      ),
    );
  }

  SurveyStatus getStatus(WoodyDebrisHeaderData wdh) {
    if (wdh.complete) return SurveyStatus.complete;
    if (wdh.transNum == null) return SurveyStatus.notStarted;
    return SurveyStatus.inProgress;
  }

  Future<void> updateWdSummary(
      Database db, WoodyDebrisSummaryCompanion entry) async {
    (db.update(db.woodyDebrisSummary)..where((t) => t.id.equals(wd.id)))
        .write(entry);
    wd = await db.woodyDebrisTablesDao.getWdSummary(wd.surveyId);
    setState(() {});
  }

  Future<void> createWdhData(Database db, int transNum) async {
    int id = await db.woodyDebrisTablesDao
        .addWdHeader(WoodyDebrisHeaderCompanion(wdId: d.Value(wd.id)));
  }

  bool checkHeadersComplete() {
    for (int i = 0; i < transList.length; i++) {
      if (!transList[i].complete) return false;
    }
    return true;
  }
}
