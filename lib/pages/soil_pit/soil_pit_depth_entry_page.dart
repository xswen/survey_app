import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_depth_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:survey_app/widgets/builders/soil_pit_code_select_builder.dart';

import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/data_input/data_input.dart';

class SoilPitDepthEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitDepthEntry";
  final GoRouterState state;
  const SoilPitDepthEntryPage(this.state, {super.key});

  @override
  SoilPitDepthEntryPageState createState() => SoilPitDepthEntryPageState();
}

class SoilPitDepthEntryPageState extends ConsumerState<SoilPitDepthEntryPage> {
  final String title = "Soil Pit Depth";
  bool changeMade = false;

  late final int spId;
  late SoilPitDepthCompanion depth;
  late String initSoilPit = "NA";

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummary(widget.state);
    depth = widget.state.extra as SoilPitDepthCompanion;
    initSoilPit = ref.read(databaseProvider).companionValueToStr(
        (widget.state.extra as SoilPitDepthCompanion).soilPitCodeCompiled);

    super.initState();
  }

  Future<String> getPitCodeName(String code) async {
    if (code.isEmpty) {
      return "Please select soil pit code";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilPitCodeCompiledName(code);
  }

  List<String>? errorCheck() {
    List<String> results = [];

    if (depth.soilPitCodeCompiled == const d.Value.absent()) {
      results.add("Missing Soil Pit Code");
    }

    if (errorDepthMin(
            ref.read(databaseProvider).companionValueToStr(depth.depthMin)) !=
        null) {
      results.add("Error for mineral depth");
    }

    if (errorDepthOrg(
            ref.read(databaseProvider).companionValueToStr(depth.depthOrg)) !=
        null) {
      results.add("Error for mineral depth");
    }
  }

  String? errorDepthMin(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text!) || double.parse(text!) > 999.9) {
      return "Input out of range. Must be between 0.0 to 999.9 inclusive.";
    }
    return null;
  }

  String? errorDepthOrg(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text!) || double.parse(text!) > 999.9) {
      return "Input out of range. Must be between 0.0 to 999.9 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "$title: Soil Pit Depth ${db.companionValueToStr(depth.soilPitCodeCompiled)}",
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: Column(children: [
            SoilPitCodeSelectBuilder(
                code: db.companionValueToStr(depth.soilPitCodeCompiled),
                initPlotCodeName: initSoilPit,
                plotCodeNames:
                    db.referenceTablesDao.getSoilPitCodeCompiledNameList(),
                usedPlotCodes:
                    db.soilPitTablesDao.getDepthUsedPlotCodeNameList(spId),
                onChange: (s) {
                  changeMade = true;
                  db.referenceTablesDao
                      .getSoilPitCodeCompiledCode(s!)
                      .then((code) => setState(() {
                            depth = depth.copyWith(
                                soilPitCodeCompiled: d.Value(code));
                          }));
                }),
            DataInput(
              title:
                  "Total depth to which mineral soil samples were collected (Compiled)",
              boxLabel: "Measure to the nearest 0.1",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "cm",
              startingStr: db.companionValueToStr(depth.depthMin),
              onValidate: (s) => errorDepthMin(s),
              inputType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (s) {
                changeMade = true;
                s.isEmpty
                    ? setState(() => depth =
                        depth.copyWith(depthMin: const d.Value.absent()))
                    : setState(() => depth =
                        depth.copyWith(depthMin: d.Value(double.parse(s))));
              },
            ),
            DataInput(
              title:
                  "Total depth to which organic soil samples were collected (Compiled)",
              boxLabel: "Measure to the nearest 0.1",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "cm",
              startingStr: db.companionValueToStr(depth.depthMin),
              onValidate: (s) => errorDepthOrg(s),
              inputType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (s) {
                changeMade = true;
                s.isEmpty
                    ? setState(() => depth =
                        depth.copyWith(depthOrg: const d.Value.absent()))
                    : setState(() => depth =
                        depth.copyWith(depthOrg: d.Value(double.parse(s))));
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
                        db.soilPitTablesDao
                            .addOrUpdateDepth(depth)
                            .then((depthId) {
                          ref.refresh(soilDepthListProvider(spId));
                          context.goNamed(SoilPitDepthPage.routeName,
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
