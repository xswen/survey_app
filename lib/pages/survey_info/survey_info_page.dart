import 'dart:collection';

import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/providers/providers.dart';
import 'package:survey_app/routes/router_routes_main.dart';
import 'package:survey_app/widgets/tags/tag_chips.dart';

import '../../constants/margins_padding.dart';
import '../../enums/enums.dart';
import '../../formatters/format_date.dart';
import '../../formatters/format_string.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/edit_icon_button.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/popups/popup_continue.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/tile_cards/tile_card_selection.dart';
import '../../widgets/titled_border.dart';
import '../../wrappers/survey_card.dart';
import '../woody_debris/woody_debris_summary_page.dart';
import 'create_survey_page.dart';

class _FilterNotifier extends StateNotifier<HashSet<SurveyStatus>> {
  _FilterNotifier() : super(HashSet<SurveyStatus>());

  void selectedAll(bool selected) => selected
      ? state = HashSet<SurveyStatus>()
      : state = HashSet<SurveyStatus>.of({
          SurveyStatus.complete,
          SurveyStatus.inProgress,
        });

  void selectedNotStarted(bool selected) => selected
      ? state = HashSet<SurveyStatus>.of({
          ...state,
          SurveyStatus.notStarted,
        })
      : state = HashSet<SurveyStatus>.of({
          for (final status in state)
            if (status != SurveyStatus.notStarted) status
        });

  void selectedInProgress(bool selected) => selected
      ? state = HashSet<SurveyStatus>.of({
          ...state,
          SurveyStatus.inProgress,
        })
      : state = HashSet<SurveyStatus>.of({
          for (final status in state)
            if (status != SurveyStatus.inProgress) status
        });

  void selectedComplete(bool selected) => selected
      ? state = HashSet<SurveyStatus>.of({
          ...state,
          SurveyStatus.complete,
        })
      : state = HashSet<SurveyStatus>.of({
          for (final status in state)
            if (status != SurveyStatus.complete) status
        });
}

final _filterProvider =
    StateNotifierProvider<_FilterNotifier, HashSet<SurveyStatus>>(
        (ref) => _FilterNotifier());

class SurveyInfoPage extends ConsumerStatefulWidget {
  static const String routeName = "surveyInfo";
  final GoRouterState goRouterState;
  const SurveyInfoPage({super.key, required this.goRouterState});

  @override
  SurveyInfoPageState createState() => SurveyInfoPageState();
}

class SurveyInfoPageState extends ConsumerState<SurveyInfoPage> {
  final String title = "Survey Info";
  late final int surveyId;
  late final FutureProvider<SurveyHeader> updateSurveyProvider;
  late final FutureProvider<List<SurveyCard>> updateSurveyCardsProvider;

  @override
  void initState() {
    surveyId = int.parse(
        widget.goRouterState.pathParameters[RouteParams.surveyIdKey]!);

    updateSurveyProvider = FutureProvider<SurveyHeader>((ref) {
      final rebuild = ref.watch(rebuildSurveyInfoProvider);
      return ref
          .watch(databaseProvider)
          .surveyInfoTablesDao
          .getSurvey(surveyId);
    });

    updateSurveyCardsProvider = FutureProvider<List<SurveyCard>>((ref) {
      final filter = ref.watch(_filterProvider);
      final rebuild = ref.watch(rebuildSurveyCardsProvider);

      return ref.read(databaseProvider).getCards(
          int.parse(
              widget.goRouterState.pathParameters[RouteParams.surveyIdKey]!),
          filters: filter);
    });

    super.initState();
  }

