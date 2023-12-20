import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../providers/woody_debris_providers.dart';
import '../../widgets/box_increment.dart';
import '../../widgets/builders/decay_class_select_builder.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../../widgets/popups/popup_warning_missing_fields_list.dart';
import '../../widgets/text/text_header_separator.dart';
import 'woody_debris_header_measurements_page.dart';
import 'woody_debris_piece/woody_debris_piece_accu_odd_page.dart';
import 'woody_debris_piece/woody_debris_piece_round_page.dart';

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
  late final int wdSmId;

  @override
  void initState() {
    wdId = PathParamValue.getWdSummaryId(widget.goRouterState);

    wdhId = PathParamValue.getWdHeaderId(widget.goRouterState)!;
    wdSmId = 1;
    super.initState();
  }

  void updateWdhData(WoodyDebrisHeaderCompanion entry) {
    final db = ref.read(databaseProvider);

    void update() {
      (db.update(db.woodyDebrisHeader)..where((t) => t.id.equals(wdhId)))
          .write(entry);

      ref.refresh(wdhProvider(wdhId));
    }

    //If marking incomplete to edit immediately go to edit
    !entry.complete.value
        ? update()
        : db.woodyDebrisTablesDao.wdPieceExists(wdhId).then((exists) => exists
            ? update()
            : Popups.show(
                context,
                PopupContinue(
                  "Warning: No pieces entered",
                  contentText:
                      "No pieces of coarse woody debris have been recorded for "
                      "this transect. Pressing continue means you are confirming"
                      "that the survey was completed and there were "
                      "no pieces to record.\n"
                      "Are you sure you want to continue?",
                  rightBtnOnPressed: () {
                    update();
                    context.pop();
                  },
                )));
  }

  void updateDecayClass(int? newDecayClass) {
    Database db = Database.instance;
    (db.update(db.woodyDebrisHeader)..where((t) => t.id.equals(wdhId))).write(
        WoodyDebrisHeaderCompanion(swdDecayClass: d.Value(newDecayClass)));
    ref.refresh(wdhProvider(wdhId));
  }

  void updateWdSm(WoodyDebrisSmallCompanion entry) {
    final db = ref.read(databaseProvider);
    (db.update(db.woodyDebrisSmall)..where((t) => t.id.equals(wdSmId)))
        .write(entry);
    ref.refresh(wdSmallProvider(wdhId));
  }

  void createOddOrAccuPiece(String type) {
    final db = ref.read(databaseProvider);
    db.woodyDebrisTablesDao.getLastWdPieceNum(wdhId).then((lastPieceNum) {
      int pieceNum = lastPieceNum + 1;
      WoodyDebrisOddCompanion wdOdd = WoodyDebrisOddCompanion(
          wdHeaderId: d.Value(wdhId),
          pieceNum: d.Value(pieceNum),
          accumOdd: d.Value(type));
      //TODO: Move this to provider
      context.pushNamed(WoodyDebrisPieceAccuOddPage.routeName,
          pathParameters: PathParamGenerator.wdSmall(
              widget.goRouterState, wdSmId.toString()),
          extra: {WoodyDebrisPieceAccuOddPage.keyPiece: wdOdd}).then((value) {
        ref.refresh(wdPieceOddProvider(wdhId));
        ref.refresh(wdPieceRoundProvider(wdhId));
      });
    });
  }

  void addPiece() {
    final db = ref.read(databaseProvider);

    Popups.show(
        context,
        SimpleDialog(
          title: const Text("Create New: "),
          children: [
            SimpleDialogOption(
              onPressed: () {
                context.pop();
                createOddOrAccuPiece(db.woodyDebrisTablesDao.odd);
              },
              child: const Text("Odd Piece"),
            ),
            SimpleDialogOption(
              onPressed: () {
                context.pop();
                createOddOrAccuPiece(db.woodyDebrisTablesDao.accumulation);
              },
              child: const Text("Accumulation"),
            ),
            SimpleDialogOption(
              onPressed: () async {
                db.woodyDebrisTablesDao
                    .getLastWdPieceNum(wdhId)
                    .then((lastPieceNum) {
                  int pieceNum = lastPieceNum + 1;
                  WoodyDebrisRoundCompanion wdRound = WoodyDebrisRoundCompanion(
                      wdHeaderId: d.Value(wdhId), pieceNum: d.Value(pieceNum));
                  context.pop();
                  //TODO: Move to provider
                  context.pushNamed(WoodyDebrisPieceRoundPage.routeName,
                      pathParameters: PathParamGenerator.wdSmall(
                          widget.goRouterState, wdSmId.toString()),
                      extra: {
                        WoodyDebrisPieceRoundPage.keyPiece: wdRound
                      }).then((value) {
                    ref.refresh(wdPieceOddProvider(wdhId));
                    ref.refresh(wdPieceRoundProvider(wdhId));
                  });
                });
              },
              child: const Text("Round Piece"),
            ),
            SimpleDialogOption(
              onPressed: () => context.pop(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Cancel")],
              ),
            ),
          ],
        ));
  }

  void changeWdPieceData(bool transComplete,
      {WoodyDebrisOddData? odd,
      WoodyDebrisRoundData? round,
      void Function()? deleteFn}) {
    if (transComplete) {
      Popups.show(context, completeWarningPopup);
    } else if (odd != null) {
      context.pushNamed(WoodyDebrisPieceAccuOddPage.routeName,
          pathParameters: PathParamGenerator.wdSmall(
              widget.goRouterState, wdSmId.toString()),
          extra: {
            WoodyDebrisPieceAccuOddPage.keyPiece: odd.toCompanion(true),
            WoodyDebrisPieceAccuOddPage.keyDeleteFn: deleteFn
          }).then((value) {
        ref.refresh(wdPieceOddProvider(wdhId));
        ref.refresh(wdPieceRoundProvider(wdhId));
      });
    } else if (round != null) {
      context.pushNamed(WoodyDebrisPieceRoundPage.routeName,
          pathParameters: PathParamGenerator.wdSmall(
              widget.goRouterState, wdSmId.toString()),
          extra: {
            WoodyDebrisPieceRoundPage.keyPiece: round.toCompanion(true),
            WoodyDebrisPieceRoundPage.keyDeleteFn: deleteFn
          }).then((value) {
        ref.refresh(wdPieceOddProvider(wdhId));
        ref.refresh(wdPieceRoundProvider(wdhId));
      });
    } else {
      debugPrint("Error: No data given");
    }
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
              ? missingData.add("Small Woody Debris Decay Class")
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
    final db = ref.read(databaseProvider);

    final parentComplete = ref.watch(wdhParentCompleteProvider(wdId));
    final AsyncValue<WoodyDebrisHeaderData> wdh = ref.watch(wdhProvider(wdhId));
    final wdSmall = ref.watch(wdSmallProvider(wdhId));
    final pieceOdd = ref.watch(wdPieceOddProvider(wdhId));
    final pieceRound = ref.watch(wdPieceRoundProvider(wdhId));

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
                      child: ListView(
                        children: [
                          IconNavButton(
                            icon: const Icon(FontAwesomeIcons.file),
                            space: kPaddingIcon,
                            label: "Transect Header Data",
                            onPressed: () async {
                              context
                                  .pushNamed(
                                    WoodyDebrisHeaderMeasurementsPage.routeName,
                                    pathParameters: PathParamGenerator.wdHeader(
                                      widget.goRouterState,
                                      wdhId.toString(),
                                      wdSmId.toString(),
                                    ),
                                  )
                                  .then((value) =>
                                      ref.refresh(wdhProvider(wdhId)));
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV, horizontal: kPaddingH),
                          ),
                          //---------Small Woody Debris
                          const TextHeaderSeparator(
                              title: "Small Woody Debris"),
                          const SizedBox(
                            height: kPaddingV,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPaddingH),
                            child: DecayClassSelectBuilder(
                              onBeforePopup: (s) async {
                                if (wdh.complete) {
                                  Popups.show(
                                      context,
                                      Popups.generateCompleteErrorPopup(
                                          "Woody Debris"));
                                  return false;
                                }
                                return true;
                              },
                              onChangedFn: (s) => s == "Unreported"
                                  ? updateDecayClass(-1)
                                  : updateDecayClass(int.parse(s!)),
                              selectedItem: wdh.swdDecayClass == null
                                  ? "Select Decay Class"
                                  : wdh.swdDecayClass.toString() == "-1"
                                      ? "Unreported"
                                      : wdh.swdDecayClass.toString(),
                            ),
                          ),
                          const SizedBox(
                            height: kPaddingV * 2,
                          ),
                          wdSmall.when(
                              data: (wdSm) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      BoxIncrement(
                                        title: "Class 1",
                                        subtitle: "1.1 - 3.0cm",
                                        boxVal: wdSm!.swdTallyS.toString(),
                                        minusOnPress: () {
                                          wdh.complete
                                              ? Popups.show(
                                                  context, completeWarningPopup)
                                              : (wdSm.swdTallyS > 0
                                                  ? updateWdSm(
                                                      WoodyDebrisSmallCompanion(
                                                          swdTallyS: d.Value(
                                                              wdSm.swdTallyS -
                                                                  1)))
                                                  : null);
                                        },
                                        addOnPress: () => wdh.complete
                                            ? Popups.show(
                                                context, completeWarningPopup)
                                            : updateWdSm(
                                                WoodyDebrisSmallCompanion(
                                                    swdTallyS: d.Value(
                                                        wdSm.swdTallyS + 1))),
                                      ),
                                      BoxIncrement(
                                        title: "Class 2",
                                        subtitle: "3.1 - 5.0cm",
                                        boxVal: wdSm.swdTallyM.toString(),
                                        minusOnPress: () {
                                          wdh.complete
                                              ? Popups.show(
                                                  context, completeWarningPopup)
                                              : wdSm.swdTallyM > 0
                                                  ? updateWdSm(
                                                      WoodyDebrisSmallCompanion(
                                                          swdTallyM: d.Value(
                                                              wdSm.swdTallyM -
                                                                  1)))
                                                  : null;
                                        },
                                        addOnPress: () => wdh.complete
                                            ? Popups.show(
                                                context, completeWarningPopup)
                                            : updateWdSm(
                                                WoodyDebrisSmallCompanion(
                                                    swdTallyM: d.Value(
                                                        wdSm.swdTallyM + 1))),
                                      ),
                                      BoxIncrement(
                                        title: "Class 3",
                                        subtitle: "5.1 - 7.5cm",
                                        boxVal: wdSm.swdTallyL.toString(),
                                        minusOnPress: () {
                                          wdh.complete
                                              ? Popups.show(
                                                  context, completeWarningPopup)
                                              : (wdSm.swdTallyL > 0
                                                  ? updateWdSm(
                                                      WoodyDebrisSmallCompanion(
                                                          swdTallyL: d.Value(
                                                              wdSm.swdTallyL -
                                                                  1)))
                                                  : null);
                                        },
                                        addOnPress: () => wdh.complete
                                            ? Popups.show(
                                                context, completeWarningPopup)
                                            : updateWdSm(
                                                WoodyDebrisSmallCompanion(
                                                    swdTallyL: d.Value(
                                                        wdSm.swdTallyL + 1))),
                                      ),
                                    ],
                                  ),
                              error: (err, stack) => Text("Error: $err"),
                              loading: () => const Center(
                                  child: CircularProgressIndicator())),
                          //---------Coarse Woody Debris
                          // IconNavButton(
                          //   icon: const Icon(FontAwesomeIcons.trash),
                          //   space: kPaddingIcon,
                          //   label: "Delete Transect",
                          //   onPressed: () {
                          //     if (parentComplete || wdh.complete) {
                          //       Popups.show(context, completeWarningPopup);
                          //       return;
                          //     }
                          //     Popups.show(
                          //       context,
                          //       PopupContinue("Warning: Deleting Transect",
                          //           contentText:
                          //               "You are about to delete this transect "
                          //               "and all data entered for this "
                          //               "transect. Are you sure you want to "
                          //               "continue?", rightBtnOnPressed: () {
                          //         //close popup
                          //         context.pop();
                          //         context
                          //             .pushNamed(DeletePage.routeName, extra: {
                          //           DeletePage.keyObjectName:
                          //               "Woody Debris Transect ${wdh.transNum}",
                          //           DeletePage.keyDeleteFn: () {
                          //             db.woodyDebrisTablesDao
                          //                 .deleteWoodyDebrisTransect(wdh.id)
                          //                 .then((value) {
                          //               ref.refresh(wdTransListProvider(wdId));
                          //               context.goNamed(
                          //                   WoodyDebrisSummaryPage.routeName,
                          //                   pathParameters:
                          //                       PathParamGenerator.wdSummary(
                          //                           widget.goRouterState,
                          //                           wdId.toString()));
                          //             });
                          //           },
                          //         });
                          //       }),
                          //     );
                          //   },
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: kPaddingV, horizontal: kPaddingH),
                          // ),
                        ],
                      ),
                    ),
                  ));
        });
  }
}
