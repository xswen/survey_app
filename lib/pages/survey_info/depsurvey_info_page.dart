import 'dart:collection';

import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/enums/enums.dart';
import 'package:survey_app/formatters/format_string.dart';
import 'package:survey_app/widgets/popups/popup_continue.dart';
import 'package:survey_app/widgets/popups/popup_dismiss.dart';
import 'package:survey_app/widgets/tile_cards/tile_card_selection.dart';
import 'package:survey_app/wrappers/survey_card.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/format_date.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/edit_icon_button.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/titled_border.dart';
import '../surface_substrate/surface_substrate_summary_page.dart';
import '../woody_debris/woody_debris_summary_page.dart';
import 'create_survey_page.dart';

class DepSurveyInfoPage extends StatefulWidget {
  static const String routeName = "surveyInfo";
  static const String keySurvey = "survey";
  static const String keyCards = "cards";
  static const String keyUpdateDash = "updateDashboard";

  const DepSurveyInfoPage(
      {super.key,
      required this.surveyHeader,
      required this.cards,
      required this.updateDashboard});
  final String title = "Survey Info Page";

  final SurveyHeader surveyHeader;
  final List<SurveyCard> cards;
  final void Function() updateDashboard;

  @override
  State<DepSurveyInfoPage> createState() => _DepSurveyInfoPageState();
}

class _DepSurveyInfoPageState extends State<DepSurveyInfoPage> {
  late SurveyHeader survey;
  late List<SurveyCard> cards;
  late List<TileCardSelection> tileCards;

  HashSet<SurveyStatus> filters = HashSet<SurveyStatus>();

  @override
  void initState() {
    survey = widget.surveyHeader;
    cards = widget.cards;
    tileCards = generateTileCards(widget.cards);
    super.initState();
  }

