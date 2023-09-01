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
import '../../widgets/date_select.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popup_dismiss_dep.dart';
import '../../widgets/tile_cards/tile_card_selection.dart';

class EcologicalPlotSummaryPage extends StatefulWidget {
  const EcologicalPlotSummaryPage({super.key, required this.title});
  final String title;

  @override
  State<EcologicalPlotSummaryPage> createState() =>
      _EcologicalPlotSummaryPageState();
}

class _EcologicalPlotSummaryPageState extends State<EcologicalPlotSummaryPage>
    with Global {
  final _db = Get.find<Database>();

  EcpSummaryData ecpS = Get.arguments[0];
  List<EcpHeaderData> ecpList = Get.arguments[1];
  final PopupDismissDep _completeWarningPopup =
      Global.generateCompleteErrorPopupDep("Ecological Plot");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(widget.title),
      floatingActionButton: FloatingCompleteButton(
        title: "Ecological Plot",
        complete: ecpS.complete,
        onPressed: () async {
          if (ecpS.complete) {
            _updateEcpSummary(
                const EcpSummaryCompanion(complete: d.Value(false)));
          } else if (ecpList.isEmpty) {
            Get.dialog(const PopupDismissDep(
                title: "Error",
                contentText: "Please add at least one Ecological Plot"));
          } else {
            _checkHeadersComplete()
                ? _updateEcpSummary(
                    const EcpSummaryCompanion(complete: d.Value(true)))
                : Get.dialog(const PopupDismissDep(
                    title: "Error",
                    contentText: "There are plots still left incomplete"));
          }
          setState(() {});
        },
      ),
      body: Center(
        child: Column(
          children: [
            CalendarSelect(
                date: ecpS.measDate,
                label: "Enter Measurement Date",
                readOnly: ecpS.complete,
                readOnlyPopup: _completeWarningPopup,
                setStateFn: (DateTime date) async {
                  _updateEcpSummary(
                      EcpSummaryCompanion(measDate: d.Value(date)));

                  setState(() {});
                }),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Number of Ecological Plot",
                  onBeforePopup: (String? s) async {
                    if (ecpS.complete) {
                      Get.dialog(_completeWarningPopup);
                      return false;
                    }
                    return true;
                  },
                  onChangedFn: (String? s) async {
                    int i = int.parse(s!);
                    _updateEcpSummary(EcpSummaryCompanion(numEcps: d.Value(i)));
                    int ecpListLen = ecpList.length;
                    for (int idx = ecpListLen; idx < i; idx++) {
                      ecpList.add(await _getOrCreateEcpHeader(idx + 1));
                    }
                    setState(() {});
                  },
                  disabledFn: (String? s) =>
                      int.parse(s!) < (ecpS.numEcps ?? 0),
                  itemsList: kTransectNumsList,
                  selectedItem: Global.nullableToStr(ecpS.numEcps)),
            ),
            const SizedBox(height: kPaddingV),
            const Text("Select a Transect to enter data for:"),
            Expanded(
              child: ListView.builder(
                  itemCount: ecpList.length,
                  itemBuilder: (BuildContext cxt, int index) {
                    EcpHeaderData ecpH = ecpList[index];
                    return TileCardSelection(
                        title: "Plot ${index + 1}",
                        onPressed: () async {
                          var tmp = await Get.toNamed(
                              Routes.ecologicalPlotHeader,
                              arguments: {
                                "ecpH": ecpH.toCompanion(true),
                                "summaryComplete": ecpS.complete
                              });

                          _db.ecologicalPlotTablesDao
                              .getHeaderWithEcpSummryId(ecpS.id)
                              .then((value) => setState(() => ecpList = value));
                        },
                        complete: ecpH.complete);
                  }),
            )
          ],
        ),
      ),
    );
  }

  bool _checkHeadersComplete() {
    for (int i = 0; i < ecpList.length; i++) {
      if (!ecpList[i].complete) {
        return false;
      }
    }
    return true;
  }

  Future<void> _updateEcpSummary(EcpSummaryCompanion entry) async {
    (_db.update(_db.ecpSummary)..where((t) => t.id.equals(ecpS.id)))
        .write(entry);
    ecpS = (await _db.ecologicalPlotTablesDao
        .getSummaryWithSurveyId(ecpS.surveyId))!;
  }

  Future<EcpHeaderData> _getOrCreateEcpHeader(int ecpNum) async {
    EcpHeaderData? ecpH = await _db.ecologicalPlotTablesDao
        .getEcpHeaderFromEcpNum(ecpS.id, ecpNum);

    if (ecpH == null) {
      _db.ecologicalPlotTablesDao.addHeader(EcpHeaderCompanion(
          ecpSummaryId: d.Value(ecpS.id), ecpNum: d.Value(ecpNum)));
      ecpH = await _db.ecologicalPlotTablesDao
          .getEcpHeaderFromEcpNum(ecpS.id, ecpNum);
    }

    return ecpH!;
  }
}
