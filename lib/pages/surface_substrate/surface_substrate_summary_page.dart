import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/widgets/popups/popup_dismiss.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/popups/popups.dart';

class SurfaceSubstrateSummaryPage extends StatefulWidget {
  static const String routeName = "surfaceSubstrate";
  static const String keySsSummary = "ssSummary";
  static const String keyTransList = "transList";

  const SurfaceSubstrateSummaryPage(
      {Key? key, required this.ss, required this.transList})
      : super(key: key);

  final SurfaceSubstrateSummaryData ss;
  final List<SurfaceSubstrateHeaderData> transList;

  @override
  State<SurfaceSubstrateSummaryPage> createState() =>
      _SurfaceSubstrateSummaryPageState();
}

class _SurfaceSubstrateSummaryPageState
    extends State<SurfaceSubstrateSummaryPage> {
  String title = "Surface Substrate";
  late SurfaceSubstrateSummaryData ss;
  late List<SurfaceSubstrateHeaderData> transList;

  @override
  void initState() {
    ss = widget.ss;
    transList = widget.transList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(context, title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup(context, "Survey");

    Future<void> updateSummary(SurfaceSubstrateSummaryCompanion entry) async {
      (db.update(db.surfaceSubstrateSummary)..where((t) => t.id.equals(ss.id)))
          .write(entry);
      db.surfaceSubstrateTablesDao
          .getSsSummary(ss.surveyId)
          .then((value) => setState(() => ss = value));
    }

    return Scaffold(
      appBar: const OurAppBar(""),
      floatingActionButton: FloatingCompleteButton(
        title: "Surface Substrate Summary",
        complete: ss.complete,
        onPressed: () {
          db.surveyInfoTablesDao.getSurvey(ss.surveyId).then((value) {
            bool surveyComplete = value.complete;
            if (surveyComplete) {
              Popups.show(context, surveyCompleteWarningPopup);
            } else {
              updateSummary(SurfaceSubstrateSummaryCompanion(
                  complete: d.Value(!ss.complete)));
            }
          });
        },
      ),
      body: Center(
        child: Text("Surface substrate is ${ss.complete}"),
      ),
    );
  }
}