  Map<SurveyStatus, List<String>>? checkAllComplete() {
    List<String> notStarted = [];
    List<String> inProgress = [];
    bool oneComplete = false;

    for (SurveyCard card in cards) {
      SurveyStatus status = getStatus(card.surveyCardData);
      if (status == SurveyStatus.inProgress) {
        inProgress.add(card.name);
      } else if (status == SurveyStatus.notStarted) {
        notStarted.add(card.name);
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
      return {
        SurveyStatus.complete: ["None complete"]
      };
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
    List<TileCardSelection> tileCards = [];

    for (SurveyCard card in cards) {
      SurveyCardCategories category = card.category;
      String name = card.name;
      dynamic data = card.surveyCardData;

      tileCards.add(TileCardSelection(
        title: name,
        status: getStatus(data),
        onPressed: () {
          if (survey.complete && data == null) {
            Popups.show(
                context,
                PopupDismiss(
                  "Nothing to show",
                  contentText: "Survey has been marked as complete. "
                      "No data found for $name. Please mark survey as "
                      "edit if you wish to add data to $name",
                ));
            return;
          }
          getNav(category, data);
        },
      ));
    }

    return tileCards;
  }

  //Behaviour when tile is clicked. Set state and regenerate cards on return.
  void getNav(SurveyCardCategories category, dynamic data) async {
    final Database db = Database.instance;

    switch (category) {
      case SurveyCardCategories.woodyDebris:
        var tmp = await context.pushNamed(
          WoodyDebrisSummaryPage.routeName,
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
                      .getWdHeadersFromWdSId(data.id)
                },
        );
        break;
      case SurveyCardCategories.surfaceSubstrate:
        var tmp = await context.pushNamed(
          SurfaceSubstrateSummaryPage.routeName,
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
    db
        .getCards(widget.surveyHeader.id, filters: filters)
        .then((value) => setState(() {
              cards = value;
              tileCards = generateTileCards(value);
            }));
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    Future<void> updateSummary(SurveyHeadersCompanion entry) async {
      (db.update(db.surveyHeaders)..where((t) => t.id.equals(survey.id)))
          .write(entry);
      db.surveyInfoTablesDao
          .getSurvey(survey.id)
          .then((value) => setState(() => survey = value));
    }

    //Add or remove filter based on select and set state after call on db
    // to update. Status set to null if "All" is selected
    void filterOnSelect(bool selected, SurveyStatus? status) async {
      if (selected) {
        status == null
            ? filters = HashSet<SurveyStatus>()
            : filters.add(status);
      } else {
        status == null
            ? filters = HashSet<SurveyStatus>.of({
                SurveyStatus.complete,
                SurveyStatus.inProgress,
                SurveyStatus.notStarted
              })
            : filters.remove(status);
      }

      cards = await db.getCards(survey.id, filters: filters);
      tileCards = generateTileCards(cards);
      setState(() {});
    }

    return Scaffold(
      appBar: OurAppBar(backFn: () {
        widget.updateDashboard();
        context.pop();
      }, widget.title),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      floatingActionButton: FloatingCompleteButton(
        title: widget.title,
        complete: survey.complete,
        onPressed: () async {
          if (survey.complete) {
            updateSummary(
                const SurveyHeadersCompanion(complete: d.Value(false)));
          } else {
            Map<SurveyStatus, List<String>>? result = checkAllComplete();
            //All good
            if (result == null) {
              updateSummary(
                  SurveyHeadersCompanion(complete: d.Value(!survey.complete)));
            }
            //Some are left in progress
            else if (result.containsKey(SurveyStatus.inProgress)) {
              Popups.show(
                  context,
                  PopupDismiss(
                    "Error: Surveys in progress",
                    contentWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "There are survey cards that are still in progress.",
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            FormatString.generateBulletList(
                                result[SurveyStatus.inProgress] ??
                                    ["Error no in progress found"]),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const Text(
                          "Please complete or delete to continue.",
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ));
            }
            //Case where no card has been started
            else if (result.containsKey(SurveyStatus.complete)) {
              Popups.show(
                  context,
                  const PopupDismiss("Error: No survey cards complete",
                      contentText:
                          "No survey cards have been marked as complete."
                          "\nPlease complete at least one survey card to mark as completed."));
            }
            //Case where at least one card has been started
            else if (result.containsKey(SurveyStatus.notStarted)) {
              Popups.show(
                  context,
                  PopupContinue("Warning: Not all survey cards are completed",
                      contentWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "The following survey cards are still not completed",
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              FormatString.generateBulletList(
                                  result[SurveyStatus.notStarted] ??
                                      ["Error no notStarted found"]),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Text(
                            "Are you sure you want to continue?",
                            textAlign: TextAlign.start,
                          )
                        ],
                      ), rightBtnOnPressed: () {
                    updateSummary(SurveyHeadersCompanion(
                        complete: d.Value(!survey.complete)));
                    context.pop();
                  }));
            }
          }
        },
      ),
      body: Center(
        child: Column(
          children: [
            //Header Data
            TitledBorder(
                title: "Header Data",
                actions: EditIconButton(onPressed: () async {
                  if (survey.complete) {
                    Popups.show(
                        context, Popups.generateCompleteErrorPopup("Survey"));
                  } else {
                    db.referenceTablesDao
                        .getJurisdictionName(survey.province, context.locale)
                        .then((provinceName) async => context.pushNamed(
                              CreateSurveyPage.routeName,
                              queryParameters: {"province": provinceName},
                              extra: {
                                CreateSurveyPage.keySurvey:
                                    survey.toCompanion(true),
                                CreateSurveyPage.keyUpdateDash: null,
                                CreateSurveyPage.keyLastMeasNum: await (db
                                    .referenceTablesDao
                                    .getLastMeasNum(survey.nfiPlot))
                              },
                            ).then((value) => db.surveyInfoTablesDao
                                .getSurvey(survey.id)
                                .then((newSurvey) =>
                                    setState(() => survey = newSurvey))));
                  }
                }),
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
            Wrap(
              alignment: WrapAlignment.start,
              spacing: kPaddingH,
              children: [
                FilterChip(
                  backgroundColor: Colors.tealAccent[200],
                  label: const Text("All"),
                  selected: filters.isEmpty,
                  onSelected: (selected) async =>
                      filterOnSelect(selected, null),
                  selectedColor: Colors.purpleAccent,
                ),
                FilterChip(
                  backgroundColor: Colors.tealAccent[200],
                  label: const Text("Completed"),
                  selected: filters.contains(SurveyStatus.complete),
                  onSelected: (selected) =>
                      filterOnSelect(selected, SurveyStatus.complete),
                  selectedColor: Colors.purpleAccent,
                ),
                FilterChip(
                  backgroundColor: Colors.tealAccent[200],
                  label: const Text("In Progress"),
                  selected: filters.contains(SurveyStatus.inProgress),
                  onSelected: (selected) async =>
                      filterOnSelect(selected, SurveyStatus.inProgress),
                  selectedColor: Colors.purpleAccent,
                ),
                FilterChip(
                  backgroundColor: Colors.tealAccent[200],
                  label: const Text("Not Started"),
                  selected: filters.contains(SurveyStatus.notStarted),
                  onSelected: (selected) async =>
                      filterOnSelect(selected, SurveyStatus.notStarted),
                  selectedColor: Colors.purpleAccent,
                ),
              ],
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
}