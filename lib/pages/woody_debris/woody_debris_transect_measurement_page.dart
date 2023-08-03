import 'dart:developer';

import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/builders/decay_class_select_builder.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_content_format.dart';
import '../../widgets/popups/popup_continue.dart';
import '../../widgets/popups/popup_dismiss.dart';
import 'piece_measurements/woody_debris_error_check.dart';

class WoodyDebrisTransectMeasurementPage extends StatefulWidget {
  const WoodyDebrisTransectMeasurementPage({super.key});

  @override
  State<WoodyDebrisTransectMeasurementPage> createState() =>
      _TransectMeasurementPageState();
}

class _TransectMeasurementPageState
    extends State<WoodyDebrisTransectMeasurementPage> with Global {
  final _db = Get.find<Database>();
  WoodyDebrisHeaderData wdh = Get.arguments;

  Future<void> _continueCheck() async {
    String? result = WdErrorCheck.allHeaderData(wdh);

    if (result != null) {
      Get.dialog(PopupDismiss(
        title: "Error were found in the following places",
        contentWidget: PopupContentFormat(
          titles: const [""],
          details: [result],
        ),
      ));
    } else {
      bool cont = true;
      if (wdh.swdDecayClass == -1) {
        cont = await Get.dialog(PopupContinue(
            title: "Warning: Missing Field",
            content:
                "Decay Class has been marked as missing. Are you sure you want to continue?",
            cancelResult: false,
            rightBtnOnPressed: () => Get.back(result: true)));
      }
      if (cont) {
        (_db.update(_db.woodyDebrisHeader)..where((t) => t.id.equals(wdh.id)))
            .write(wdh);
        WoodyDebrisHeaderData newWdd =
            await _db.woodyDebrisTablesDao.getWdHeaderFromId(wdh.id);
        Get.back(result: newWdd);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          OurAppBar("Woody Debris Measurement Data: Transect ${wdh.transNum}"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        children: [
          DataInput(
              title: "The nominal length of the sample transect.",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: Global.nullableToStr(wdh.nomTransLen),
              errorMsg: WdErrorCheck.nomTransLen(
                  Global.nullableToStr(wdh.nomTransLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                double.tryParse(s) != null
                    ? setState(() {
                        wdh =
                            wdh.copyWith(nomTransLen: d.Value(double.parse(s)));

                        log("NomTransLen ${wdh.nomTransLen}");
                      })
                    : null;
              }), //nomTransLen
          DataInput(
              title: "Transect azimuth.",
              boxLabel: "Report in degrees",
              prefixIcon: FontAwesomeIcons.angleLeft,
              suffixVal: "\u00B0",
              inputType: const TextInputType.numberWithOptions(decimal: false),
              startingStr: Global.nullableToStr(wdh.transAzimuth),
              errorMsg: WdErrorCheck.transAzim(
                  Global.nullableToStr(wdh.transAzimuth)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                ThousandsFormatter(allowFraction: false),
              ],
              onSubmit: (String s) {
                setState(() {
                  wdh = wdh.copyWith(transAzimuth: d.Value(int.parse(s)));

                  log("transAzim ${wdh.transAzimuth}");
                });
              }), //transAzim
          DataInput(
              title:
                  "Total distance along the transect assessed for round and odd"
                  "shaped pieces of small woody debris",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: Global.nullableToStr(wdh.swdMeasLen),
              errorMsg:
                  WdErrorCheck.swdMeasLen(Global.nullableToStr(wdh.swdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                double.tryParse(s) != null
                    ? setState(() {
                        wdh =
                            wdh.copyWith(swdMeasLen: d.Value(double.parse(s)));
                        log("swdMeasLen ${wdh.swdMeasLen}");
                      })
                    : null;
              }),

          DataInput(
              title:
                  "Total distance along the transect assessed for round and odd"
                  "shaped pieces of MCWD.",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: Global.nullableToStr(wdh.mcwdMeasLen),
              errorMsg: WdErrorCheck.swdMeasLen(
                  Global.nullableToStr(wdh.mcwdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                double.tryParse(s) != null
                    ? setState(() {
                        wdh =
                            wdh.copyWith(mcwdMeasLen: d.Value(double.parse(s)));
                        log("swdMeasLen ${wdh.mcwdMeasLen}");
                      })
                    : null;
              }),
          DataInput(
              title:
                  "Total distance along the transect assessed for round and odd"
                  "shaped pieces of LCWD.",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: Global.nullableToStr(wdh.lcwdMeasLen),
              errorMsg: WdErrorCheck.swdMeasLen(
                  Global.nullableToStr(wdh.lcwdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                double.tryParse(s) != null
                    ? setState(() {
                        wdh =
                            wdh.copyWith(lcwdMeasLen: d.Value(double.parse(s)));
                        log("swdMeasLen ${wdh.lcwdMeasLen}");
                      })
                    : null;
              }),

          DecayClassSelectBuilder(
              title:
                  "Average decay class is assigned to all pieces of small woody debris along each transect.",
              checkValue: wdh.swdDecayClass == -1,
              checkOnChange: (decayClassMissing) {
                if (decayClassMissing != null && decayClassMissing) {
                  Get.dialog(PopupContinue(
                    title: "Warning Missing Field",
                    content: "Are you sure you want to set as missing?",
                    rightBtnOnPressed: () {
                      setState(() =>
                          wdh = wdh.copyWith(swdDecayClass: const d.Value(-1)));
                      Get.back();
                    },
                  ));
                } else {
                  setState(() =>
                      wdh = wdh.copyWith(swdDecayClass: const d.Value(null)));
                }
              },
              onChangedFn: (String? s) {
                setState(() {
                  wdh = wdh.copyWith(swdDecayClass: d.Value(int.parse(s!)));
                  log("swdMeasLen ${wdh.swdDecayClass}");
                });
              },
              selectedItem: Global.nullableToStr(wdh.swdDecayClass)),
          Container(
              margin: const EdgeInsets.only(
                  top: kPaddingV * 2, bottom: kPaddingV * 2),
              child: ElevatedButton(
                  onPressed: _continueCheck, child: const Text("Submit"))),
        ],
      ),
    );
  }
}
