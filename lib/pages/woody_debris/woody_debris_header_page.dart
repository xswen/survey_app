import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../database/database.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/edit_icon_button.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/popups/popup_content_format.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/text/text_in_line.dart';
import '../../widgets/titled_border.dart';

class WoodyDebrisHeaderPage extends StatefulWidget {
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
        Popups.generateCompleteErrorPopup(context, title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup(
            context, "Woody Debris");

    Future<void> updateWdhData(WoodyDebrisHeaderCompanion entry) async {
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
    PopupContentFormat? errorCheck(WoodyDebrisSmallData? smd) {
      List<String> titles = [];
      List<String> details = [];

      // String headerData = WdErrorCheck.allHeaderData(wdh) ?? "";
      // String smWdData = WdErrorCheck.smallWdData(smd) ?? "";

      String headerData = "";
      String smWdData = "";

      if (headerData.isNotEmpty) {
        titles.add("Header Data");
        details.add(headerData);
      }
      if (smWdData.isNotEmpty) {
        titles.add("Piece Measurements");
        details.add(smWdData);
      }

      return headerData.isEmpty && smWdData.isEmpty
          ? null
          : PopupContentFormat(titles: titles, details: details);
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
            //TODO: Error check
            bool errorCheck = false;
            if (errorCheck) {
              db.woodyDebrisTablesDao.getWdSmall(wdh.id).then((value) {});
            } else {
              updateWdhData(
                  const WoodyDebrisHeaderCompanion(complete: d.Value(true)));
            }
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
                  // final result = await Get.toNamed(
                  //     Routes.woodyDebrisTransectMeasurement,
                  //     arguments: wdh);
                  // if (Global.nullableToStr(result).isNotEmpty) {
                  //   setState(() => wdh = result);
                  // }
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
                //TODO: Add woodyDebrisSmall
                //  WoodyDebrisSmallData? wdSm = await _getOrCreateWdSmall();
                //
                //  wdSm == null
                //      ? printError(info: "Small Wd returned null")
                //      : Get.toNamed(Routes.woodyDebrisPieceMain, arguments: {
                //    "wdSmall": (wdSm),
                //    "transNum": wdh.transNum,
                //    "transectComplete": wdh.complete,
                //  });
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.penToSquare),
              space: kPaddingIcon,
              label: "Edit Transect",
              onPressed: () {
                //TODO: Add Deletion
                //_deleteTransect(context);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.trash),
              space: kPaddingIcon,
              label: "Delete Transect",
              onPressed: () {
                //TODO: Add Deletion
                //_deleteTransect(context);
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
