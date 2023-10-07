import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_header_page.dart';
import 'package:survey_app/widgets/popups/popup_dismiss.dart';

import '../../constants/constant_values.dart';
import '../../constants/margins_padding.dart';
import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/builders/set_transect_num_builder.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/text/text_header_separator.dart';

class WoodyDebrisHeaderMeasurementsPage extends StatefulWidget {
  static const String routeName = "woodyDebrisHeaderMeasurement";
  static const String keyWdHeader = "wdHeader";
  static const String keyUpdateSummaryPageTransList =
      "updateSummaryPageTransList";

  const WoodyDebrisHeaderMeasurementsPage(
      {Key? key, required this.wdh, required this.updateSummaryPageTransList})
      : super(key: key);
  final WoodyDebrisHeaderCompanion wdh;
  final VoidCallback? updateSummaryPageTransList;

  @override
  State<WoodyDebrisHeaderMeasurementsPage> createState() =>
      _WoodyDebrisHeaderMeasurementsPageState();
}

class _WoodyDebrisHeaderMeasurementsPageState
    extends State<WoodyDebrisHeaderMeasurementsPage> {
  late WoodyDebrisHeaderCompanion wdh;

  final String title = "Woody Debris Transect";
  bool changeMade = false;

  @override
  void initState() {
    wdh = widget.wdh;
    super.initState();
  }

  void updateWdhCompanion(WoodyDebrisHeaderCompanion newWdh) =>
      setState(() => wdh = newWdh);

  //Error checks
  List<String> checkAll(Database db) {
    List<String> result = [];

    checkNomTransLen(db.companionValueToStr(wdh.nomTransLen)) != null
        ? result.add("Length of Sample Transect")
        : null;
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

    if (result.isEmpty) {
      if (wdh.swdMeasLen.value! > wdh.nomTransLen.value!) {
        result.add(
            "Small Measurement Length must be less or equal than the length of sample transect");
      }
      if (wdh.mcwdMeasLen.value! > wdh.nomTransLen.value!) {
        result.add(
            "Medium Measurement Length must be less or equal than the length of sample transect");
      }
      if (wdh.lcwdMeasLen.value! > wdh.nomTransLen.value!) {
        result.add(
            "Large Measurement Length must be less or equal than the length of sample transect");
      }
    }
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
      return "Input out of range. Must be between 0.0 to 150 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for round and odd shaped pieces of medium coarse woody debris
  String? checkMwdMeasLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for round and odd shaped pieces of large coarse woody debris
  String? checkLgMeasLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);

    Future<void> goToHeaderPage() => db.woodyDebrisTablesDao
        .addOrUpdateWdHeader(wdh)
        .then((id) async => widget.updateSummaryPageTransList == null
            ? context.pop()
            : context
                .pushReplacementNamed(WoodyDebrisHeaderPage.routeName, extra: {
                WoodyDebrisHeaderPage.keyWdHeader:
                    await db.woodyDebrisTablesDao.getWdHeaderFromId(id),
                WoodyDebrisHeaderPage.keySummaryComplete: wdh.complete.value,
                WoodyDebrisHeaderPage.keyUpdateSummaryPageTransList:
                    widget.updateSummaryPageTransList
              }));

    return Scaffold(
      appBar: OurAppBar(
          "Woody Debris Measurement Data: Transect ${wdh.transNum.value ?? ""}",
          backFn: () => changeMade
              ? Popups.show(context, Popups.generateWarningUnsavedChanges(() {
                  context.pop();
                  context.pop();
                }))
              : context.pop(context.pop)),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        children: [
          SetTransectNumBuilder(
            getUsedTransNums:
                db.woodyDebrisTablesDao.getUsedTransnums(wdh.wdId.value),
            startingTransNum: db.companionValueToStr(widget.wdh.transNum),
            selectedItem: db.companionValueToStr(wdh.transNum).isEmpty
                ? "Please select transect number"
                : db.companionValueToStr(wdh.transNum),
            transList: kTransectNumsList,
            updateTransNum: (int transNum) =>
                updateWdhCompanion(wdh.copyWith(transNum: d.Value(transNum))),
          ),
          DataInput(
            title: "Length of the sample transect",
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
              changeMade = true;
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
                changeMade = true;
                if (s == "") {
                  updateWdhCompanion(
                      wdh.copyWith(transAzimuth: const d.Value.absent()));
                } else if (int.tryParse(s) != null) {
                  updateWdhCompanion(
                      wdh.copyWith(transAzimuth: d.Value(int.parse(s))));
                }
              }),
          const SizedBox(height: kPaddingV * 2),
          const TextHeaderSeparator(
            title: "Total distance along the transect assessed for:",
            fontSize: 20,
          ),
          DataInput(
              title: "Small Woody Debris (1.1cm - 7.5cm)",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: db.companionValueToStr(wdh.swdMeasLen),
              errorMsg: checkSwdMeasLen(db.companionValueToStr(wdh.swdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                changeMade = true;
                if (s == "") {
                  updateWdhCompanion(
                      wdh.copyWith(swdMeasLen: const d.Value.absent()));
                } else if (double.tryParse(s) != null) {
                  updateWdhCompanion(
                      wdh.copyWith(swdMeasLen: d.Value(double.parse(s))));
                }
              }),
          DataInput(
              title: "Medium Woody Debris (7.6cm - 30cm)",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: db.companionValueToStr(wdh.mcwdMeasLen),
              errorMsg:
                  checkMwdMeasLen(db.companionValueToStr(wdh.mcwdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                changeMade = true;
                if (s == "") {
                  updateWdhCompanion(
                      wdh.copyWith(mcwdMeasLen: const d.Value.absent()));
                } else if (double.tryParse(s) != null) {
                  updateWdhCompanion(
                      wdh.copyWith(mcwdMeasLen: d.Value(double.parse(s))));
                }
              }),
          DataInput(
              title: "Large Woody Debris (>30cm)",
              boxLabel: "Report to the nearest 0.1m",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "m",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: db.companionValueToStr(wdh.lcwdMeasLen),
              errorMsg: checkLgMeasLen(db.companionValueToStr(wdh.lcwdMeasLen)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (String s) {
                changeMade = true;
                if (s == "") {
                  updateWdhCompanion(
                      wdh.copyWith(lcwdMeasLen: const d.Value.absent()));
                } else if (double.tryParse(s) != null) {
                  updateWdhCompanion(
                      wdh.copyWith(lcwdMeasLen: d.Value(double.parse(s))));
                }
              }),
          Container(
              margin: const EdgeInsets.only(
                  top: kPaddingV * 2, bottom: kPaddingV * 2),
              child: ElevatedButton(
                  onPressed: () {
                    if (wdh.complete.value) {
                      Popups.show(context,
                          Popups.generateCompleteErrorPopup("Woody Debris"));
                      return;
                    }

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
                    } else {
                      goToHeaderPage();
                    }
                  },
                  child: const Text("Submit"))),
        ],
      ),
    );
  }
}
