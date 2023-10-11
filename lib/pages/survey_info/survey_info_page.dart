import 'dart:collection';

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
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/edit_icon_button.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/tile_cards/tile_card_selection.dart';
import '../../widgets/titled_border.dart';
import '../../wrappers/survey_card.dart';
import '../surface_substrate/surface_substrate_summary_page.dart';
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

    switch (category) {
      case SurveyCardCategories.woodyDebris:
        context.pushNamed(
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
        context.pushNamed(
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

            return Scaffold(
              body: Center(
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
                                      queryParameters: {
                                        "province": provinceName
                                      },
                                      extra: {
                                        CreateSurveyPage.keySurvey:
                                            survey.toCompanion(true),
                                        CreateSurveyPage.keyUpdateDash: null,
                                        CreateSurveyPage.keyLastMeasNum:
                                            await (db.referenceTablesDao
                                                .getLastMeasNum(survey.nfiPlot))
                                      },
                                    ).then((value) => db.surveyInfoTablesDao
                                        .getSurvey(survey.id)
                                        .then((newSurvey) => setState(
                                            () => survey = newSurvey))));
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
                        child: ListView(
                          children: generateTileCards(survey, cards),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
