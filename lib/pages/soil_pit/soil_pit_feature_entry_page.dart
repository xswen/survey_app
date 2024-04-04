import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_feature_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:survey_app/widgets/popups/popup_errors_found_list.dart';
import 'package:survey_app/widgets/popups/popup_warning_change_made.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/soil_pit_code_select_builder.dart';
import '../../widgets/buttons/delete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';
import '../delete_page.dart';

class SoilPitFeatureEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitFeatureEntry";
  final GoRouterState state;
  const SoilPitFeatureEntryPage(this.state, {super.key});

  @override
  SoilPitFeatureEntryPageState createState() => SoilPitFeatureEntryPageState();
}

class SoilPitFeatureEntryPageState
    extends ConsumerState<SoilPitFeatureEntryPage> {
  final String title = "Soil Pit Feature";
  bool changeMade = false;

  late final int spId;
  late SoilPitFeatureCompanion feature;
  late String initSoilPit = "NA";

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummaryId(widget.state);
    feature = widget.state.extra as SoilPitFeatureCompanion;
    initSoilPit = ref.read(databaseProvider).companionValueToStr(
        (widget.state.extra as SoilPitFeatureCompanion).soilFeature);

    super.initState();
  }

  void updateFeature(SoilPitFeatureCompanion newFeature) {
    changeMade = true;
    setState(() => feature = newFeature);
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

  void goToFeaturePage() {
    ref.refresh(soilFeatureListProvider(spId));
    context.goNamed(SoilPitFeaturePage.routeName,
        pathParameters:
            PathParamGenerator.soilPitSummary(widget.state, spId.toString()));
  }

  void goToNewFeatureEntry() =>
      context.pushReplacementNamed(SoilPitFeatureEntryPage.routeName,
          pathParameters:
              PathParamGenerator.soilPitSummary(widget.state, spId.toString()),
          extra: SoilPitFeatureCompanion(
              soilPitSummaryId: feature.soilPitSummaryId,
              soilPitCode: feature.soilPitCode));

  void handleSubmit(void Function() fn) {
    List<String>? errors = errorCheck();
    if (errors != null) {
      Popups.show(context, PopupErrorsFoundList(errors: errors));
    } else {
      ref
          .read(databaseProvider)
          .soilPitTablesDao
          .addOrUpdateFeatureIfUnique(feature)
          .then((int? featureId) {
        featureId == null
            ? Popups.show(
                context,
                const PopupDismiss(
                  "Error: Values not unique.",
                  contentText: "The combination of 'Soil pit code',"
                      "'Soil feature', and 'Depth to soil feature'"
                      "must be unique. Please enter different value",
                ))
            : fn();
      });
    }
  }

  List<String>? errorCheck() {
    List<String> results = [];

    if (feature.soilPitCode == const d.Value.absent()) {
      results.add("Missing Soil Pit Code");
    }

    if (feature.soilFeature == const d.Value.absent()) {
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
    return Scaffold(
      appBar: OurAppBar(
        "$title: ${db.companionValueToStr(feature.id) == "" ? "New Feature" : "${db.companionValueToStr(feature.soilPitCode)}, "
            "${db.companionValueToStr(feature.soilFeature)}, "
            "${db.companionValueToStr(feature.depthFeature)}"}",
        backFn: () {
          if (changeMade) {
            Popups.show(context, PopupWarningChangesUnsaved(
              rightBtnOnPressed: () {
                ref.refresh(soilFeatureListProvider(spId));
                context.pop();
                context.pop();
              },
            ));
          } else {
            ref.refresh(soilFeatureListProvider(spId));
            context.pop();
          }
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: Column(children: [
            SoilPitCodeSelectBuilder(
                code: db.companionValueToStr(feature.soilPitCode),
                initPlotCodeName: initSoilPit,
                usedPlotCodes:
                    db.soilPitTablesDao.getFeatureUsedPlotCodeNameList(spId),
                onChange: (code) => updateFeature(
                    feature.copyWith(soilPitCode: d.Value(code)))),
            FutureBuilder(
                future:
                    getFeatureName(db.companionValueToStr(feature.soilFeature)),
                initialData: "Please select feature",
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return DropDownAsyncList(
                    title: "Soil feature noted from soil pit",
                    searchable: true,
                    onChangedFn: (s) {
                      db.referenceTablesDao
                          .getSoilPitFeatureClassCode(s!)
                          .then((code) => setState(() {
                                if (code == "N") {
                                  updateFeature(feature.copyWith(
                                      soilFeature: d.Value(code),
                                      depthFeature: const d.Value(-9)));
                                } else {
                                  //Override the previous state depth feature state
                                  //if was previous marked as not applicable
                                  db.companionValueToStr(feature.soilFeature) ==
                                          "N"
                                      ? updateFeature(feature.copyWith(
                                          soilFeature: d.Value(code),
                                          depthFeature: const d.Value.absent()))
                                      : updateFeature(feature.copyWith(
                                          soilFeature: d.Value(code)));
                                }
                              }));
                    },
                    asyncItems: (s) =>
                        db.referenceTablesDao.getSoilPitFeatureClassNameList(),
                    selectedItem:
                        text.data ?? "Error loading feature class name",
                  );
                }),
            db.companionValueToStr(feature.soilFeature) != "N"
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
                    onSubmit: (s) => s.isEmpty
                        ? updateFeature(feature.copyWith(
                            depthFeature: const d.Value.absent()))
                        : updateFeature(feature.copyWith(
                            depthFeature: d.Value(int.parse(s)))),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => handleSubmit(goToFeaturePage),
                      child: const Text("Save and return")),
                  ElevatedButton(
                      onPressed: () => handleSubmit(goToNewFeatureEntry),
                      child: const Text("Save and Add New Feature")),
                ],
              ),
            ),
            feature.id != const d.Value.absent()
                ? DeleteButton(
                    delete: () => Popups.show(
                      context,
                      PopupContinue("Warning: Deleting Soil Pit Feature",
                          contentText: "You are about to delete this feature. "
                              "Are you sure you want to continue?",
                          rightBtnOnPressed: () {
                        //close popup
                        context.pop();
                        context.pushNamed(DeletePage.routeName, extra: {
                          DeletePage.keyObjectName:
                              "Soil Pit Feature: ${feature.toString()}",
                          DeletePage.keyDeleteFn: () {
                            db.soilPitTablesDao
                                .deleteSoilPitFeature(feature.id.value)
                                .then((value) => goToFeaturePage());
                          },
                        });
                      }),
                    ),
                  )
                : Container()
          ]),
        ),
      ),
    );
  }
}
