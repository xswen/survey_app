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
import 'wood_debris_header_measurements_page.dart';

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
                      onPressed: () => context.pushNamed(
                              WoodyDebrisHeaderMeasurementsPage.routeName,
                              extra: {
                                WoodyDebrisHeaderMeasurementsPage.keyWdHeader:
                                    WoodyDebrisHeaderCompanion(
                                        wdId: d.Value(wd.id),
                                        complete: const d.Value(false)),
                                WoodyDebrisHeaderMeasurementsPage
                                        .keyUpdateSummaryPageTransList:
                                    updateTransList
                              }),
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
                        title: "Transect ${wdh.transNum}",
                        onPressed: () async {
                          wd.complete
                              ? Popups.show(
                                  context,
                                  Popups.generateNoticeSurveyComplete(
                                    "Woody Debris",
                                    () => goToWdhPage(wdh),
                                  ))
                              : goToWdhPage(wdh);
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
