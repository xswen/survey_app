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
import '../../widgets/selection_tile_card.dart';

class DepSurfaceSubstrateSummaryPage extends StatefulWidget {
  const DepSurfaceSubstrateSummaryPage({super.key, required this.title});
  final String title;

  @override
  State<DepSurfaceSubstrateSummaryPage> createState() =>
      _DepSurfaceSubstrateSummaryPageState();
}

class _DepSurfaceSubstrateSummaryPageState
    extends State<DepSurfaceSubstrateSummaryPage> with Global {
  final _db = Get.find<Database>();
  SurfaceSubstrateSummaryData ssSummary = Get.arguments[0];
  List<SurfaceSubstrateHeaderData> transList = Get.arguments[1];

  final PopupDismissDep completeWarningPopup =
      Global.generateCompleteErrorPopup("Surface Substrate");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(widget.title),
      floatingActionButton: FloatingCompleteButton(
        title: "Ecological Plot",
        complete: ssSummary.complete,
        onPressed: () async {
          if (ssSummary.complete) {
            _updateSsSummary(const SurfaceSubstrateSummaryCompanion(
                complete: d.Value(false)));
          } else if (transList.isEmpty) {
            Get.dialog(const PopupDismissDep(
                title: "Error",
                contentText: "Please add at least one Ecological Plot"));
          } else {
            _checkHeadersComplete()
                ? _updateSsSummary(const SurfaceSubstrateSummaryCompanion(
                    complete: d.Value(true)))
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
                date: ssSummary.measDate,
                label: "Enter Measurement Date",
                readOnly: ssSummary.complete,
                readOnlyPopup: completeWarningPopup,
                setStateFn: (DateTime date) async {
                  _updateSsSummary(SurfaceSubstrateSummaryCompanion(
                      measDate: d.Value(date)));

                  setState(() {});
                }),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Number of Transects Assessed",
                  onBeforePopup: (String? s) async {
                    if (ssSummary.complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    int i = int.parse(s!);
                    _updateSsSummary(SurfaceSubstrateSummaryCompanion(
                        numTransects: d.Value(i)));
                    int transListLen = transList.length;
                    for (int idx = transListLen; idx < i; idx++) {
                      transList.add(await _getOrCreateSsData(idx + 1));
                    }
                    setState(() {});
                  },
                  disabledFn: (String? s) =>
                      int.parse(s!) < (ssSummary.numTransects ?? 0),
                  itemsList: kTransectNumsList,
                  selectedItem: Global.nullableToStr(ssSummary.numTransects)),
            ),
            const SizedBox(height: kPaddingV),
            const Text("Select a Transect to enter data for:"),
            Expanded(
              child: ListView.builder(
                  itemCount: transList.length,
                  itemBuilder: (BuildContext cxt, int index) {
                    SurfaceSubstrateHeaderData ssd = transList[index];
                    return SelectionTileCard(
                        title: "Transect ${index + 1}",
                        onPressed: () async {
                          List<SurfaceSubstrateTallyData> stations = await _db
                              .surfaceSubstrateTablesDao
                              .getSsTallyList(ssd.id);
                          var tmp = await Get.toNamed(
                              Routes.surfaceSubstrateTransect,
                              arguments: {
                                "ssc": ssd.toCompanion(true),
                                "stations": stations,
                                "summaryComplete": ssd.complete
                              });

                          _db.surfaceSubstrateTablesDao
                              .getSsHeaderWithSshId(ssSummary.id)
                              .then(
                                  (value) => setState(() => transList = value));
                        },
                        complete: ssd.complete);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateSsSummary(SurfaceSubstrateSummaryCompanion entry) async {
    (_db.update(_db.surfaceSubstrateSummary)
          ..where((t) => t.id.equals(ssSummary.id)))
        .write(entry);
    ssSummary =
        (await _db.surfaceSubstrateTablesDao.getSsSummary(ssSummary.surveyId))!;
  }

  Future<SurfaceSubstrateHeaderData> _getOrCreateSsData(int transNum) async {
    SurfaceSubstrateHeaderData? ssd = await _db.surfaceSubstrateTablesDao
        .getSsHeaderFromTransNum(ssSummary.id, transNum);

    if (ssd == null) {
      _db.surfaceSubstrateTablesDao.addSsHeader(SurfaceSubstrateHeaderCompanion(
          ssHeaderId: d.Value(ssSummary.id), transNum: d.Value(transNum)));
      ssd = await _db.surfaceSubstrateTablesDao
          .getSsHeaderFromTransNum(ssSummary.id, transNum);
    }

    return ssd!;
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
