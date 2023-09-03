import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/widgets/builders/decay_class_select_builder.dart';
import 'package:survey_app/widgets/hide_info_checkbox.dart';
import 'package:survey_app/widgets/popups/popup_continue.dart';
import 'package:survey_app/widgets/popups/popup_dismiss.dart';

import '../../constants/margins_padding.dart';
import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popups.dart';

class WoodyDebrisHeaderMeasurements extends StatefulWidget {
  static const String keyWdHeader = "wdHeader";

  const WoodyDebrisHeaderMeasurements({Key? key, required this.wdh})
      : super(key: key);
  final WoodyDebrisHeaderData wdh;

  @override
  State<WoodyDebrisHeaderMeasurements> createState() =>
      _WoodyDebrisHeaderMeasurementsState();
}

class _WoodyDebrisHeaderMeasurementsState
    extends State<WoodyDebrisHeaderMeasurements> {
  late WoodyDebrisHeaderCompanion wdh;

  String get title => "Woody Debris Transect";

  @override
  void initState() {
    wdh = widget.wdh.toCompanion(true);
    super.initState();
  }

  void updateWdhCompanion(WoodyDebrisHeaderCompanion newWdh) =>
      setState(() => wdh = newWdh);

  //Error checks
  List<String> checkAll(Database db) {
    List<String> result = [];

    checkTransAzim(db.companionValueToStr(wdh.transAzimuth)) != null
        ? result.add("Transect Azimuth")
        : null;
    checkSwdMeasLen(db.companionValueToStr(wdh.swdMeasLen)) != null
        ? result.add("Small Measurement Length")
        : null;
    checkMwdMeasLen(db.companionValueToStr(wdh.mcwdMeasLen)) != null
        ? result.add("Medium Measurement Length")
        : null;
    checkLgMeasLen(db.companionValueToStr(wdh.lcwdMeasLen)) != null
        ? result.add("Large Measurement Length")
        : null;
    wdh.swdDecayClass == const d.Value.absent()
        ? result.add("Average Decay Class of Transect")
        : null;

    return result;
  }

  //Nominal length of the sample transect (m). 10.0 to 150.0
  String? checkNomTransLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (10.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 10.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Transect azimuth (degrees) 0 to 360
  String? checkTransAzim(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0 > int.parse(text) || int.parse(text) > 360) {
      return "Input out of range. Must be between 0 to 360 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for small woody debris. Recorded to nearest 0.1m. 0 to 150
  String? checkSwdMeasLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for round and odd shaped pieces of medium coarse woody debris
  String? checkMwdMeasLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for round and odd shaped pieces of large coarse woody debris
  String? checkLgMeasLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150.0 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);

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
            startingStr: db.companionValueToStr(wdh.nomTransLen),
            errorMsg: checkNomTransLen(db.companionValueToStr(wdh.nomTransLen)),
            inputType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              LengthLimitingTextInputFormatter(5),
              ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
            ],
            onSubmit: (String s) {
              if (s == "") {
                updateWdhCompanion(
                    wdh.copyWith(nomTransLen: const d.Value.absent()));
              } else if (double.tryParse(s) != null) {
                updateWdhCompanion(
                    wdh.copyWith(nomTransLen: d.Value(double.parse(s))));
              }
            },
          ),
          DataInput(
              title: "Transect azimuth.",
              boxLabel: "Report in degrees",
              prefixIcon: FontAwesomeIcons.angleLeft,
              suffixVal: "\u00B0",
              inputType: const TextInputType.numberWithOptions(decimal: false),
              startingStr: db.companionValueToStr(wdh.transAzimuth),
              errorMsg:
                  checkTransAzim(db.companionValueToStr(wdh.transAzimuth)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                ThousandsFormatter(allowFraction: false),
              ],
              onSubmit: (String s) {
                if (s == "") {
                  updateWdhCompanion(
                      wdh.copyWith(transAzimuth: const d.Value.absent()));
                } else if (int.tryParse(s) != null) {
                  updateWdhCompanion(
                      wdh.copyWith(transAzimuth: d.Value(int.parse(s))));
                }
              }),
          DataInput(
              title:
                  "Total distance along the transect assessed for round and odd"
                  "shaped pieces of small woody debris",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: db.companionValueToStr(wdh.swdMeasLen),
              errorMsg: checkSwdMeasLen(db.companionValueToStr(wdh.swdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                if (s == "") {
                  updateWdhCompanion(
                      wdh.copyWith(swdMeasLen: const d.Value.absent()));
                } else if (double.tryParse(s) != null) {
                  updateWdhCompanion(
                      wdh.copyWith(swdMeasLen: d.Value(double.parse(s))));
                }
              }),
          DataInput(
              title:
                  "Total distance along the transect assessed for round and odd"
                  "shaped pieces of MCWD",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: db.companionValueToStr(wdh.mcwdMeasLen),
              errorMsg:
                  checkMwdMeasLen(db.companionValueToStr(wdh.mcwdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                if (s == "") {
                  updateWdhCompanion(
                      wdh.copyWith(mcwdMeasLen: const d.Value.absent()));
                } else if (double.tryParse(s) != null) {
                  updateWdhCompanion(
                      wdh.copyWith(mcwdMeasLen: d.Value(double.parse(s))));
                }
              }),
          DataInput(
              title:
                  "Total distance along the transect assessed for round and odd"
                  "shaped pieces of LCWD",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: db.companionValueToStr(wdh.lcwdMeasLen),
              errorMsg: checkLgMeasLen(db.companionValueToStr(wdh.lcwdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                if (s == "") {
                  updateWdhCompanion(
                      wdh.copyWith(lcwdMeasLen: const d.Value.absent()));
                } else if (double.tryParse(s) != null) {
                  updateWdhCompanion(
                      wdh.copyWith(lcwdMeasLen: d.Value(double.parse(s))));
                }
              }),
          HideInfoCheckbox(
            title: "Average decay class is assigned to all pieces of "
                "small woody debris along each transect.",
            checkTitle: "Mark decay class as missing",
            checkValue: wdh.swdDecayClass == const d.Value(-1),
            onChange: (b) {
              b!
                  ? updateWdhCompanion(
                      wdh.copyWith(swdDecayClass: const d.Value(-1)))
                  : updateWdhCompanion(
                      wdh.copyWith(swdDecayClass: const d.Value.absent()));
            },
            child: DecayClassSelectBuilder(
              onChangedFn: (s) => updateWdhCompanion(
                  wdh.copyWith(swdDecayClass: d.Value(int.parse(s!)))),
              selectedItem: db.companionValueToStr(wdh.swdDecayClass),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                  top: kPaddingV * 2, bottom: kPaddingV * 2),
              child: ElevatedButton(
                  onPressed: () {
                    List<String> errors = checkAll(db);
                    if (errors.isNotEmpty) {
                      Popups.show(
                          context,
                          PopupDismiss(
                            "Error: Incorrect Data",
                            contentWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Errors were found in the following places",
                                  textAlign: TextAlign.start,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    FormatString.generateBulletList(errors),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    } else if (wdh.swdDecayClass == const d.Value(-1)) {
                      Popups.show(
                          context,
                          PopupContinue(
                            "Warning: Missing Field",
                            contentText:
                                "Decay Class has been marked as missing. "
                                "Are you sure you want to continue?",
                            rightBtnOnPressed: () {
                              (db.update(db.woodyDebrisHeader)
                                    ..where((t) => t.id.equals(wdh.id.value)))
                                  .write(wdh);
                              context.pop();
                              context.pop();
                            },
                          ));
                    } else {
                      (db.update(db.woodyDebrisHeader)
                            ..where((t) => t.id.equals(wdh.id.value)))
                          .write(wdh);
                      context.pop();
                    }
                  },
                  child: const Text("Submit"))),
        ],
      ),
    );
  }
}
