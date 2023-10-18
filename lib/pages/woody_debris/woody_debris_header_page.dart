import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_summary_page.dart';

import '../../providers/woody_debris_providers.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../../widgets/popups/popup_warning_missing_fields_list.dart';
import '../delete_page.dart';
import 'woody_debris_header_measurements_page.dart';
import 'woody_debris_piece/woody_debris_header_piece_main.dart';

class WoodyDebrisHeaderPage extends ConsumerStatefulWidget {
  static const String routeName = "woodyDebrisHeader";
  final GoRouterState goRouterState;
  const WoodyDebrisHeaderPage(this.goRouterState, {super.key});

  @override
  WoodyDebrisHeaderPageState createState() => WoodyDebrisHeaderPageState();
}

class WoodyDebrisHeaderPageState extends ConsumerState<WoodyDebrisHeaderPage> {
  final PopupDismiss completeWarningPopup =
      Popups.generateCompleteErrorPopup("Woody Debris Transect");
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Woody Debris");

  late int wdId;
  late int wdhId;

  @override
  void initState() {
    wdId = RouteParams.getWdSummaryId(widget.goRouterState)!;
    wdhId = RouteParams.getWdHeaderId(widget.goRouterState)!;
    super.initState();
  }

  void updateWdhData(WoodyDebrisHeaderCompanion entry) {
    final db = ref.read(databaseProvider);

    (db.update(db.woodyDebrisHeader)..where((t) => t.id.equals(wdhId)))
        .write(entry);

    ref.refresh(wdhProvider(wdhId));
  }

  Future<int?> getOrCreateWdSmallId() async {
    final db = ref.read(databaseProvider);

    WoodyDebrisSmallData? wdSm = await (db.select(db.woodyDebrisSmall)
          ..where((tbl) => tbl.wdHeaderId.equals(wdhId)))
        .getSingleOrNull();

    wdSm ??
        db.woodyDebrisTablesDao
            .addWdSmall(WoodyDebrisSmallCompanion(wdHeaderId: d.Value(wdhId)));

    return (await db.woodyDebrisTablesDao.getWdSmall(wdhId))?.id;
  }

  //Return null on no issue. Otherwise return error message
  List<String>? errorCheck(
      WoodyDebrisHeaderData wdh, WoodyDebrisSmallData? wdSm) {
    List<String> results = [];

    if (wdh.transAzimuth == null ||
        wdh.lcwdMeasLen == null ||
        wdh.mcwdMeasLen == null ||
        wdh.nomTransLen == null ||
        wdh.swdMeasLen == null) {
      results.add("Transect Header Data");
    }
    if (wdSm == null) {
      results.add("Piece Measurements");
    }

    if (wdh.swdDecayClass == null) {
      results.add("Decay class not set in Piece Measurements");
    }

    return results.isEmpty ? null : results;
  }

  void markComplete(bool parentComplete, WoodyDebrisHeaderData wdh) {
    final db = ref.read(databaseProvider);
    print(wdh);
    if (parentComplete) {
      Popups.show(context, surveyCompleteWarningPopup);
    } else if (wdh.complete) {
      updateWdhData(const WoodyDebrisHeaderCompanion(complete: d.Value(false)));
    } else {
      (db.woodyDebrisTablesDao.getWdSmall(wdh.id)).then((wdSm) {
        List<String>? errors = errorCheck(wdh, wdSm);

        if (errors == null) {
          List<String> missingData = [];
          wdh.swdDecayClass == -1
              ? missingData.add("Transect Header Data")
              : null;
          missingData.isEmpty
              ? updateWdhData(
                  const WoodyDebrisHeaderCompanion(complete: d.Value(true)))
              : Popups.show(
                  context,
                  PopupWarningMissingFieldsList(
                      missingFields: missingData,
                      rightBtnOnPressed: () {
                        updateWdhData(const WoodyDebrisHeaderCompanion(
                            complete: d.Value(true)));
                        context.pop();
                      }));
        } else {
          Popups.show(
            context,
            PopupErrorsFoundList(errors: errors),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = ref.read(databaseProvider);

    final parentComplete = ref.watch(wdhParentCompleteProvider(wdId));
    final AsyncValue<WoodyDebrisHeaderData> wdh = ref.watch(wdhProvider(wdhId));

    return wdh.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (wdh) {
          return parentComplete.when(
              error: (err, stack) => Text("Error: $err"),
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (parentComplete) => Scaffold(
                    appBar: OurAppBar("Woody Debris: Transect ${wdh.transNum}"),
                    endDrawer:
                        DrawerMenu(onLocaleChange: () => setState(() {})),
                    floatingActionButton: FloatingCompleteButton(
                      title: "Woody Debris Transect ${wdh.transNum}",
                      complete: wdh.complete,
                      onPressed: () => markComplete(parentComplete, wdh),
                    ),
                    body: Center(
                      child: Column(
                        children: [
                          IconNavButton(
                            icon: const Icon(FontAwesomeIcons.file),
                            space: kPaddingIcon,
                            label: "Transect Header Data",
                            onPressed: () async {
                              context
                                  .pushNamed(
                                    WoodyDebrisHeaderMeasurementsPage.routeName,
                                    pathParameters:
                                        RouteParams.generateWdHeaderParms(
                                            widget.goRouterState,
                                            wdhId.toString()),
                                  )
                                  .then((value) =>
                                      ref.refresh(wdhProvider(wdhId)));
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV, horizontal: kPaddingH),
                          ),
                          IconNavButton(
                            icon: const Icon(FontAwesomeIcons.ruler),
                            space: kPaddingIcon,
                            label: "Piece Measurements",
                            onPressed: () async {
                              getOrCreateWdSmallId().then((wdSmallId) {
                                wdSmallId == null
                                    ? debugPrint("Error, wdSmall returned null")
                                    : null;
                                context
                                    .pushNamed(
                                        WoodyDebrisHeaderPieceMainPage
                                            .routeName,
                                        pathParameters:
                                            RouteParams.generateWdSmallParms(
                                                widget.goRouterState,
                                                wdSmallId.toString()))
                                    .then((value) =>
                                        ref.refresh(wdTransListProvider(wdId)));
                              });
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV, horizontal: kPaddingH),
                          ),
                          IconNavButton(
                            icon: const Icon(FontAwesomeIcons.trash),
                            space: kPaddingIcon,
                            label: "Delete Transect",
                            onPressed: () {
                              if (parentComplete || wdh.complete) {
                                Popups.show(context, completeWarningPopup);
                                return;
                              }
                              Popups.show(
                                context,
                                PopupContinue("Warning: Deleting Transect",
                                    contentText:
                                        "You are about to delete this transect. "
                                        "Are you sure you want to continue?",
                                    rightBtnOnPressed: () {
                                  //close popup
                                  context.pop();
                                  context
                                      .pushNamed(DeletePage.routeName, extra: {
                                    DeletePage.keyObjectName:
                                        "Woody Debris Transect ${wdh.transNum}",
                                    DeletePage.keyDeleteFn: () {
                                      db.woodyDebrisTablesDao
                                          .deleteWoodyDebrisTransect(wdh.id)
                                          .then((value) {
                                        ref.refresh(wdTransListProvider(wdId));
                                        context.goNamed(
                                            WoodyDebrisSummaryPage.routeName,
                                            pathParameters: RouteParams
                                                .generateWdSummaryParams(
                                                    widget.goRouterState,
                                                    wdId.toString()));
                                      });
                                    },
                                  });
                                }),
                              );
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV, horizontal: kPaddingH),
                          ),
                        ],
                      ),
                    ),
                  ));
        });
  }
}