  Map<SurveyStatus, List<String>>? checkAllComplete(List<SurveyCard> cards) {
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

  List<TileCardSelection> generateTileCards(
      SurveyHeader survey, List<SurveyCard> cards) {
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
          getNav(survey, category, data);
        },
      ));
    }

    return tileCards;
  }

  //Behaviour when tile is clicked. Set state and regenerate cards on return.
  void getNav(
      SurveyHeader survey, SurveyCardCategories category, dynamic data) async {
    final Database db = Database.instance;

    if (category == SurveyCardCategories.woodyDebris) {
      int wdId = data == null
          ? (await db.woodyDebrisTablesDao
                  .addAndReturnDefaultWdSummary(survey.id, survey.measDate))
              .id
          : data.id;
      if (context.mounted) {
        context.pushNamed(WoodyDebrisSummaryPage.routeName,
            pathParameters: RouteParams.generateWdSummaryParams(
                widget.goRouterState, wdId.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final Database db = ref.read(databaseProvider);

    AsyncValue<SurveyHeader> survey = ref.watch(updateSurveyProvider);
    HashSet<SurveyStatus> filters = ref.watch(_filterProvider);

    Future<void> updateSummary(SurveyHeadersCompanion entry) async {
      (db.update(db.surveyHeaders)..where((t) => t.id.equals(surveyId)))
          .write(entry);
      ref.read(rebuildSurveyInfoProvider.notifier).update((state) => !state);
    }

    return Scaffold(
        appBar: OurAppBar(
          title,
          backFn: () {
            ref
                .read(rebuildDashboardProvider.notifier)
                .update((state) => !state);
            context.pop();
          },
        ),
        body: survey.when(
          error: (err, stack) => Text("Error: $err"),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (survey) {
            AsyncValue<List<SurveyCard>> cards =
                ref.watch(updateSurveyCardsProvider);

            return Center(
              child: Column(
                children: [
                  TitledBorder(
                      title: "Header Data",
                      actions: EditIconButton(onPressed: () async {
                        if (survey.complete) {
                          Popups.show(context,
                              Popups.generateCompleteErrorPopup("Survey"));
                        } else {
                          db.referenceTablesDao
                              .getJurisdictionName(
                                  survey.province, context.locale)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextLineLabelTop(
                                      value: Text(survey.measNum.toString()),
                                      label: const Text("Meas. Number")),
                                  TextLineLabelTop(
                                      value: Text(
                                          FormatDate.toStr(survey.measDate)),
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
                      TagChip(
                        title: "All",
                        selected: filters.isEmpty,
                        onSelected: (selected) => ref
                            .read(_filterProvider.notifier)
                            .selectedAll(selected),
                      ),
                      TagChip(
                        title: "Completed",
                        selected: filters.contains(SurveyStatus.complete),
                        onSelected: (selected) => ref
                            .read(_filterProvider.notifier)
                            .selectedComplete(selected),
                      ),
                      TagChip(
                        title: "In Progress",
                        selected: filters.contains(SurveyStatus.inProgress),
                        onSelected: (selected) => ref
                            .read(_filterProvider.notifier)
                            .selectedInProgress(selected),
                      ),
                      TagChip(
                        title: "Not Started",
                        selected: filters.contains(SurveyStatus.notStarted),
                        onSelected: (selected) => ref
                            .read(_filterProvider.notifier)
                            .selectedNotStarted(selected),
                      ),
                    ],
                  ),
                  cards.when(
                    error: (err, stack) => Text("Error: $err"),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    data: (cards) => Expanded(
                      child: Scaffold(
                        floatingActionButton: FloatingCompleteButton(
                          title: title,
                          complete: survey.complete,
                          onPressed: () async {
                            if (survey.complete) {
                              updateSummary(const SurveyHeadersCompanion(
                                  complete: d.Value(false)));
                            } else {
                              Map<SurveyStatus, List<String>>? result =
                                  checkAllComplete(cards);
                              //All good
                              if (result == null) {
                                updateSummary(SurveyHeadersCompanion(
                                    complete: d.Value(!survey.complete)));
                              }
                              //Some are left in progress
                              else if (result
                                  .containsKey(SurveyStatus.inProgress)) {
                                Popups.show(
                                    context,
                                    PopupDismiss(
                                      "Error: Surveys in progress",
                                      contentWidget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "There are survey cards that are still in progress.",
                                            textAlign: TextAlign.start,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 12),
                                            child: Text(
                                              FormatString.generateBulletList(
                                                  result[SurveyStatus
                                                          .inProgress] ??
                                                      [
                                                        "Error no in progress found"
                                                      ]),
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
                              else if (result
                                  .containsKey(SurveyStatus.complete)) {
                                Popups.show(
                                    context,
                                    const PopupDismiss(
                                        "Error: No survey cards complete",
                                        contentText:
                                            "No survey cards have been marked as complete."
                                            "\nPlease complete at least one survey card to mark as completed."));
                              }
                              //Case where at least one card has been started
                              else if (result
                                  .containsKey(SurveyStatus.notStarted)) {
                                Popups.show(
                                    context,
                                    PopupContinue(
                                        "Warning: Not all survey cards are completed",
                                        contentWidget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "The following survey cards are still not completed",
                                              textAlign: TextAlign.start,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              child: Text(
                                                FormatString.generateBulletList(
                                                    result[SurveyStatus
                                                            .notStarted] ??
                                                        [
                                                          "Error no notStarted found"
                                                        ]),
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
                        body: ListView(
                          children: generateTileCards(survey, cards),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
