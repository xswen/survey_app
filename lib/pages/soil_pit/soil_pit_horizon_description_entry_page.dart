import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/soil_pit_code_select_builder.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';
import '../../widgets/hide_info_checkbox.dart';
import '../../widgets/text/text_header_separator.dart';

class SoilPitHorizonDescriptionEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitHorizonDescriptionEntry";
  final GoRouterState state;
  const SoilPitHorizonDescriptionEntryPage(this.state, {super.key});

  @override
  SoilPitHorizonDescriptionEntryPageState createState() =>
      SoilPitHorizonDescriptionEntryPageState();
}

class SoilPitHorizonDescriptionEntryPageState
    extends ConsumerState<SoilPitHorizonDescriptionEntryPage> {
  final String title = "Soil Pit Horizon";
  bool changeMade = false;

  late final int spId;
  late SoilPitHorizonDescriptionCompanion horizon;
  late SoilPitHorizonDescriptionCompanion originalHorizon;

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummary(widget.state);
    horizon = widget.state.extra as SoilPitHorizonDescriptionCompanion;
    originalHorizon = widget.state.extra as SoilPitHorizonDescriptionCompanion;

    super.initState();
  }

  Future<String> getPitCodeName(String code) async {
    if (code.isEmpty) {
      return "Please select soil pit code";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilPitCodeName(code);
  }

  Future<String> getHorizonName(String code) async {
    if (code.isEmpty) {
      return "Please select horizon";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilHorizonDesignationName(code);
  }

  Future<String> getSoilColorName(String code) async {
    if (code.isEmpty) {
      return "Please select color";
    }

    return ref.read(databaseProvider).referenceTablesDao.getSoilColorName(code);
  }

  Future<String> getSoilTextureName(String code) async {
    if (code.isEmpty) {
      return "Please select texture";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilTextureName(code);
  }

  List<String>? errorCheck() {}

  String? errorHorUpperDepth(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (-1.0 == double.parse(text!)) {
      return null;
    } else if (0 > double.parse(text!) || double.parse(text!) > 200) {
      return "Input out of range. Must be between 0.0 to 200.0 inclusive.";
    }
    return null;
  }

  String? errorHorThickness(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (-1.0 == double.parse(text!)) {
      return null;
    } else if (0 > double.parse(text!) || double.parse(text!) > 300) {
      return "Input out of range. Must be between 0.0 to 300.0 inclusive.";
    }
    return null;
  }

  String? errorCf(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (-1 == int.parse(text!) || -9 == int.parse(text!)) {
      return null;
    } else if (0 > int.parse(text!) || int.parse(text!) > 100) {
      return "Input out of range. Must be between 0 to 100 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    return Scaffold(
      appBar: OurAppBar(
        "$title: ${db.companionValueToStr(horizon.soilPitCodeField)}",
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
            SoilPitCodeSelectBuilder(
                code: db.companionValueToStr(horizon.soilPitCodeField),
                initPlotCodeName: "",
                plotCodeNames: db.referenceTablesDao.getSoilPitCodeNameList(),
                usedPlotCodes: Future.value([]),
                onChange: (s) {
                  db.referenceTablesDao.getSoilPitCodeCode(s!).then((code) {
                    if (code !=
                        db.companionValueToStr(horizon.soilPitCodeField)) {
                      setState(() {
                        horizon = horizon.copyWith(
                            soilPitCodeField: d.Value(code),
                            horizonNum: const d.Value.absent());
                      });
                    }
                  });
                }),
            const SizedBox(
              height: kPaddingV * 2,
            ),
            DataInput(
              title: "Horizon number",
              boxLabel: "Horizons must be numbered consecutively",
              prefixIcon: FontAwesomeIcons.list,
              suffixVal: "",
              startingStr: db.companionValueToStr(horizon.horizonUpper),
              generalPadding: const EdgeInsets.all(0),
              onValidate: (s) => null,
              inputType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (s) {
                changeMade = true;
                s.isEmpty
                    ? setState(() => horizon =
                        horizon.copyWith(thickness: const d.Value.absent()))
                    : setState(() => horizon =
                        horizon.copyWith(thickness: d.Value(double.parse(s))));
              },
            ),
            FutureBuilder(
                future: getHorizonName(db.companionValueToStr(horizon.horizon)),
                initialData: "Please select horizon",
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return DropDownAsyncList(
                    title: "Horizon",
                    searchable: true,
                    onChangedFn: (s) {
                      changeMade = true;
                      db.referenceTablesDao
                          .getSoilPitFeatureClassCode(s!)
                          .then((code) => setState(() {
                                horizon =
                                    horizon.copyWith(horizon: d.Value(code));
                              }));
                    },
                    asyncItems: (s) => db.referenceTablesDao
                        .getSoilHorizonDesignationNameList(),
                    selectedItem:
                        text.data ?? "Error loading drainage class name",
                  );
                }),
            HideInfoCheckbox(
              title: "Horizon upper depth",
              checkTitle: "Missing",
              checkValue:
                  db.companionValueToStr(horizon.horizonUpper) == "-1.0",
              onChange: (b) {
                changeMade = true;
                b!
                    ? setState(() => horizon =
                        horizon.copyWith(horizonUpper: const d.Value(-1)))
                    : setState(() => horizon =
                        horizon.copyWith(horizonUpper: const d.Value.absent()));
              },
              child: DataInput(
                boxLabel: "Measure to the nearest 0.1",
                prefixIcon: FontAwesomeIcons.ruler,
                suffixVal: "cm",
                startingStr: db.companionValueToStr(horizon.horizonUpper),
                generalPadding: const EdgeInsets.all(0),
                onValidate: (s) => errorHorUpperDepth(s),
                inputType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                  ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                ],
                onSubmit: (s) {
                  changeMade = true;
                  s.isEmpty
                      ? setState(() => horizon = horizon.copyWith(
                          horizonUpper: const d.Value.absent()))
                      : setState(() => horizon = horizon.copyWith(
                          horizonUpper: d.Value(double.parse(s))));
                },
              ),
            ),
            HideInfoCheckbox(
              title: "Horizon thickness",
              checkTitle: "Missing",
              checkValue:
                  db.companionValueToStr(horizon.horizonUpper) == "-1.0",
              onChange: (b) {
                changeMade = true;
                b!
                    ? setState(() => horizon =
                        horizon.copyWith(thickness: const d.Value(-1)))
                    : setState(() => horizon =
                        horizon.copyWith(thickness: const d.Value.absent()));
              },
              child: DataInput(
                boxLabel: "Measure to the nearest 0.1",
                prefixIcon: FontAwesomeIcons.ruler,
                suffixVal: "cm",
                startingStr: db.companionValueToStr(horizon.horizonUpper),
                generalPadding: const EdgeInsets.all(0),
                onValidate: (s) => errorHorThickness(s),
                inputType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                  ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                ],
                onSubmit: (s) {
                  changeMade = true;
                  s.isEmpty
                      ? setState(() => horizon =
                          horizon.copyWith(thickness: const d.Value.absent()))
                      : setState(() => horizon = horizon.copyWith(
                          thickness: d.Value(double.parse(s))));
                },
              ),
            ),
            HideInfoCheckbox(
                title: "Soil colour",
                checkTitle: "Missing",
                checkValue: db.companionValueToStr(horizon.color) == "S",
                onChange: (b) {
                  changeMade = true;
                  b!
                      ? setState(() =>
                          horizon = horizon.copyWith(color: const d.Value("S")))
                      : setState(() => horizon =
                          horizon.copyWith(color: const d.Value.absent()));
                },
                child: FutureBuilder(
                    future:
                        getSoilColorName(db.companionValueToStr(horizon.color)),
                    initialData: "Please select color",
                    builder:
                        (BuildContext context, AsyncSnapshot<String> text) {
                      return DropDownAsyncList(
                        searchable: true,
                        padding: 0,
                        onChangedFn: (s) {
                          changeMade = true;
                          db.referenceTablesDao
                              .getSoilColorCode(s!)
                              .then((code) => setState(() {
                                    horizon =
                                        horizon.copyWith(color: d.Value(code));
                                  }));
                        },
                        asyncItems: (s) =>
                            db.referenceTablesDao.getSoilColorNameList(),
                        selectedItem: text.data ?? "Error loading color name",
                      );
                    })),
            HideInfoCheckbox(
                title: "Soil texture",
                checkTitle: "Missing",
                checkValue: db.companionValueToStr(horizon.texture) == "S",
                onChange: (b) {
                  changeMade = true;
                  b!
                      ? setState(() => horizon =
                          horizon.copyWith(texture: const d.Value("S")))
                      : setState(() => horizon =
                          horizon.copyWith(texture: const d.Value.absent()));
                },
                child: FutureBuilder(
                    future:
                        getSoilColorName(db.companionValueToStr(horizon.color)),
                    initialData: "Please select texture",
                    builder:
                        (BuildContext context, AsyncSnapshot<String> text) {
                      return DropDownAsyncList(
                        searchable: true,
                        padding: 0,
                        onChangedFn: (s) {
                          changeMade = true;
                          db.referenceTablesDao
                              .getSoilTextureCode(s!)
                              .then((code) => setState(() {
                                    horizon = horizon.copyWith(
                                        texture: d.Value(code));
                                  }));
                        },
                        asyncItems: (s) =>
                            db.referenceTablesDao.getSoilTextureNameList(),
                        selectedItem: text.data ?? "Error loading texture name",
                      );
                    })),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: TextHeaderSeparator(
                title: "Coarse Fragement Content",
                fontSize: 20,
              ),
            ),
            DataInput(
              title: "Volumetric percent gravel",
              boxLabel:
                  "The percent coarse fragment content by volume of the mineral "
                  "horizon. (Diameter < 7.5 cm or length < 15 cm.)",
              prefixIcon: FontAwesomeIcons.percent,
              suffixVal: "%",
              startingStr: db.companionValueToStr(horizon.horizonUpper),
              generalPadding: const EdgeInsets.all(0),
              onValidate: (s) => errorCf(s),
              inputType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (s) {
                changeMade = true;
                s.isEmpty
                    ? setState(() => horizon =
                        horizon.copyWith(cfGrav: const d.Value.absent()))
                    : setState(() => horizon =
                        horizon.copyWith(cfGrav: d.Value(int.parse(s))));
              },
            ),
            DataInput(
              title: "Volumetric percent cobbles",
              boxLabel:
                  "The percent coarse fragment (diameter = 7.5 to 25 cm or "
                  "length = 15 to 38 cm) content by volume of the mineral horizon.",
              prefixIcon: FontAwesomeIcons.percent,
              suffixVal: "%",
              startingStr: db.companionValueToStr(horizon.horizonUpper),
              generalPadding: const EdgeInsets.all(0),
              onValidate: (s) => errorCf(s),
              inputType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (s) {
                changeMade = true;
                s.isEmpty
                    ? setState(() => horizon =
                        horizon.copyWith(cfCobb: const d.Value.absent()))
                    : setState(() => horizon =
                        horizon.copyWith(cfCobb: d.Value(int.parse(s))));
              },
            ),
            DataInput(
              title: "Volumetric percent stone",
              boxLabel:
                  "The percent coarse fragment (diameter > 25 cm or length > 38 "
                  "cm) content by volume of the mineral horizon.",
              prefixIcon: FontAwesomeIcons.percent,
              suffixVal: "%",
              startingStr: db.companionValueToStr(horizon.horizonUpper),
              generalPadding: const EdgeInsets.all(0),
              onValidate: (s) => errorCf(s),
              inputType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (s) {
                changeMade = true;
                s.isEmpty
                    ? setState(() => horizon =
                        horizon.copyWith(cfStone: const d.Value.absent()))
                    : setState(() => horizon =
                        horizon.copyWith(cfStone: d.Value(int.parse(s))));
              },
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: kPaddingV * 2, bottom: kPaddingV * 2),
                child: ElevatedButton(
                    onPressed: () {
                      List<String>? errors = errorCheck();
                      if (errors != null) {
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
                        // db.soilPitTablesDao
                        //     .addOrUpdateFeature(feature)
                        //     .then((featureId) {
                        //   ref.refresh(soilFeatureListProvider(spId));
                        //   context.goNamed(SoilPitFeaturePage.routeName,
                        //       pathParameters: PathParamGenerator.soilPitSummary(
                        //           widget.state, spId.toString()));
                        // });
                      }
                    },
                    child: const Text("Submit"))),
          ]),
        ),
      ),
    );
  }
}
