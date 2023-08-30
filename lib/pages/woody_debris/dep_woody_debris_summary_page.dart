import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constant_values.dart';
import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../global.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/buttons/summary_section_button_generator.dart';
import '../../widgets/date_select.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popup_dismiss_dep.dart';

class DepWoodyDebrisSummaryPage extends StatefulWidget {
  const DepWoodyDebrisSummaryPage({super.key, required this.title});
  final String title;

  @override
  State<DepWoodyDebrisSummaryPage> createState() =>
      _DepWoodyDebrisSummaryPageState();
}

class _DepWoodyDebrisSummaryPageState extends State<DepWoodyDebrisSummaryPage>
    with Global {
  final _db = Get.find<Database>();
  WoodyDebrisSummaryData wdSummary = Get.arguments[0];
  List<WoodyDebrisHeaderData> transList = Get.arguments[1];

  final PopupDismissDep _completeWarningPopup =
      Global.generateCompleteErrorPopup("Woody Debris");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(widget.title),
      floatingActionButton: FloatingCompleteButton(
        title: "Woody Debris",
        complete: wdSummary.complete,
        onPressed: () {
          if (wdSummary.complete) {
            _updateWdSummary(
                const WoodyDebrisSummaryCompanion(complete: d.Value(false)));
          } else if (transList.isEmpty) {
            Get.dialog(const PopupDismissDep(
                title: "Error: Missing Transect",
                contentText: "Please add at least one transect"));
          } else {
            _checkHeadersComplete()
                ? _updateWdSummary(
                    const WoodyDebrisSummaryCompanion(complete: d.Value(true)))
                : Get.dialog(const PopupDismissDep(
                    title: "Error: Incomplete transects",
                    contentText:
                        "Please mark all transects as complete to continue"));
          }
          setState(() {});
        },
      ),
      body: Center(
        child: Column(
          children: [
            CalendarSelect(
                date: wdSummary.measDate,
                label: "Enter Measurement Date",
                readOnly: wdSummary.complete,
                readOnlyPopup: _completeWarningPopup,
                setStateFn: (DateTime date) async {
                  _updateWdSummary(
                      WoodyDebrisSummaryCompanion(measDate: d.Value(date)));
                  setState(() {});
                }),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Number of Transects Assessed",
                  onBeforePopup: (String? s) async {
                    if (wdSummary.complete) {
                      Get.dialog(_completeWarningPopup);
                      return false;
                    }
                    return true;
                  },
                  onChangedFn: (String? s) async {
                    int i = int.parse(s!);
                    _updateWdSummary(
                        WoodyDebrisSummaryCompanion(numTransects: d.Value(i)));
                    int transListLen = transList.length;
                    for (int idx = transListLen; idx < i; idx++) {
                      transList.add(await _getOrCreateWdhData(idx + 1));
                    }
                    setState(() {});
                  },
                  disabledFn: (String? s) =>
                      int.parse(s!) < (wdSummary.numTransects ?? 0),
                  itemsList: kTransectNumsList,
                  selectedItem: Global.nullableToStr(wdSummary.numTransects)),
            ),
            const SizedBox(height: kPaddingV),
            const Text("Select a Transect to enter data for:"),
            Expanded(
              child: ListView.builder(
                  itemCount: transList.length,
                  itemBuilder: (BuildContext cxt, int index) {
                    WoodyDebrisHeaderData ssd = transList[index];
                    return SummarySectionButton(
                        title: "Transect ${index + 1}",
                        onPressed: () async {
                          WoodyDebrisHeaderData wdh = transList[index];
                          var tmp = await Get.toNamed(Routes.woodyDebrisHeader,
                              arguments: {
                                "wdh": wdh,
                                "summaryComplete": wdSummary.complete,
                              });
                          _db.woodyDebrisTablesDao
                              .getWdHeadersFromWdsId(wdSummary.id)
                              .then(
                                  (value) => setState(() => transList = value));
                        },
                        complete: ssd.complete);
                  }),
            )

            // ListView(
            //   children: _buttonsList,
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateWdSummary(WoodyDebrisSummaryCompanion entry) async {
    (_db.update(_db.woodyDebrisSummary)
          ..where((t) => t.id.equals(wdSummary.id)))
        .write(entry);
    wdSummary = await _db.woodyDebrisTablesDao.getWdSummary(wdSummary.surveyId);
  }

  Future<WoodyDebrisHeaderData> _getOrCreateWdhData(int transNum) async {
    WoodyDebrisHeaderData? wdh = await _db.woodyDebrisTablesDao
        .getWdHeaderFromTransNum(wdSummary.id, transNum);

    if (wdh == null) {
      _db.woodyDebrisTablesDao.addWdHeader(WoodyDebrisHeaderCompanion(
          wdId: d.Value(wdSummary.id), transNum: d.Value(transNum)));
      wdh = await _db.woodyDebrisTablesDao
          .getWdHeaderFromTransNum(wdSummary.id, transNum);
    }

    return wdh!;
  }

  bool _checkHeadersComplete() {
    for (int i = 0; i < transList.length; i++) {
      if (!transList[i].complete) {
        return false;
      }
    }
    return true;
  }
}
