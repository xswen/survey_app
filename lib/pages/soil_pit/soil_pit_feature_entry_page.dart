import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_feature_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:survey_app/widgets/hide_info_checkbox.dart';

import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/soil_pit_code_select_builder.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';

class SoilPitFeatureEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitFeatureEntry";
  final GoRouterState state;
  const SoilPitFeatureEntryPage(this.state, {super.key});

  @override
  SoilPitFeatureEntryPageState createState() => SoilPitFeatureEntryPageState();
}

class SoilPitFeatureEntryPageState
    extends ConsumerState<SoilPitFeatureEntryPage> {
  final String title = "Soil Pit Depth";
  bool changeMade = false;

  late final int spId;
  late SoilPitFeatureCompanion feature;
  late String initSoilPit = "NA";

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummary(widget.state);
    feature = widget.state.extra as SoilPitFeatureCompanion;
    initSoilPit = ref.read(databaseProvider).companionValueToStr(
        (widget.state.extra as SoilPitFeatureCompanion).soilPitSoilFeature);

    super.initState();
  }

  Future<String> getPitCodeName(String code) async {
    if (code.isEmpty) {
      return "Please select soil pit code";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilPitCodeFieldName(code);
  }

  Future<String> getFeatureName(String code) async {
    if (code.isEmpty) {
      return "Please select feature";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilPitFeatureClassName(code);
  }

  List<String>? errorCheck() {
    List<String> results = [];

    if (feature.soilPitCodeField == const d.Value.absent()) {
      results.add("Missing Soil Pit Code");
    }

    if (feature.soilPitSoilFeature == const d.Value.absent()) {
      results.add("Missing Soil Feature");
    }

    if (errorDepthFeature(ref
            .read(databaseProvider)
            .companionValueToStr(feature.depthFeature)) !=
        null) {
      results.add("Error for depth feature");
    }

    return results.isEmpty ? null : results;
  }

  String? errorDepthFeature(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (-9 == int.parse(text!)) {
      return null;
    } else if (0 > int.parse(text!) || int.parse(text!) > 200) {
      return "Input out of range. Must be between 0 to 200 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    d.Value.absent();
    return Scaffold(
      appBar: OurAppBar(
        "$title: Soil Pit Depth ${db.companionValueToStr(feature.soilPitCodeField)}",
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: Column(children: [
            SoilPitCodeSelectBuilder(
                code: db.companionValueToStr(feature.soilPitCodeField),
                initPlotCodeName: initSoilPit,
                plotCodeNames:
                    db.referenceTablesDao.getSoilPitCodeFieldNameList(),
                usedPlotCodes:
                    db.soilPitTablesDao.getFeatureUsedPlotCodeNameList(spId),
                onChange: (s) {
                  changeMade = true;
                  db.referenceTablesDao
                      .getSoilPitCodeCompiledCode(s!)
                      .then((code) => setState(() {
                            feature = feature.copyWith(
                                soilPitCodeField: d.Value(code));
                          }));
                }),
            HideInfoCheckbox(
                title: "Soil feature noted from soil pit",
                checkTitle: "Unreported",
                checkValue:
                    db.companionValueToStr(feature.soilPitSoilFeature) == "S",
                onChange: (b) {
                  changeMade = true;
                  b!
                      ? setState(() => feature = feature.copyWith(
                          soilPitSoilFeature: const d.Value("S"),
                          depthFeature: const d.Value(-9)))
                      : setState(() => feature = feature.copyWith(
                          soilPitSoilFeature: const d.Value.absent(),
                          depthFeature: const d.Value.absent()));
                },
                child: FutureBuilder(
                    future: getFeatureName(
                        db.companionValueToStr(feature.soilPitSoilFeature)),
                    initialData: "Please select drainage",
                    builder:
                        (BuildContext context, AsyncSnapshot<String> text) {
                      return DropDownAsyncList(
                        searchable: true,
                        padding: 0,
                        onChangedFn: (s) {
                          changeMade = true;
                          db.referenceTablesDao
                              .getSoilPitFeatureClassCode(s!)
                              .then((code) => setState(() {
                                    if (code == "N" || code == "S") {
                                      feature = feature.copyWith(
                                          soilPitSoilFeature: d.Value(code),
                                          depthFeature: const d.Value(-9));
                                    } else {
                                      feature = feature.copyWith(
                                          soilPitSoilFeature: d.Value(code));
                                    }
                                  }));
                        },
                        asyncItems: (s) => db.referenceTablesDao
                            .getSoilPitFeatureClassNameList(),
                        selectedItem:
                            text.data ?? "Error loading drainage class name",
                      );
                    })),
            db.companionValueToStr(feature.depthFeature) != "-9"
                ? DataInput(
                    title: "Depth to soil feature",
                    boxLabel: "Measured from “zero depth” to soil feature. "
                        "“Zero depth” is mineral soil surface for mineral soils, "
                        "and ground surface for organic soils.",
                    prefixIcon: FontAwesomeIcons.ruler,
                    suffixVal: "cm",
                    startingStr: db.companionValueToStr(feature.depthFeature),
                    onValidate: (s) => errorDepthFeature(s),
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      ThousandsFormatter(allowFraction: false),
                    ],
                    onSubmit: (s) {
                      changeMade = true;
                      s.isEmpty
                          ? setState(() => feature = feature.copyWith(
                              depthFeature: const d.Value.absent()))
                          : setState(() => feature = feature.copyWith(
                              depthFeature: d.Value(int.parse(s))));
                    },
                  )
                : Container(),
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
                        db.soilPitTablesDao
                            .addOrUpdateFeature(feature)
                            .then((featureId) {
                          ref.refresh(soilFeatureListProvider(spId));
                          context.goNamed(SoilPitFeaturePage.routeName,
                              pathParameters: PathParamGenerator.soilPitSummary(
                                  widget.state, spId.toString()));
                        });
                      }
                    },
                    child: const Text("Submit"))),
          ]),
        ),
      ),
    );
  }
}
