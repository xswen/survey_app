import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_summary_page.dart';
import 'package:survey_app/pages/micro_plot/micro_plot_summary.dart';
import 'package:survey_app/widgets/popups/popup_notice_survey_complete.dart';
import 'package:survey_app/widgets/popups/popups_survey_info_mark_not_assessed.dart';
import 'package:survey_app/widgets/text/notify_no_filter_results.dart';
import 'package:survey_app/widgets/tile_cards/tile_card_survey.dart';

import '../../formatters/format_date.dart';
import '../../formatters/format_string.dart';
import '../../providers/survey_info_providers.dart';
import '../../widgets/buttons/edit_icon_button.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/popups/popup_marked_complete.dart';
import '../../widgets/tags/tag_chips.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/titled_border.dart';
import '../../wrappers/survey_card.dart';
import '../ecological_plot/ecological_plot_summary_page.dart';
import '../large_tree_plot/large_tree_plot_summary.dart';
import '../shrub_plot/shrub_plot_summary.dart';
import '../small_tree_plot/small_tree_plot_summary.dart';
import '../soil_pit/soil_pit_summary_page.dart';
import '../stump_plot/stump_plot_summary_page.dart';
import '../surface_substrate/surface_substrate_summary_page.dart';
import '../woody_debris/woody_debris_summary_page.dart';
import 'create_survey_page.dart';
import 'survey_info_header_info/survey_info_summary_page.dart';

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

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.goRouterState)!;

    super.initState();
  }

  Map<SurveyStatus, List<String>>? checkAllComplete(List<SurveyCard> cards) {
    List<String> notStarted = [];
    List<String> inProgress = [];
    List<String> notAssessed = [];
    bool oneComplete = false;

    for (SurveyCard card in cards) {
      SurveyStatus status = getStatus(card.surveyCardData);
      if (status == SurveyStatus.inProgress) {
        inProgress.add(card.name);
      } else if (status == SurveyStatus.notStarted) {
        notStarted.add(card.name);
      } else if (!oneComplete && status == SurveyStatus.complete) {
        oneComplete = true;
      } else if (status == SurveyStatus.notAssessed) {
        notAssessed.add(card.name);
      }
    }

    //Case there are surveys left in progress
    if (inProgress.isNotEmpty) {
      return {SurveyStatus.inProgress: inProgress};
    }
    //Case there is none in progress, but some are still left not started
    else if (notStarted.isNotEmpty) {
      return {SurveyStatus.notStarted: notStarted};
    }
    //All surveys are accounted for but not a single survey is marked as complete
    else if (!oneComplete) {
      return {
        SurveyStatus.complete: ["None complete"]
      };
    } else if (notAssessed.isNotEmpty) {
      return {SurveyStatus.notAssessed: notAssessed};
    }

    //Case every card is marked complete or not assessed
    return null;
  }

  SurveyStatus getStatus(dynamic data) {
    if (data == null) {
      return SurveyStatus.notStarted;
    } else if (data?.notAssessed) {
      return SurveyStatus.notAssessed;
    } else if (data?.complete) {
      return SurveyStatus.complete;
    } else {
      return SurveyStatus.inProgress;
    }
  }

  List<TileCardSurvey> generateTileCards(
      SurveyHeader survey, List<SurveyCard> cards) {
    List<TileCardSurvey> tileCards = [];

    for (SurveyCard card in cards) {
      SurveyCardCategories category = card.category;
      String name = card.name;
      dynamic data = card.surveyCardData;

      PopupDismiss popup = PopupDismiss(
        "Nothing to show",
        contentText: "Survey has been marked as complete and $name is marked"
            "as 'Not Assessed'. Please mark survey as "
            "edit if you wish to add data to $name",
      );

      tileCards.add(TileCardSurvey(
        title: name,
        status: getStatus(data),
        onNotAssessed: () {
          if (survey.complete && data == null) {
            Popups.show(context, popup);
            return;
          }
          data != null
              ? Popups.show(context,
                  PopupsSurveyInfoMarkNotAssessed(rightBtnOnPressed: () {
                  getMarkNotAssessed(category, data);
                  context.pop();
                }))
              : getMarkNotAssessed(category, data);
        },
        onPressed: () {
          if (survey.complete && data == null) {
            Popups.show(context, popup);
          } else if (survey.complete) {
            Popups.show(
                context,
                PopupNoticeSurveyComplete(
                    title: "Survey",
                    rightBtnOnPressed: () {
                      getNav(survey, category, data);
                      context.pop();
                    }));
          } else if (data?.notAssessed ?? false) {
            handleNotAssessed(() => getNav(survey, category, data));
          } else {
            getNav(survey, category, data);
          }
        },
      ));
    }

    return tileCards;
  }

  void getMarkNotAssessed(SurveyCardCategories category, dynamic data) async {
    final Database db = Database.instance;

    Future<void>? markNotAssessed;

    switch (category) {
      case SurveyCardCategories.surveyHeader:
        markNotAssessed =
            db.surveyInfoTablesDao.markNotAssessed(surveyId, data?.id);
        break;
      case SurveyCardCategories.woodyDebris:
        markNotAssessed =
            db.woodyDebrisTablesDao.markNotAssessed(surveyId, data?.id);
        break;
      case SurveyCardCategories.surfaceSubstrate:
        markNotAssessed =
            db.surfaceSubstrateTablesDao.markNotAssessed(surveyId, data?.id);
        break;
      case SurveyCardCategories.ecologicalPlot:
        markNotAssessed =
            db.ecologicalPlotTablesDao.markNotAssessed(surveyId, data?.id);
        break;
      case SurveyCardCategories.soilPit:
        markNotAssessed =
            db.soilPitTablesDao.markNotAssessed(surveyId, data?.id);
        break;
      case SurveyCardCategories.smallTreePlot:
        markNotAssessed =
            db.smallTreePlotTablesDao.markNotAssessed(surveyId, data?.id);
        break;
      case SurveyCardCategories.shrubPlot:
        markNotAssessed =
            db.shrubPlotTablesDao.markNotAssessed(surveyId, data?.id);
        break;
      case SurveyCardCategories.stumpPlot:
        markNotAssessed =
            db.stumpPlotTablesDao.markNotAssessed(surveyId, data?.id);
        break;
      default:
        debugPrint("Error: case not handled for $category");
        return;
    }

    markNotAssessed
        .then((value) => ref.refresh(updateSurveyCardProvider(surveyId)));
  }

  void handleNotAssessed(Function() fn) {
    Popups.show(
        context,
        PopupContinue(
          "Warning: Card marked as 'Not Assessed'",
          contentText: "This card has already been marked as not assessed. "
              "Pressing continue will mark it as assessed. Are you sure you"
              " want to continue?",
          rightBtnOnPressed: () {
            fn();
            context.pop();
          },
        ));
  }

  //Behaviour when tile is clicked. Set state and regenerate cards on return.
  void getNav(
      SurveyHeader survey, SurveyCardCategories category, dynamic data) async {
    final Database db = Database.instance;

    Future<int> getId(Future<dynamic> Function() fn) async =>
        (data == null || data.notAssessed) ? (await fn()).id : data.id;

    switch (category) {
      case SurveyCardCategories.surveyHeader:
        getId(() =>
            db.surveyInfoTablesDao.setAndReturnDefaultSummary(survey.id)).then(
          (id) => context.pushNamed(SurveyInfoSummaryPage.routeName,
              pathParameters: widget.goRouterState.pathParameters),
        );
        break;
      case SurveyCardCategories.groundPlot:
        context.pushNamed(GroundPlotSummaryPage.routeName,
            pathParameters: widget.goRouterState.pathParameters);

        break;
      case SurveyCardCategories.woodyDebris:
        getId(() => db.woodyDebrisTablesDao
            .setAndReturnDefaultWdSummary(survey.id, survey.measDate)).then(
          (id) => context.pushNamed(WoodyDebrisSummaryPage.routeName,
              pathParameters: PathParamGenerator.wdSummary(
                  widget.goRouterState, id.toString())),
        );
        break;
      case SurveyCardCategories.surfaceSubstrate:
        getId(() => db.surfaceSubstrateTablesDao
            .setAndReturnDefaultSsSummary(survey.id, survey.measDate)).then(
          (id) => context.pushNamed(SurfaceSubstrateSummaryPage.routeName,
              pathParameters: PathParamGenerator.ssSummary(
                  widget.goRouterState, id.toString())),
        );
        break;
      case SurveyCardCategories.ecologicalPlot:
        getId(() => db.ecologicalPlotTablesDao
            .setAndReturnDefaultSummary(survey.id, survey.measDate)).then(
          (id) => context.pushNamed(EcologicalPlotSummaryPage.routeName,
              pathParameters: PathParamGenerator.ecpSummary(
                  widget.goRouterState, id.toString())),
        );
        break;
      case SurveyCardCategories.soilPit:
        getId(() => db.soilPitTablesDao
            .setAndReturnDefaultSummary(survey.id, survey.measDate)).then(
          (id) => context.pushNamed(SoilPitSummaryPage.routeName,
              pathParameters: PathParamGenerator.soilPitSummary(
                  widget.goRouterState, id.toString())),
        );
        break;
      case SurveyCardCategories.smallTreePlot:
        getId(() => db.smallTreePlotTablesDao
            .setAndReturnDefaultSummary(survey.id, survey.measDate)).then(
          (id) => context.pushNamed(SmallTreePlotSummaryPage.routeName,
              pathParameters: PathParamGenerator.stpSummary(
                  widget.goRouterState, id.toString())),
        );
        break;
      case SurveyCardCategories.shrubPlot:
        getId(() => db.shrubPlotTablesDao
            .setAndReturnDefaultSummary(survey.id, survey.measDate)).then(
          (id) => context.pushNamed(
            ShrubPlotSummaryPage.routeName,
            pathParameters: PathParamGenerator.shrubSummary(
                widget.goRouterState, id.toString()),
          ),
        );
        break;
      case SurveyCardCategories.stumpPlot:
        getId(() => db.stumpPlotTablesDao
            .setAndReturnDefaultSummary(survey.id, survey.measDate)).then(
          (id) => context.pushNamed(
            StumpPlotSummaryPage.routeName,
            pathParameters: PathParamGenerator.stumpSummary(
                widget.goRouterState, id.toString()),
          ),
        );
        break;
      case SurveyCardCategories.largeTreePlot:
        if (context.mounted) {
          context
              .pushNamed(LargeTreePlotSummaryPage.routeName,
                  pathParameters: widget.goRouterState.pathParameters)
              .then((value) => ref.refresh(updateSurveyCardProvider(surveyId)));
        }
        break;
      case SurveyCardCategories.microPlot:
        if (context.mounted) {
          context
              .pushNamed(MicroPlotSummaryPage.routeName,
                  pathParameters: widget.goRouterState.pathParameters)
              .then((value) => ref.refresh(updateSurveyCardProvider(surveyId)));
        }
        break;
      default:
        debugPrint("Error: case not handled for $category");
        return;
    }
  }

  Future<void> updateSummary(SurveyHeadersCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.surveyHeaders)..where((t) => t.id.equals(surveyId)))
        .write(entry);
    ref.refresh(updateSurveyProvider(surveyId));
  }

  void markComplete(SurveyHeader survey, List<SurveyCard> cards) {
    if (survey.complete) {
      updateSummary(const SurveyHeadersCompanion(complete: d.Value(false)));
    } else {
      Map<SurveyStatus, List<String>>? result = checkAllComplete(cards);
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
                    "Please complete or mark as 'not assessed' to continue.",
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ));
      }
      //Case some cards are left as not started
      else if (result.containsKey(SurveyStatus.notStarted)) {
        Popups.show(
            context,
            PopupDismiss(
              "Error: Surveys not accounted for",
              contentWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "There are survey cards that are still unaccounted for. "
                    "Please complete or mark as not assessed to continue.",
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      FormatString.generateBulletList(
                          result[SurveyStatus.notStarted] ??
                              ["Error no not started surveys found"]),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Text(
                    "Please complete or mark as 'not assessed' to continue.",
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ));
      }
      //Case where no card has been completed
      else if (result.containsKey(SurveyStatus.complete)) {
        Popups.show(
            context,
            const PopupDismiss("Error: No survey cards complete",
                contentText: "No survey cards have been marked as complete."
                    "\nPlease complete at least one survey card to mark as completed."));
      }
      //Case where at least one card has been completed
      else if (result.containsKey(SurveyStatus.notAssessed)) {
        Popups.show(
            context,
            PopupContinue("Warning: Some survey cards marked as not assessed",
                contentWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "The following survey cards have been marked as not assessed",
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        FormatString.generateBulletList(
                            result[SurveyStatus.notStarted] ??
                                ["Error no not assessed cards found"]),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Text(
                      "Are you sure you want to continue?",
                      textAlign: TextAlign.start,
                    )
                  ],
                ), rightBtnOnPressed: () {
              updateSummary(
                  const SurveyHeadersCompanion(complete: d.Value(true)));
              Popups.show(context, PopupMarkedComplete(title: title));
              context.pop();
            }));
      } else {
        updateSummary(const SurveyHeadersCompanion(complete: d.Value(true)));
        Popups.show(context, PopupMarkedComplete(title: title));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Database db = ref.read(databaseProvider);

    AsyncValue<SurveyHeader> survey = ref.watch(updateSurveyProvider(surveyId));
    final filters = ref.watch(surveyCardFilterProvider);

    return survey.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => DefaultPageLoadingScaffold(title: title),
        data: (survey) {
          AsyncValue<List<SurveyCard>> cards =
              ref.watch(updateSurveyCardProvider(surveyId));
          return cards.when(
            error: (err, stack) => Text("Error: $err"),
            loading: () => DefaultPageLoadingScaffold(title: title),
            data: (cards) => Scaffold(
                appBar: OurAppBar(
                  title,
                  complete: survey.complete,
                  backFn: () {
                    ref.refresh(updateSurveyHeaderListProvider);
                    context.pop();
                  },
                ),
                endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
                bottomNavigationBar: MarkCompleteButton(
                    title: title,
                    complete: survey.complete,
                    onPressed: () => markComplete(survey, cards)),
                body: Center(
                  child: Column(
                    children: [
                      TitledBorder(
                          title: "Measurement Data",
                          actions: EditIconButton(onPressed: () async {
                            if (survey.complete) {
                              Popups.show(context,
                                  Popups.generateCompleteErrorPopup("Survey"));
                            } else {
                              db.referenceTablesDao
                                  .getJurisdictionName(
                                      survey.province, context.locale)
                                  .then((provinceName) async => context
                                          .pushNamed(
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
                                                  .getLastMeasNum(
                                                      survey.nfiPlot))
                                        },
                                      ).then((value) => ref.refresh(
                                              updateSurveyProvider(surveyId))));
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
                                          value:
                                              Text(survey.nfiPlot.toString()),
                                          label: const Text("Plot Number")),
                                    ],
                                  ),
                                  kDividerV,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextLineLabelTop(
                                          value:
                                              Text(survey.measNum.toString()),
                                          label: const Text("Meas. Number")),
                                      TextLineLabelTop(
                                          value: Text(FormatDate.toStr(
                                              survey.measDate)),
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
                                .read(surveyCardFilterProvider.notifier)
                                .selectedAll(selected),
                          ),
                          TagChip(
                            title: "Completed",
                            selected: filters.contains(SurveyStatus.complete),
                            onSelected: (selected) => ref
                                .read(surveyCardFilterProvider.notifier)
                                .selectedComplete(selected),
                          ),
                          TagChip(
                            title: "In Progress",
                            selected: filters.contains(SurveyStatus.inProgress),
                            onSelected: (selected) => ref
                                .read(surveyCardFilterProvider.notifier)
                                .selectedInProgress(selected),
                          ),
                          TagChip(
                            title: "Not Assessed",
                            selected:
                                filters.contains(SurveyStatus.notAssessed),
                            onSelected: (selected) => ref
                                .read(surveyCardFilterProvider.notifier)
                                .selectedNotAssessed(selected),
                          ),
                          TagChip(
                            title: "Not Started",
                            selected: filters.contains(SurveyStatus.notStarted),
                            onSelected: (selected) => ref
                                .read(surveyCardFilterProvider.notifier)
                                .selectedNotStarted(selected),
                          ),
                        ],
                      ),
                      cards.isEmpty
                          ? const NotifyNoFilterResults()
                          : Expanded(
                              child: ListView(
                                children: generateTileCards(survey, cards),
                              ),
                            ),
                    ],
                  ),
                )),
          );
        });
  }
}
