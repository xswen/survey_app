import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
import '../../providers/woody_debris_providers.dart';
import '../../widgets/builders/set_transect_num_builder.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/text/text_header_separator.dart';
import 'woody_debris_header_page.dart';

class WoodyDebrisHeaderMeasurementsPage extends ConsumerStatefulWidget {
  static const String routeName = "woodyDebrisHeaderMeasurement";
  final GoRouterState goRouterState;

  const WoodyDebrisHeaderMeasurementsPage(this.goRouterState, {super.key});

  @override
  WoodyDebrisHeaderMeasurementsPageState createState() =>
      WoodyDebrisHeaderMeasurementsPageState();
}

class WoodyDebrisHeaderMeasurementsPageState
    extends ConsumerState<WoodyDebrisHeaderMeasurementsPage> {
  final String title = "Woody Debris Transect";
  late final PopupDismiss completeWarningPopup;
  late final PopupDismiss surveyCompleteWarningPopup;

  late final int wdId;
  late final int? wdhId;
  int? initTransNum;
  WoodyDebrisHeaderCompanion wdhC = const WoodyDebrisHeaderCompanion();
  bool firstOpen = true;
  bool changeMade = false;

  @override
  void initState() {
    wdId = PathParamValue.getWdSummaryId(widget.goRouterState);

    wdhId = PathParamValue.getWdHeaderId(widget.goRouterState);
    completeWarningPopup =
        Popups.generateCompleteErrorPopup("Woody Debris Transect");
    surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup("Woody Debris");

    super.initState();
  }

  void initWdhC() {
    if (firstOpen) {
      firstOpen = false;
      wdhId == null
          ? wdhC = WoodyDebrisHeaderCompanion(
              wdId: d.Value(wdId), complete: const d.Value(false))
          : Database.instance.woodyDebrisTablesDao
              .getWdHeader(wdhId!)
              .then((value) => setState(() {
                    initTransNum = value.transNum!;
                    wdhC = value.toCompanion(true);
                  }));
    }
  }

  //Error checks
  List<String> checkAll(WoodyDebrisHeaderCompanion wdh) {
    Database db = Database.instance;

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
            "The distance along the transect measured for small woody debris must "
            "not be greater than the length of the sample transect.");
      }
      if (wdh.mcwdMeasLen.value! > wdh.nomTransLen.value!) {
        result.add(
            "The distance along the transect measured for medium woody debris must "
            "not be greater than the length of the sample transect.");
      }
      if (wdh.lcwdMeasLen.value! > wdh.nomTransLen.value!) {
        result.add(
            "The distance along the transect measured for large woody debris must "
            "not be greater than the length of the sample transect.");
      }
    }
    return result;
  }

  //Nominal length of the sample transect (m). 10.0 to 150.0
  String? checkNomTransLen(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    } else if (10.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 10.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Transect azimuth (degrees) 0 to 360
  String? checkTransAzim(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    } else if (0 > int.parse(text) || int.parse(text) > 360) {
      return "Input out of range. Must be between 0 to 360 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for small woody debris. Recorded to nearest 0.1m. 0 to 150
  String? checkSwdMeasLen(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for round and odd shaped pieces of medium coarse woody debris
  String? checkMwdMeasLen(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for round and odd shaped pieces of large coarse woody debris
  String? checkLgMeasLen(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    void updateWdhC(WoodyDebrisHeaderCompanion newWdhC) =>
        setState(() => wdhC = newWdhC);

    initWdhC();

    return Scaffold(
        appBar: OurAppBar(
          "Woody Debris Measurement Data: Transect $initTransNum",
        ),
        endDrawer: DrawerMenu(onLocaleChange: () {}),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
          //wdId should always be initialized, if it isn't that means that it hasn't
          //been initialised with wdh data yet
          children: db.companionValueToStr(wdhC.wdId).isEmpty
              ? [kLoadingWidget]
              : [
                  SetTransectNumBuilder(
                    getUsedTransNums: db.woodyDebrisTablesDao
                        .getUsedTransNums(wdhC.wdId.value),
                    startingTransNum: initTransNum.toString(),
                    selectedItem: db.companionValueToStr(wdhC.transNum).isEmpty
                        ? "Please select transect number"
                        : db.companionValueToStr(wdhC.transNum),
                    transList: kTransectNumsList,
                    updateTransNum: (int transNum) {
                      changeMade = true;
                      updateWdhC(wdhC.copyWith(transNum: d.Value(transNum)));
                    },
                    onBeforePopup: (s) async {
                      if (wdhC.complete.value) {
                        Popups.show(context,
                            Popups.generateCompleteErrorPopup("Woody Debris"));
                        return false;
                      }
                      return true;
                    },
                  ),
                  DataInput(
                    readOnly: wdhC.complete.value,
                    title: "Length of the sample transect",
                    boxLabel: "Report to the nearest 0.1m",
                    prefixIcon: FontAwesomeIcons.ruler,
                    suffixVal: "m",
                    startingStr: db.companionValueToStr(wdhC.nomTransLen),
                    onValidate: checkNomTransLen,
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                    ],
                    onSubmit: (String s) {
                      changeMade = true;
                      if (s == "") {
                        wdhC =
                            wdhC.copyWith(nomTransLen: const d.Value.absent());
                      } else if (double.tryParse(s) != null) {
                        wdhC = wdhC.copyWith(
                            nomTransLen: d.Value(double.parse(s)));
                      }
                    },
                  ),
                  DataInput(
                      readOnly: wdhC.complete.value,
                      title: "Transect azimuth.",
                      boxLabel: "Report in degrees",
                      prefixIcon: FontAwesomeIcons.angleLeft,
                      suffixVal: "\u00B0",
                      inputType:
                          const TextInputType.numberWithOptions(decimal: false),
                      startingStr: db.companionValueToStr(wdhC.transAzimuth),
                      onValidate: checkTransAzim,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        ThousandsFormatter(allowFraction: false),
                      ],
                      onSubmit: (String s) {
                        changeMade = true;
                        if (s == "") {
                          wdhC = wdhC.copyWith(
                              transAzimuth: const d.Value.absent());
                        } else if (int.tryParse(s) != null) {
                          wdhC = wdhC.copyWith(
                              transAzimuth: d.Value(int.parse(s)));
                        }
                      }),
                  const SizedBox(height: kPaddingV * 2),
                  const TextHeaderSeparator(
                    title: "Total distance along the transect assessed for:",
                    fontSize: 20,
                  ),
                  DataInput(
                      readOnly: wdhC.complete.value,
                      title: "Small Woody Debris (1.1cm - 7.5cm)",
                      boxLabel: "Report to the nearest 0.1m",
                      prefixIcon: FontAwesomeIcons.ruler,
                      suffixVal: "m",
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      startingStr: db.companionValueToStr(wdhC.swdMeasLen),
                      onValidate: checkSwdMeasLen,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        ThousandsFormatter(
                            allowFraction: true, decimalPlaces: 1),
                      ],
                      onSubmit: (String s) {
                        changeMade = true;
                        if (s.isEmpty) {
                          wdhC =
                              wdhC.copyWith(swdMeasLen: const d.Value.absent());
                        } else if (double.tryParse(s) != null) {
                          wdhC = wdhC.copyWith(
                              swdMeasLen: d.Value(double.parse(s)));
                        }
                      }),
                  DataInput(
                      readOnly: wdhC.complete.value,
                      title: "Medium Woody Debris (7.6cm - 30cm)",
                      boxLabel: "Report to the nearest 0.1m",
                      prefixIcon: FontAwesomeIcons.ruler,
                      suffixVal: "m",
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      startingStr: db.companionValueToStr(wdhC.mcwdMeasLen),
                      onValidate: checkMwdMeasLen,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        ThousandsFormatter(
                            allowFraction: true, decimalPlaces: 1),
                      ],
                      onSubmit: (String s) {
                        changeMade = true;
                        if (s == "") {
                          wdhC = wdhC.copyWith(
                              mcwdMeasLen: const d.Value.absent());
                        } else if (double.tryParse(s) != null) {
                          wdhC = wdhC.copyWith(
                              mcwdMeasLen: d.Value(double.parse(s)));
                        }
                      }),
                  DataInput(
                      readOnly: wdhC.complete.value,
                      title: "Large Woody Debris (>30cm)",
                      boxLabel: "Report to the nearest 0.1m",
                      prefixIcon: FontAwesomeIcons.ruler,
                      suffixVal: "m",
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      startingStr: db.companionValueToStr(wdhC.lcwdMeasLen),
                      onValidate: checkLgMeasLen,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        ThousandsFormatter(
                            allowFraction: true, decimalPlaces: 1),
                      ],
                      onSubmit: (String s) {
                        changeMade = true;
                        if (s == "") {
                          wdhC = wdhC.copyWith(
                              lcwdMeasLen: const d.Value.absent());
                        } else if (double.tryParse(s) != null) {
                          wdhC = wdhC.copyWith(
                              lcwdMeasLen: d.Value(double.parse(s)));
                        }
                      }),
                  Container(
                      margin: const EdgeInsets.only(
                          top: kPaddingV * 2, bottom: kPaddingV * 2),
                      child: ElevatedButton(
                          onPressed: () {
                            if (wdhC.complete.value) {
                              Popups.show(
                                  context,
                                  Popups.generateCompleteErrorPopup(
                                      "Woody Debris"));
                              return;
                            }

                            List<String> errors = checkAll(wdhC);
                            if (errors.isNotEmpty) {
                              Popups.show(
                                  context,
                                  PopupDismiss(
                                    "Error: Incorrect Data",
                                    contentWidget: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Errors were found in the following places",
                                          textAlign: TextAlign.start,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            FormatString.generateBulletList(
                                                errors),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            } else {
                              db.woodyDebrisTablesDao
                                  .addOrUpdateWdHeader(wdhC)
                                  .then((wdhId) {
                                ref.refresh(wdTransListProvider(wdId));
                                ref.refresh(wdhProvider(wdhId));

                                context.goNamed(WoodyDebrisHeaderPage.routeName,
                                    pathParameters: PathParamGenerator.wdHeader(
                                        widget.goRouterState,
                                        wdhId.toString()));
                              });
                            }
                          },
                          child: const Text("Submit"))),
                ],
        ));
  }
}
