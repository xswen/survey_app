import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/enums/enums.dart';
import 'package:survey_app/widgets/popups/popup_dismiss.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/tile_cards/tile_card_selection.dart';
import 'surface_substrate_header_page.dart';

class SurfaceSubstrateSummaryPage extends StatefulWidget {
  static const String routeName = "surfaceSubstrateSummary";
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
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

    void updateSsSummary(SurfaceSubstrateSummaryCompanion entry) {
      (db.update(db.surfaceSubstrateSummary)..where((t) => t.id.equals(ss.id)))
          .write(entry);
      db.surfaceSubstrateTablesDao
          .getSsSummary(ss.surveyId)
          .then((value) => setState(() => ss = value));
    }

    void updateTransList() {
      db.surfaceSubstrateTablesDao.getSSHeadersFromSSsId(ss.id).then((value) {
        setState(() => transList = value);
        updateSsSummary(SurfaceSubstrateSummaryCompanion(
            id: d.Value(ss.id),
            numTransects:
                value.isEmpty ? const d.Value(null) : d.Value(value.length)));
      });
    }

    void goToSsHPage(SurfaceSubstrateHeaderCompanion ssH,
            List<SurfaceSubstrateTallyData> stations) =>
        context.pushNamed(SurfaceSubstrateHeaderPage.routeName, extra: {
          SurfaceSubstrateHeaderPage.keySurfaceSubstrateHeaderCompanion: ssH,
          SurfaceSubstrateHeaderPage.keySurfaceSubstrateTalliesData: stations,
          SurfaceSubstrateHeaderPage.keySummaryComplete: ss.complete
        });

    bool checkHeadersComplete() {
      for (int i = 0; i < transList.length; i++) {
        if (!transList[i].complete) return false;
      }
      return true;
    }

    return Scaffold(
      appBar: const OurAppBar(""),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      floatingActionButton: FloatingCompleteButton(
        title: "Surface Substrate Summary",
        complete: ss.complete,
        onPressed: () {
          db.surveyInfoTablesDao.getSurvey(ss.surveyId).then((value) {
            bool surveyComplete = value.complete;
            if (surveyComplete) {
              Popups.show(context, surveyCompleteWarningPopup);
            } else if (ss.complete) {
              updateSsSummary(const SurfaceSubstrateSummaryCompanion(
                  complete: d.Value(false)));
            } else if (transList.isEmpty) {
              Popups.showMissingTransect(context);
            } else {
              checkHeadersComplete()
                  ? updateSsSummary(SurfaceSubstrateSummaryCompanion(
                      complete: d.Value(!ss.complete)))
                  : Popups.showIncompleteTransect(context);
            }
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            CalendarSelect(
              date: ss.measDate,
              label: "Enter Measurement Date",
              readOnly: ss.complete,
              readOnlyPopup: completeWarningPopup,
              setStateFn: (DateTime date) async => updateSsSummary(
                  SurfaceSubstrateSummaryCompanion(measDate: d.Value(date))),
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
                      onPressed: () => goToSsHPage(
                          SurfaceSubstrateHeaderCompanion(
                              ssId: d.Value(ss.id),
                              complete: const d.Value(false)),
                          []),
                      // onPressed: () => context.pushNamed(
                      //         SurfaceSubstrateHeaderMeasurementsPage.routeName,
                      //         extra: {
                      //           SurfaceSubstrateHeaderMeasurementsPage
                      //                   .keySsHeaderCompanion:
                      //               SurfaceSubstrateHeaderCompanion(
                      //                   ssId: d.Value(ss.id),
                      //                   complete: const d.Value(false)),
                      //           SurfaceSubstrateHeaderMeasurementsPage
                      //                   .keyUpdateSummaryPageTransList:
                      //               updateTransList
                      //         }),
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
                    SurfaceSubstrateHeaderData ssh = transList[index];
                    return TileCardSelection(
                        title: "Transect ${ssh.transNum}",
                        onPressed: () async {
                          ss.complete
                              ? Popups.show(
                                  context,
                                  Popups.generateNoticeSurveyComplete(
                                    "Woody Debris",
                                    () => null, //goToWdhPage(wdh),
                                  ))
                              : null; //goToWdhPage(wdh);
                        },
                        status: SurveyStatus.complete //getStatus(wdh)
                        );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
