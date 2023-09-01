import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/enums/enums.dart';
import 'package:survey_app/widgets/tile_cards/tile_card_selection.dart';
import 'package:survey_app/wrappers/survey_card.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/format_date.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/titled_border.dart';
import '../surface_substrate/surface_substrate_summary_page.dart';
import '../woody_debris/woody_debris_summary_page.dart';

class SurveyInfoPage extends StatefulWidget {
  static const String keySurvey = "survey";
  static const String keyCards = "cards";
  static const String keyUpdateDash = "updateDashboard";

  const SurveyInfoPage(
      {super.key,
      required this.surveyHeader,
      required this.cards,
      required this.updateDashboard});
  final String title = "Survey Info Page";

  final SurveyHeader surveyHeader;
  final List<SurveyCard> cards;
  final void Function() updateDashboard;

  @override
  State<SurveyInfoPage> createState() => _SurveyInfoPageState();
}

class _SurveyInfoPageState extends State<SurveyInfoPage> {
  late SurveyHeader survey;
  late List<SurveyCard> cards;
  late List<TileCardSelection> tileCards;

  @override
  void initState() {
    survey = widget.surveyHeader;
    cards = widget.cards;
    tileCards = generateTileCards(widget.cards);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);

    Future<void> updateSummary(SurveyHeadersCompanion entry) async {
      (db.update(db.surveyHeaders)..where((t) => t.id.equals(survey.id)))
          .write(entry);
      db.surveyInfoTablesDao
          .getSurvey(survey.id)
          .then((value) => setState(() => survey = value));
    }

    return Scaffold(
      appBar: OurAppBar(backFn: () {
        widget.updateDashboard();
        context.pop();
      }, widget.title),
      floatingActionButton: FloatingCompleteButton(
        title: widget.title,
        complete: survey.complete,
        onPressed: () async {
          Map<SurveyStatus, String>? result = checkAllComplete();
          //All good
          if (result == null) {
            updateSummary(
                SurveyHeadersCompanion(complete: d.Value(!survey.complete)));
          }
          //Some are left in progress
          else if (result!.containsKey(SurveyStatus.inProgress)) {
            Popups.showDismiss(context, "Error: Surveys in progress",
                contentText:
                    "There are survey cards that are still in progress."
                    "${result![SurveyStatus.inProgress]}"
                    "\nPlease complete or delete to continue.");
          }
          //Case where no card has been started
          else if (result!.containsKey(SurveyStatus.complete)) {
            Popups.showDismiss(context, "Error: No survey cards complete",
                contentText: "No survey cards have been marked as complete."
                    "${result![SurveyStatus.inProgress]}"
                    "\nPlease complete or delete to continue.");
          }
          //Case where at least one card has been started
          else if (result!.containsKey(SurveyStatus.notStarted)) {
            Popups.showDismiss(context, "Warning: Surveys not started",
                contentText:
                    "Please complete at least one survey card to mark as completed.");
          }
        },
      ),
      body: Center(
        child: Column(
          children: [
            //Header Data
            TitledBorder(
                title: "Header Data",
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextLineLabelTop(
                                value: Text(survey.province),
                                label: const Text("Jurisdiction")),
                            TextLineLabelTop(
                                value: Text(survey.nfiPlot.toString()),
                                label: const Text("Plot Number")),
                          ],
                        ),
                        kDividerV,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextLineLabelTop(
                                value: Text(survey.measNum.toString()),
                                label: const Text("Meas. Number")),
                            TextLineLabelTop(
                                value: Text(FormatDate.toStr(survey.measDate)),
                                label: const Text("Meas. Date")),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            const Divider(
              thickness: 2,
            ),
            Expanded(
              child: ListView(
                children: tileCards,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<SurveyStatus, String>? checkAllComplete() {
    String notStarted = "";
    String inProgress = "";
    bool oneComplete = false;

    for (SurveyCard card in cards) {
      SurveyStatus status = getStatus(card.surveyCardData);
      if (status == SurveyStatus.inProgress) {
        inProgress = "$inProgress\n${card.name}";
      } else if (status == SurveyStatus.notStarted) {
        notStarted = "$notStarted\n${card.name}";
      } else if (!oneComplete && status == SurveyStatus.complete) {
        oneComplete = true;
      }
    }

    //Case there are surveys left in progress
    if (inProgress.isNotEmpty) {
      return {SurveyStatus.inProgress: inProgress};
    }
    //Case there are no surveys in progress or marked as complete
    else if (!oneComplete) {
      return {SurveyStatus.complete: ""};
    }
    //Case there is none in progress, at least one marked as complete
    else if (notStarted.isNotEmpty) {
      return {SurveyStatus.notStarted: notStarted};
    }

    //Case every card is marked complete
    return null;
  }

  SurveyStatus getStatus(dynamic data) {
    if (data == null) {
      return SurveyStatus.notStarted;
    } else if (data?.complete) {
      return SurveyStatus.complete;
    } else {
      return SurveyStatus.inProgress;
    }
  }

  List<TileCardSelection> generateTileCards(List<SurveyCard> cards) {
    final Database db = Database.instance;

    List<TileCardSelection> tileCards = [];

    for (int i = 0; i < cards.length; i++) {
      SurveyCardCategories category = cards[i].category;
      String name = cards[i].name;
      dynamic data = cards[i].surveyCardData;

      tileCards.add(TileCardSelection(
          title: name,
          status: getStatus(data),
          onPressed: () {
            getNav(category, data);
          }));
    }

    return tileCards;
  }

  void getNav(SurveyCardCategories category, dynamic data) async {
    final Database db = Database.instance;

    switch (category) {
      case SurveyCardCategories.woodyDebris:
        var tmp = await context.pushNamed(
          Routes.woodyDebris,
          extra: data == null
              ?
              //Insert empty wdSummaryCompanion
              {
                  WoodyDebrisSummaryPage.keyWdSummary: await db
                      .woodyDebrisTablesDao
                      .addAndReturnDefaultWdSummary(survey.id, survey.measDate),
                  WoodyDebrisSummaryPage.keyTransList: <WoodyDebrisHeaderData>[]
                }
              : {
                  WoodyDebrisSummaryPage.keyWdSummary: data,
                  WoodyDebrisSummaryPage.keyTransList: await db
                      .woodyDebrisTablesDao
                      .getWdHeadersFromWdsId(data.id)
                },
        );
        break;
      case SurveyCardCategories.surfaceSubstrate:
        var tmp = await context.pushNamed(
          Routes.surfaceSubstrate,
          extra: data == null
              ?
              //Insert empty wdSummaryCompanion
              {
                  SurfaceSubstrateSummaryPage.keySsSummary: await db
                      .surfaceSubstrateTablesDao
                      .addAndReturnDefaultSsSummary(survey.id, survey.measDate),
                  SurfaceSubstrateSummaryPage.keyTransList:
                      <SurfaceSubstrateHeaderData>[]
                }
              : {
                  SurfaceSubstrateSummaryPage.keySsSummary: data,
                  SurfaceSubstrateSummaryPage.keyTransList:
                      <SurfaceSubstrateHeaderData>[]
                },
        );
        break;
    }
    db.getCards(widget.surveyHeader.id).then((value) => setState(() {
          cards = value;
          tileCards = generateTileCards(value);
        }));
  }
}
