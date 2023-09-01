import 'package:drift/drift.dart' as d;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/enums/enums.dart';
import 'package:survey_app/widgets/tile_cards/tile_card_selection.dart';

import '../../constants/constant_values.dart';
import '../../constants/margins_padding.dart';
import '../../global.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popups.dart';

class WoodyDebrisSummaryPage extends StatefulWidget {
  WoodyDebrisSummaryPage({Key? key, required this.wd, required this.transList})
      : super(key: key);

  WoodyDebrisSummaryData wd;
  List<WoodyDebrisHeaderData> transList;

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
    final CupertinoAlertDialog completeWarningPopup =
        Global.generateCompleteErrorPopup(context, title);
    final CupertinoAlertDialog surveyCompleteWarningPopup =
        Global.generatePreviousMarkedCompleteErrorPopup(context, "survey");

    return Scaffold(
      appBar: OurAppBar(title),
      floatingActionButton: FloatingCompleteButton(
        title: title,
        complete: wd.complete,
        onPressed: () {
          db.surveyInfoTablesDao.getSurvey(wd.surveyId).then((value) {
            bool surveyComplete = value.complete;
            if (surveyComplete) {
              Popups.show(context, surveyCompleteWarningPopup);
            } else if (wd.complete) {
              updateWdSummary(
                      db,
                      const WoodyDebrisSummaryCompanion(
                          complete: d.Value(false)))
                  .then((value) => null);
            } else if (transList.isEmpty) {
              Popups.showDismiss(context, "Error Missing Transect",
                  contentText: "Please add at least one transect");
            } else {
              !checkHeadersComplete()
                  ? updateWdSummary(
                      db,
                      const WoodyDebrisSummaryCompanion(
                          complete: d.Value(true)))
                  : Popups.show(
                      context,
                      Popups.widgetDismiss(
                          context, "Error: Incomplete transects",
                          contentText:
                              "Please mark all transects as complete to continue"));
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
                setStateFn: (DateTime date) async {
                  updateWdSummary(
                      db, WoodyDebrisSummaryCompanion(measDate: d.Value(date)));
                  setState(() {});
                }),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Number of Transects Assessed",
                  onBeforePopup: (String? s) async {
                    if (wd.complete) {
                      Popups.show(context, completeWarningPopup);
                      return false;
                    }
                    return true;
                  },
                  onChangedFn: (String? s) async {
                    int i = int.parse(s!);
                    updateWdSummary(db,
                        WoodyDebrisSummaryCompanion(numTransects: d.Value(i)));
                    int transListLen = transList.length;
                    for (int idx = transListLen; idx < i; idx++) {
                      transList.add(await getOrCreateWdhData(db, idx + 1));
                    }
                    setState(() {});
                  },
                  disabledFn: (String? s) =>
                      int.parse(s!) < (wd.numTransects ?? 0),
                  itemsList: kTransectNumsList,
                  selectedItem: Global.nullableToStr(wd.numTransects)),
            ),
            const SizedBox(height: kPaddingV),
            const Text("Select a Transect to enter data for:"),
            Expanded(
              child: ListView.builder(
                  itemCount: transList.length,
                  itemBuilder: (BuildContext cxt, int index) {
                    WoodyDebrisHeaderData wdh = transList[index];
                    return TileCardSelection(
                        title: "Transect ${index + 1}",
                        onPressed: () async {
                          if (wd.complete) {
                            Popups.show(context, completeWarningPopup);
                          } else {
                            //TODO: Add navigation
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
    //Check that none of the header data is inputted
    if (wdh.transAzimuth == null &&
        wdh.lcwdMeasLen == null &&
        wdh.mcwdMeasLen == null &&
        wdh.nomTransLen == null &&
        wdh.swdDecayClass == null &&
        wdh.swdMeasLen == null) {
      return SurveyStatus.notStarted;
    }
    if (wdh.complete) return SurveyStatus.complete;

    return SurveyStatus.inProgress;
  }

  Future<void> updateWdSummary(
      Database db, WoodyDebrisSummaryCompanion entry) async {
    (db.update(db.woodyDebrisSummary)..where((t) => t.id.equals(wd.id)))
        .write(entry);
    wd = await db.woodyDebrisTablesDao.getWdSummary(wd.surveyId);
    setState(() {});
  }

  Future<WoodyDebrisHeaderData> getOrCreateWdhData(
      Database db, int transNum) async {
    WoodyDebrisHeaderData? wdh =
        await db.woodyDebrisTablesDao.getWdHeaderFromTransNum(wd.id, transNum);

    if (wdh == null) {
      db.woodyDebrisTablesDao.addWdHeader(WoodyDebrisHeaderCompanion(
          wdId: d.Value(wd.id), transNum: d.Value(transNum)));
      wdh = await db.woodyDebrisTablesDao
          .getWdHeaderFromTransNum(wd.id, transNum);
    }

    return wdh!;
  }

  bool checkHeadersComplete() {
    for (int i = 0; i < transList.length; i++) {
      if (!transList[i].complete) return false;
    }
    return true;
  }
}
