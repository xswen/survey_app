import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/widgets/popups/popup_errors_found_list.dart';
import 'package:survey_app/widgets/popups/popup_warning_missing_fields_list.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../database/database.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/builders/set_transect_num_builder.dart';
import '../../widgets/buttons/edit_icon_button.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/popups/popup_continue.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/text/text_in_line.dart';
import '../../widgets/titled_border.dart';
import '../delete_page.dart';
import 'wood_debris_header_measurements_page.dart';
import 'woody_debris_piece/woody_debris_header_piece_main.dart';

class WoodyDebrisHeaderPage extends StatefulWidget {
  static const String routeName = "woodyDebrisHeader";
  static const String keyWdHeader = "wdHeader";
  static const String keySummaryComplete = "summaryComplete";

  const WoodyDebrisHeaderPage(
      {Key? key, required this.wdh, required this.summaryComplete})
      : super(key: key);

  final WoodyDebrisHeaderData wdh;
  final bool summaryComplete;

  @override
  State<WoodyDebrisHeaderPage> createState() => _WoodyDebrisHeaderPageState();
}

class _WoodyDebrisHeaderPageState extends State<WoodyDebrisHeaderPage> {
  String get title => "Woody Debris Transect";

  late WoodyDebrisHeaderData wdh;
  late bool summaryComplete;

