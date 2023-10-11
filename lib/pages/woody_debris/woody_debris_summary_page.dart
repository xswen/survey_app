import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_header_page.dart';
import 'package:survey_app/providers/providers.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../enums/enums.dart';
import '../../routes/router_params.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/tile_cards/tile_card_selection.dart';
import 'wood_debris_header_measurements_page.dart';

class WoodyDebrisSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "woodyDebrisSummary";
  final GoRouterState goRouterState;
  const WoodyDebrisSummaryPage(this.goRouterState, {super.key});

  @override
  WoodyDebrisSummaryPageState createState() => WoodyDebrisSummaryPageState();
}

class WoodyDebrisSummaryPageState
    extends ConsumerState<WoodyDebrisSummaryPage> {
  final String title = "Woody Debris";
  late final int surveyId;
  late final int wdId;
  late final FutureProvider<WoodyDebrisSummaryData> woodyDebrisProvider;
  late final FutureProvider<List<WoodyDebrisHeaderData>> transListProvider;

  @override
  void initState() {
    surveyId = int.parse(
        widget.goRouterState.pathParameters[RouteParams.surveyIdKey]!);
    wdId = int.parse(
        widget.goRouterState.pathParameters[RouteParams.wdSummaryIdKey]!);

    woodyDebrisProvider = FutureProvider<WoodyDebrisSummaryData>((ref) => ref
        .read(databaseProvider)
        .woodyDebrisTablesDao
        .getWdSummary(int.parse(
            widget.goRouterState.pathParameters[RouteParams.surveyIdKey]!)));
    transListProvider = FutureProvider<List<WoodyDebrisHeaderData>>((ref) => ref
        .read(databaseProvider)
        .woodyDebrisTablesDao
        .getWdHeadersFromWdSId(int.parse(
            widget.goRouterState.pathParameters[RouteParams.wdSummaryIdKey]!)));
    super.initState();
  }

  Future<void> updateWdSummary(WoodyDebrisSummaryCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.woodyDebrisSummary)..where((t) => t.id.equals(wdId)))
        .write(entry);
    ref.refresh(woodyDebrisProvider);
  }

  void goToWdhPage(int wdhId) {
    context.pushNamed(WoodyDebrisHeaderPage.routeName,
        pathParameters: RouteParams.generateWdHeaderParms(
            widget.goRouterState, wdhId.toString()));
  }

  SurveyStatus getStatus(WoodyDebrisHeaderData wdh) {
    if (wdh.complete) return SurveyStatus.complete;
    if (wdh.transNum == null) return SurveyStatus.notStarted;
    return SurveyStatus.inProgress;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(title);

    AsyncValue<WoodyDebrisSummaryData> wdSummary =
        ref.watch(woodyDebrisProvider);
    AsyncValue<List<WoodyDebrisHeaderData>> transList =
        ref.watch(transListProvider);

    return Scaffold(
      appBar: OurAppBar(title),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
        child: wdSummary.when(
            error: (err, stack) => Text("Error: $err"),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (wd) {
              final PopupDismiss surveyCompleteWarningPopup =
                  Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

              return Column(
                children: [
                  CalendarSelect(
                    date: wd.measDate,
                    label: "Enter Measurement Date",
                    readOnly: wd.complete,
                    readOnlyPopup: completeWarningPopup,
                    setStateFn: (DateTime date) async => updateWdSummary(
                        WoodyDebrisSummaryCompanion(measDate: d.Value(date))),
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
                                      WoodyDebrisHeaderMeasurementsPage
                                              .keyWdHeader:
                                          WoodyDebrisHeaderCompanion(
                                              wdId: d.Value(wd.id),
                                              complete: const d.Value(false)),
                                      WoodyDebrisHeaderMeasurementsPage
                                              .keyUpdateSummaryPageTransList:
                                          () => null
                                    }).then(
                                    (value) => ref.refresh(transListProvider)),
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
                      child: transList.when(
                    data: (transList) {
                      bool checkHeadersComplete() {
                        for (int i = 0; i < transList.length; i++) {
                          if (!transList[i].complete) return false;
                        }
                        return true;
                      }

                      return Scaffold(
                        floatingActionButton: FloatingCompleteButton(
                          title: title,
                          complete: wd.complete,
                          onPressed: () {
                            db.surveyInfoTablesDao
                                .getSurvey(wd.surveyId)
                                .then((value) {
                              bool surveyComplete = value.complete;
                              if (surveyComplete) {
                                Popups.show(
                                    context, surveyCompleteWarningPopup);
                              } else if (wd.complete) {
                                updateWdSummary(
                                    const WoodyDebrisSummaryCompanion(
                                        complete: d.Value(false)));
                              } else if (transList.isEmpty) {
                                Popups.showMissingTransect(context);
                              } else {
                                checkHeadersComplete()
                                    ? updateWdSummary(
                                        const WoodyDebrisSummaryCompanion(
                                            complete: d.Value(true)))
                                    : Popups.showIncompleteTransect(context);
                              }
                            });
                          },
                        ),
                        body: ListView.builder(
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
                                              () => goToWdhPage(wdh.id),
                                            ))
                                        : goToWdhPage(wdh.id);
                                  },
                                  status: getStatus(wdh));
                            }),
                      );
                    },
                    error: (err, stack) => Text("Error: $err"),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ))
                ],
              );
            }),
      ),
    );
  }
}
