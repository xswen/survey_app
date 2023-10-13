import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../../widgets/popups/popup_warning_missing_fields_list.dart';

part 'woody_debris_header_page.g.dart';

@riverpod
Future<bool> parentComplete(ParentCompleteRef ref, int wdId) async =>
    (await ref.read(databaseProvider).woodyDebrisTablesDao.getWdSummary(wdId))
        .complete;

@riverpod
Future<WoodyDebrisHeaderData> wdh(WdhRef ref, int wdhId) async =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdHeader(wdhId);

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
    wdId = RouteParams.getWdSummaryId(widget.goRouterState);
    wdhId = RouteParams.getWdHeaderId(widget.goRouterState);
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
        wdh.swdDecayClass == null ||
        wdh.swdMeasLen == null) {
      results.add("Transect Header Data");
    }
    if (wdSm == null) {
      results.add("Piece Measurements");
    }

    return results.isEmpty ? null : results;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = ref.read(databaseProvider);

    final parentComplete = ref.watch(parentCompleteProvider(wdId));
    final wdh = ref.watch(wdhProvider(wdhId));

    return wdh.when(
      error: (err, stack) => Text("Error: $err"),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (wdh) => parentComplete.when(
          error: (err, stack) => Text("Error: $err"),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (parentComplete) => Scaffold(
                appBar: OurAppBar("Woody Debris: Transect ${wdh.transNum}"),
                endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
                floatingActionButton: FloatingCompleteButton(
                  title: "Woody Debris Transect ${wdh.transNum}",
                  complete: wdh.complete,
                  onPressed: () {
                    if (parentComplete) {
                      Popups.show(context, surveyCompleteWarningPopup);
                    } else if (wdh.complete) {
                      updateWdhData(const WoodyDebrisHeaderCompanion(
                          complete: d.Value(false)));
                    } else {
                      (db.woodyDebrisTablesDao.getWdSmall(wdh.id)).then((wdSm) {
                        List<String>? errors = errorCheck(wdh, wdSm);

                        if (errors == null) {
                          List<String> missingData = [];
                          wdh.swdDecayClass == -1
                              ? missingData.add("Transect Header Data")
                              : null;
                          missingData.isEmpty
                              ? updateWdhData(const WoodyDebrisHeaderCompanion(
                                  complete: d.Value(true)))
                              : Popups.show(
                                  context,
                                  PopupWarningMissingFieldsList(
                                      missingFields: missingData,
                                      rightBtnOnPressed: () {
                                        updateWdhData(
                                            const WoodyDebrisHeaderCompanion(
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
                  },
                ),
                body: Center(
                  child: Column(
                    children: [
                      IconNavButton(
                        icon: const Icon(FontAwesomeIcons.file),
                        space: kPaddingIcon,
                        label: "Transect Header Data",
                        onPressed: () async {
                          // context.pushNamed(
                          //     WoodyDebrisHeaderMeasurementsPage.routeName,
                          //     extra: {
                          //       WoodyDebrisHeaderMeasurementsPage.keyWdHeader:
                          //           wdh.toCompanion(true)
                          //     }).then((value) => db.woodyDebrisTablesDao
                          //     .getWdHeaderFromId(wdh.id)
                          //     .then((value) => setState(() => wdh = value)));
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
                            // context.pushNamed(
                            //         WoodyDebrisHeaderPieceMain.routeName,
                            //         extra: {
                            //             WoodyDebrisHeaderPieceMain.keyWdSmall:
                            //                 wdSmallId,
                            //             WoodyDebrisHeaderPieceMain.keyTransNum:
                            //                 wdh.transNum,
                            //             WoodyDebrisHeaderPieceMain
                            //                 .keyDecayClass: wdh.swdDecayClass,
                            //             WoodyDebrisHeaderPieceMain
                            //                 .keyTransComplete: wdh.complete,
                            //           }).then((value) => null);
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
                              // context.pushNamed(DeletePage.routeName, extra: {
                              //   DeletePage.keyObjectName:
                              //       "Woody Debris Transect ${wdh.transNum}",
                              //   DeletePage.keyDeleteFn: () {
                              //     db.woodyDebrisTablesDao
                              //         .deleteWoodyDebrisTransect(wdh.id)
                              //         .then((value) {
                              //       widget.updateSummaryPageTransList();
                              //       context.pop();
                              //     });
                              //   },
                              // });
                            }),
                          );
                        },
                        padding: const EdgeInsets.symmetric(
                            vertical: kPaddingV, horizontal: kPaddingH),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