  @override
  void initState() {
    wdh = widget.wdh;
    summaryComplete = widget.summaryComplete;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup("Woody Debris");

    void updateWdhData(WoodyDebrisHeaderCompanion entry) {
      (db.update(db.woodyDebrisHeader)..where((t) => t.id.equals(wdh.id)))
          .write(entry);
      db.woodyDebrisTablesDao
          .getWdHeaderFromId(wdh.id)
          .then((value) => setState(() => wdh = value));
    }

    Future<WoodyDebrisSmallData?> getOrCreateWdSmall() async {
      WoodyDebrisSmallData? wdSm = await (db.select(db.woodyDebrisSmall)
            ..where((tbl) => tbl.wdHeaderId.equals(wdh.id)))
          .getSingleOrNull();

      wdSm ??
          db.woodyDebrisTablesDao.addWdSmall(
              WoodyDebrisSmallCompanion(wdHeaderId: d.Value(wdh.id)));

      return db.woodyDebrisTablesDao.getWdSmall(wdh.id);
    }

    //Return null on no issue. Otherwise return error message
    List<String>? errorCheck(WoodyDebrisSmallData? wdSm) {
      List<String> results = [];

      if (wdh.transAzimuth == null ||
          wdh.lcwdMeasLen == null ||
          wdh.mcwdMeasLen == null ||
          wdh.nomTransLen == null ||
          wdh.swdDecayClass == null ||
          wdh.swdMeasLen == null) {
        results.add("Measurement Data");
      }
      if (wdSm == null || wdSm.swdDecayClass == null) {
        results.add("Piece Measurements");
      }

      return results.isEmpty ? null : results;
    }

    return Scaffold(
      appBar: OurAppBar("Woody Debris: Transect ${wdh.transNum}"),
      floatingActionButton: FloatingCompleteButton(
        title: title,
        complete: wdh.complete,
        onPressed: () {
          if (summaryComplete) {
            Popups.show(context, surveyCompleteWarningPopup);
          } else if (wdh.complete) {
            updateWdhData(
                const WoodyDebrisHeaderCompanion(complete: d.Value(false)));
          } else {
            (db.woodyDebrisTablesDao.getWdSmall(wdh.id)).then((wdSm) {
              List<String>? errors = errorCheck(wdSm);

              if (errors == null) {
                List<String> missingData = [];
                wdh.swdDecayClass == -1
                    ? missingData.add("Measurement Data")
                    : null;
                wdSm!.swdDecayClass == -1
                    ? missingData.add("Piece Measurements")
                    : null;
                missingData.isEmpty
                    ? updateWdhData(const WoodyDebrisHeaderCompanion(
                        complete: d.Value(true)))
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
        },
      ),
      body: Center(
        child: Column(
          children: [
            TitledBorder(
              title: "Measurement Data",
              actions: EditIconButton(onPressed: () async {
                if (summaryComplete) {
                  Popups.show(context, surveyCompleteWarningPopup);
                } else if (wdh.complete) {
                  Popups.show(context, completeWarningPopup);
                } else {
                  context
                      .pushNamed(WoodyDebrisHeaderMeasurements.routeName,
                          extra: wdh)
                      .then((value) => db.woodyDebrisTablesDao
                          .getWdHeaderFromId(wdh.id)
                          .then((value) => setState(() => wdh = value)));
                }
              }),
              child: Column(
                children: [
                  TextInLine(
                      label: const Text("Nominal Transect Length"),
                      data: wdh.nomTransLen == null
                          ? const Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  FontAwesomeIcons.circleExclamation,
                                  size: kTextSize,
                                  color: kError,
                                ),
                              ),
                              Text("Empty mandatory field"),
                            ])
                          : Text("${wdh.nomTransLen}m")),
                  TextInLine(
                      label: const Text("Transect azimuth"),
                      data: wdh.transAzimuth == null
                          ? const Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  FontAwesomeIcons.circleExclamation,
                                  size: kTextSize,
                                  color: kError,
                                ),
                              ),
                              Text("Empty mandatory field"),
                            ])
                          : Text("${wdh.transAzimuth}\u00b0")),
                  TextInLine(
                      label: const Text("Small woody debris"),
                      data: wdh.swdMeasLen == null
                          ? const Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  FontAwesomeIcons.circleExclamation,
                                  size: kTextSize,
                                  color: kError,
                                ),
                              ),
                              Text("Empty mandatory field"),
                            ])
                          : Text("${wdh.swdMeasLen}m")),
                  TextInLine(
                      label: const Text("Medium woody debris"),
                      data: wdh.mcwdMeasLen == null
                          ? const Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  FontAwesomeIcons.circleExclamation,
                                  size: kTextSize,
                                  color: kError,
                                ),
                              ),
                              Text("Empty mandatory field"),
                            ])
                          : Text("${wdh.mcwdMeasLen}m")),
                  TextInLine(
                      label: const Text("Large woody debris"),
                      data: wdh.lcwdMeasLen == null
                          ? const Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  FontAwesomeIcons.circleExclamation,
                                  size: kTextSize,
                                  color: kError,
                                ),
                              ),
                              Text("Empty mandatory field"),
                            ])
                          : Text("${wdh.lcwdMeasLen}m")),
                  TextInLine(
                      label: const Text("Average decay class"),
                      data: wdh.swdDecayClass == null
                          ? const Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  FontAwesomeIcons.circleExclamation,
                                  size: kTextSize,
                                  color: kError,
                                ),
                              ),
                              Text("Empty mandatory field"),
                            ])
                          : Text(wdh.swdDecayClass.toString() == "-1"
                              ? "Missing"
                              : wdh.swdDecayClass.toString())),
                ],
              ),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.ruler),
              space: kPaddingIcon,
              label: "Piece Measurements",
              onPressed: () async {
                getOrCreateWdSmall().then((wdSmall) {
                  wdSmall == null
                      ? debugPrint("Error, wdSmall returned null")
                      : context.pushNamed(WoodyDebrisHeaderPieceMain.routeName,
                          extra: {
                              WoodyDebrisHeaderPieceMain.keyWdSmall: wdSmall,
                              WoodyDebrisHeaderPieceMain.keyTransNum:
                                  wdh.transNum,
                              WoodyDebrisHeaderPieceMain.keyTransComplete:
                                  wdh.complete,
                            }).then((value) => null);
                });
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.penToSquare),
              space: kPaddingIcon,
              label: "Edit Transect",
              onPressed: () {
                int? transNum = wdh.transNum;
                db.woodyDebrisTablesDao.getUsedTransnums(wdh.wdId).then(
                      (usedTransNums) => Popups.show(
                        context,
                        Popups.show(
                            context,
                            SetTransectNumBuilder(
                              selectedItem: "PLease select a transect number",
                              disabledFn: (s) =>
                                  usedTransNums.contains(int.tryParse(s) ?? -1),
                              onChanged: (s) =>
                                  transNum = int.tryParse(s ?? "-1"),
                              onSubmit: () {
                                if (transNum == null || transNum! < 1) {
                                  debugPrint(
                                      "Error: selected item didn't parse correctly");
                                  Popups.show(
                                      context,
                                      const PopupDismiss(
                                        "Error: in parsing",
                                        contentText:
                                            "There was a system error. "
                                            "Request cannot be completed",
                                      ));
                                  context.pop();
                                } else {
                                  updateWdhData(WoodyDebrisHeaderCompanion(
                                      id: d.Value(wdh.id),
                                      transNum: d.Value(transNum)));
                                  context.pop();
                                }
                              },
                            )),
                      ),
                    );
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.trash),
              space: kPaddingIcon,
              label: "Delete Transect",
              onPressed: () {
                Popups.show(
                  context,
                  PopupContinue("Warning: Deleting Piece",
                      contentText: "You are about to delete this piece. "
                          "Are you sure you want to continue?",
                      rightBtnOnPressed: () {
                    //close popup
                    context.pop();
                    context.pushNamed(DeletePage.routeName, extra: {
                      DeletePage.keyObjectName:
                          "Woody Debris Transect ${wdh.transNum}",
                      DeletePage.keyDeleteFn: () {
                        db.woodyDebrisTablesDao
                            .deleteWoodyDebrisTransect(wdh.id)
                            .then((value) => context.pop());
                      },
                      DeletePage.keyAfterDeleteFn: () {
                        //Leave delete page
                        context.pop();
                      }
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
    );
  }
}
