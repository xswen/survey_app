import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../database/database.dart';
import '../../global.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/edit_icon_button.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/popups/popup_content_format.dart';
import '../../widgets/popups/popup_dismiss_dep.dart';
import '../../widgets/text/text_in_line.dart';
import '../../widgets/titled_border.dart';
import 'piece_measurements/woody_debris_error_check.dart';

class WoodyDebrisHeaderPage extends StatefulWidget {
  const WoodyDebrisHeaderPage({super.key});

  @override
  State<WoodyDebrisHeaderPage> createState() => _WoodyDebrisHeaderPageState();
}

class _WoodyDebrisHeaderPageState extends State<WoodyDebrisHeaderPage>
    with Global {
  final _db = Get.find<Database>();

  WoodyDebrisHeaderData wdh = Get.arguments["wdh"];
  bool summaryComplete = Get.arguments["summaryComplete"];

  final PopupDismissDep _completeWarningPopup =
      Global.generateCompleteErrorPopup("Transect");
  final PopupDismissDep _prevPageCompleteWarning =
      Global.generatePreviousMarkedCompleteErrorPopup("Surface Substrate");

  void _deleteTransect(BuildContext context) {
    //TODO: Fix
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => DeleteCheckPage(
    //           object: "Transect ${wdh.transNum}",
    //           content:
    //               "You are currently trying to delete Transect ${wdh.transNum}. \n"
    //               "This action cannot be undone. Do you wish to continue?",
    //           contOnPress: () {
    //             String transNum = wdh.transNum.toString();
    //             _db.woodyDebris.transects
    //                 .removeWhere((key, value) => key == transNum);
    //             //Push removed until
    //           })),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar("Woody Debris: Transect ${wdh.transNum}"),
      floatingActionButton: FloatingCompleteButton(
        title: "Woody Debris Transect",
        complete: wdh.complete,
        onPressed: () async {
          if (summaryComplete) {
            Get.dialog(_prevPageCompleteWarning);
          } else {
            WoodyDebrisSmallData? smd =
                await _db.woodyDebrisTablesDao.getWdSmall(wdh.id);

            PopupContentFormat? errorMsg = _errorCheck(smd);
            if (wdh.complete || errorMsg == null) {
              _updateWdhData(
                  WoodyDebrisHeaderCompanion(complete: d.Value(!wdh.complete)));
              _db.woodyDebrisTablesDao
                  .getWdHeaderFromId(wdh.id)
                  .then((value) => wdh = value);
              setState(() {});
            } else {
              Get.dialog(PopupDismissDep(
                  title: "Error has been found in the following places",
                  contentWidget: errorMsg));
            }
          }
        },
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TitledBorder(
              title: "Measurement Data",
              actions: EditIconButton(onPressed: () async {
                if (summaryComplete) {
                  Get.dialog(_prevPageCompleteWarning);
                } else if (wdh.complete) {
                  Get.dialog(_completeWarningPopup);
                } else {
                  final result = await Get.toNamed(
                      Routes.woodyDebrisTransectMeasurement,
                      arguments: wdh);
                  if (Global.nullableToStr(result).isNotEmpty) {
                    setState(() => wdh = result);
                  }
                }
              }),
              child: Column(
                children: [
                  TextInLine(
                      label: const Text("Nominal Transect Length"),
                      data: wdh.nomTransLen == null
                          ? Row(children: const [
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
                          ? Row(children: const [
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
                          ? Row(children: const [
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
                          ? Row(children: const [
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
                          ? Row(children: const [
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
                          ? Row(children: const [
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
                WoodyDebrisSmallData? wdSm = await _getOrCreateWdSmall();

                wdSm == null
                    ? printError(info: "Small Wd returned null")
                    : Get.toNamed(Routes.woodyDebrisPieceMain, arguments: {
                        "wdSmall": (wdSm),
                        "transNum": wdh.transNum,
                        "transectComplete": wdh.complete,
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
                _deleteTransect(context);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.trash),
              space: kPaddingIcon,
              label: "Delete Transect",
              onPressed: () {
                _deleteTransect(context);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
          ],
        ),
      ),
    );
  }

  Future<WoodyDebrisSmallData?> _getOrCreateWdSmall() async {
    WoodyDebrisSmallData? wdSm = await (_db.select(_db.woodyDebrisSmall)
          ..where((tbl) => tbl.wdHeaderId.equals(wdh.id)))
        .getSingleOrNull();

    wdSm ??
        _db.woodyDebrisTablesDao
            .addWdSmall(WoodyDebrisSmallCompanion(wdHeaderId: d.Value(wdh.id)));

    return _db.woodyDebrisTablesDao.getWdSmall(wdh.id);
  }

  Future<void> _updateWdhData(WoodyDebrisHeaderCompanion entry) async {
    (_db.update(_db.woodyDebrisHeader)..where((t) => t.id.equals(wdh.id)))
        .write(entry);
  }

  //Return null on no issue. Otherwise return error message
  PopupContentFormat? _errorCheck(WoodyDebrisSmallData? smd) {
    List<String> titles = [];
    List<String> details = [];

    String headerData = WdErrorCheck.allHeaderData(wdh) ?? "";
    String smWdData = WdErrorCheck.smallWdData(smd) ?? "";

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
}
