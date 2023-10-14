import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/providers/woody_debris_providers.dart';

import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
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

  late int wdhId;
  bool changeMade = false;

  @override
  void initState() {
    wdhId = RouteParams.getWdHeaderId(widget.goRouterState);
    completeWarningPopup =
        Popups.generateCompleteErrorPopup("Woody Debris Transect");
    surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup("Woody Debris");

    super.initState();
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
    final db = ref.read(databaseProvider);
    final wdhData = ref.watch(wdhProvider(wdhId));
    return wdhData.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (wdhData) {
          print(wdhData);
          final WoodyDebrisHeaderCompanion wdh =
              ref.watch(wdhCompanionHandlerProvider(wdhData.toCompanion(true)));
          return Scaffold(
            appBar: OurAppBar(
              "Woody Debris Measurement Data: Transect ${wdh.transNum.value}",
            ),
            endDrawer: DrawerMenu(onLocaleChange: () => null),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
              children: [
                SetTransectNumBuilder(
                  getUsedTransNums:
                      db.woodyDebrisTablesDao.getUsedTransnums(wdhData.wdId),
                  startingTransNum: wdhData.transNum.toString(),
                  selectedItem: db.companionValueToStr(wdh.transNum).isEmpty
                      ? "Please select transect number"
                      : db.companionValueToStr(wdh.transNum),
                  transList: kTransectNumsList,
                  updateTransNum: (int transNum) => ref
                      .read(wdhCompanionHandlerProvider(
                              wdh.copyWith(transNum: d.Value(transNum)))
                          .notifier)
                      .updateWdh(wdh.copyWith(transNum: d.Value(transNum))),
                ),
                DataInput(
                  title: "Length of the sample transect",
                  boxLabel: "Report to the nearest 0.1m",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "m",
                  startingStr: db.companionValueToStr(wdh.nomTransLen),
                  errorMsg:
                      checkNomTransLen(db.companionValueToStr(wdh.nomTransLen)),
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                  ],
                  onSubmit: (String s) {
                    changeMade = true;
                    if (s == "") {
                      // updateWdhCompanion(
                      //     wdh.copyWith(nomTransLen: const d.Value.absent()));
                    } else if (double.tryParse(s) != null) {
                      // updateWdhCompanion(
                      //     wdh.copyWith(nomTransLen: d.Value(double.parse(s))));
                    }
                  },
                ),
                DataInput(
                    title: "Transect azimuth.",
                    boxLabel: "Report in degrees",
                    prefixIcon: FontAwesomeIcons.angleLeft,
                    suffixVal: "\u00B0",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: false),
                    startingStr: db.companionValueToStr(wdh.transAzimuth),
                    errorMsg: checkTransAzim(
                        db.companionValueToStr(wdh.transAzimuth)),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      ThousandsFormatter(allowFraction: false),
                    ],
                    onSubmit: (String s) {
                      changeMade = true;
                      if (s == "") {
                        // updateWdhCompanion(
                        //     wdh.copyWith(transAzimuth: const d.Value.absent()));
                      } else if (int.tryParse(s) != null) {
                        // updateWdhCompanion(
                        //     wdh.copyWith(transAzimuth: d.Value(int.parse(s))));
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
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    startingStr: db.companionValueToStr(wdh.swdMeasLen),
                    errorMsg:
                        checkSwdMeasLen(db.companionValueToStr(wdh.swdMeasLen)),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                    ],
                    onSubmit: (String s) {
                      changeMade = true;
                      if (s == "") {
                        // updateWdhCompanion(
                        //     wdh.copyWith(swdMeasLen: const d.Value.absent()));
                      } else if (double.tryParse(s) != null) {
                        // updateWdhCompanion(
                        //     wdh.copyWith(swdMeasLen: d.Value(double.parse(s))));
                      }
                    }),
                DataInput(
                    title: "Medium Woody Debris (7.6cm - 30cm)",
                    boxLabel: "Report to the nearest 0.1m",
                    prefixIcon: FontAwesomeIcons.ruler,
                    suffixVal: "m",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    startingStr: db.companionValueToStr(wdh.mcwdMeasLen),
                    errorMsg: checkMwdMeasLen(
                        db.companionValueToStr(wdh.mcwdMeasLen)),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                    ],
                    onSubmit: (String s) {
                      changeMade = true;
                      if (s == "") {
                        // updateWdhCompanion(
                        //     wdh.copyWith(mcwdMeasLen: const d.Value.absent()));
                      } else if (double.tryParse(s) != null) {
                        // updateWdhCompanion(wdh.copyWith(
                        //     mcwdMeasLen: d.Value(double.parse(s))));
                      }
                    }),
                DataInput(
                    title: "Large Woody Debris (>30cm)",
                    boxLabel: "Report to the nearest 0.1m",
                    prefixIcon: FontAwesomeIcons.ruler,
                    suffixVal: "m",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    startingStr: db.companionValueToStr(wdh.lcwdMeasLen),
                    errorMsg:
                        checkLgMeasLen(db.companionValueToStr(wdh.lcwdMeasLen)),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                    ],
                    onSubmit: (String s) {
                      changeMade = true;
                      if (s == "") {
                        // updateWdhCompanion(
                        //     wdh.copyWith(lcwdMeasLen: const d.Value.absent()));
                      } else if (double.tryParse(s) != null) {
                        // updateWdhCompanion(wdh.copyWith(
                        //     lcwdMeasLen: d.Value(double.parse(s))));
                      }
                    }),
                Container(
                    margin: const EdgeInsets.only(
                        top: kPaddingV * 2, bottom: kPaddingV * 2),
                    child: ElevatedButton(
                        onPressed: () {
                          if (wdh.complete.value) {
                            Popups.show(
                                context,
                                Popups.generateCompleteErrorPopup(
                                    "Woody Debris"));
                            return;
                          }

                          List<String> errors = checkAll(wdh);
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
                            ref.refresh(wdhProvider(wdhId));

                            context.goNamed(WoodyDebrisHeaderPage.routeName,
                                pathParameters:
                                    RouteParams.generateWdHeaderParms(
                                        widget.goRouterState,
                                        wdhId.toString()));
                          }
                        },
                        child: const Text("Submit"))),
              ],
            ),
          );
        });
  }
}
