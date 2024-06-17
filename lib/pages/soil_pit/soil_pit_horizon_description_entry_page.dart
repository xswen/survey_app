import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_horizon_description_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_default.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/soil_pit_code_select_builder.dart';
import '../../widgets/buttons/save_entry_button.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../../widgets/popups/popup_warning_change_made.dart';
import '../../widgets/text/text_header_separator.dart';
import '../delete_page.dart';

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
  late String initSoilPit = "NA";

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummaryId(widget.state);
    horizon = widget.state.extra as SoilPitHorizonDescriptionCompanion;
    originalHorizon = widget.state.extra as SoilPitHorizonDescriptionCompanion;
    initSoilPit = ref.read(databaseProvider).companionValueToStr(
        (widget.state.extra as SoilPitHorizonDescriptionCompanion)
            .soilPitCodeField);

    super.initState();
  }

  void updateHorizon(SoilPitHorizonDescriptionCompanion newHorizon) {
    changeMade = true;
    setState(() => horizon = newHorizon);
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

  void goToHorizonPage() {
    ref.refresh(soilHorizonListProvider(spId));
    context.goNamed(SoilPitHorizonDescriptionPage.routeName,
        pathParameters:
            PathParamGenerator.soilPitSummary(widget.state, spId.toString()));
  }

  void goToNewHorizonEntry() {
    context.pushReplacementNamed(SoilPitHorizonDescriptionEntryPage.routeName,
        pathParameters:
            PathParamGenerator.soilPitSummary(widget.state, spId.toString()),
        extra: SoilPitHorizonDescriptionCompanion(
            soilPitSummaryId: horizon.soilPitSummaryId,
            soilPitCodeField: horizon.soilPitCodeField));
  }

  void onSave(void Function() fn) {
    List<String>? errors = errorCheck();
    if (errors != null) {
      Popups.show(context, PopupErrorsFoundList(errors: errors));
    } else {
      ref
          .read(databaseProvider)
          .soilPitTablesDao
          .addOrUpdateHorizonIfUnique(horizon)
          .then((int? horizonId) {
        horizonId == null
            ? Popups.show(
                context,
                const PopupDismiss(
                  "Error: Values not unique.",
                  contentText: "The combination of 'Soil pit code',"
                      "and 'Horizon Number' must be unique. "
                      "Please enter different value",
                ))
            : fn();
      });
    }
  }

  int checkCfValue(d.Value cfValue) {
    String cfStr = Database.instance.companionValueToStr(cfValue);
    int intVal = int.parse(cfStr.isEmpty ? "0" : cfStr);

    return intVal > 0 ? intVal : 0;
  }

  List<String>? errorCheck() {
    Database db = Database.instance;
    List<String> results = [];

    if (horizon.soilPitCodeField == const d.Value.absent()) {
      results.add("Missing Soil Pit Code");
    }
    if (horizon.horizonNum == const d.Value.absent()) {
      results.add("Missing horizon number");
    }
    if (horizon.horizon == const d.Value.absent()) {
      results.add("Missing horizons");
    }
    if (horizon.mineralType == const d.Value.absent()) {
      results.add("Missing mineral type");
    }

    if (errorHorUpperDepth(db.companionValueToStr(horizon.horizonUpper)) !=
        null) {
      results.add("Error found for horizon upper depth");
    }

    if (errorHorThickness(db.companionValueToStr(horizon.thickness)) != null) {
      results.add("Error found for horizon thickness");
    }

    if (horizon.color == const d.Value.absent()) {
      results.add("Missing soil color");
    }
    if (horizon.texture == const d.Value.absent()) {
      results.add("Missing texture");
    }

    if (errorCf(db.companionValueToStr(horizon.cfGrav)) != null) {
      results.add("Error found for volumetric percent gravel");
    }
    if (errorCf(db.companionValueToStr(horizon.cfCobb)) != null) {
      results.add("Error found for volumetric percent cobble");
    }
    if (errorCf(db.companionValueToStr(horizon.cfStone)) != null) {
      results.add("Error found for volumetric percent stone");
    }

    if (checkCfValue(horizon.cfGrav) +
            checkCfValue(horizon.cfCobb) +
            checkCfValue(horizon.cfStone) >
        100) {
      results
          .add("Error sum of gravel, cobble, and stone must be less than 100");
    }

    return results.isEmpty ? null : results;
  }

  String? errorHorUpperDepth(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (-1.0 == double.parse(text!)) {
      return null;
    } else if (0 > double.parse(text) || double.parse(text) > 200) {
      return "Input out of range. Must be between 0.0 to 200.0 inclusive.";
    }
    return null;
  }

  String? errorHorThickness(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (-1.0 == double.parse(text!)) {
      return null;
    } else if (0 > double.parse(text) || double.parse(text) > 300) {
      return "Input out of range. Must be between 0.0 to 300.0 inclusive.";
    }
    return null;
  }

  String? errorCf(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (-1 == int.parse(text!) || -9 == int.parse(text)) {
      return null;
    } else if (0 > int.parse(text) || int.parse(text) > 100) {
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
        backFn: () {
          if (changeMade) {
            Popups.show(context, PopupWarningChangesUnsaved(
              rightBtnOnPressed: () {
                ref.refresh(soilHorizonListProvider(spId));
                context.pop();
                context.pop();
              },
            ));
          } else {
            ref.refresh(soilHorizonListProvider(spId));
            context.pop();
          }
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
            SoilPitCodeSelectBuilder(
              code: db.companionValueToStr(horizon.soilPitCodeField),
              initPlotCodeName: initSoilPit,
              usedPlotCodes:
                  db.soilPitTablesDao.getHorizonUsedPlotCodeNameList(spId),
              onChange: (code) => updateHorizon(
                  horizon.copyWith(soilPitCodeField: d.Value(code))),
            ),
            const SizedBox(
              height: kPaddingV * 2,
            ),
            DataInput(
              title: "Horizon number",
              boxLabel: "Horizons must be numbered consecutively",
              prefixIcon: FontAwesomeIcons.list,
              suffixVal: "",
              startingStr: db.companionValueToStr(horizon.horizonNum),
              paddingGeneral: const EdgeInsets.all(0),
              onValidate: (s) => null,
              inputType: const TextInputType.numberWithOptions(decimal: false),
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                ThousandsFormatter(allowFraction: false),
              ],
              onSubmit: (s) => s.isEmpty
                  ? updateHorizon(
                      horizon.copyWith(horizonNum: const d.Value.absent()))
                  : updateHorizon(
                      horizon.copyWith(horizonNum: d.Value(int.parse(s)))),
            ),
            DataInput(
              title: "Horizon",
              boxLabel: "The horizon designations must conform to CSSC codes",
              prefixIcon: FontAwesomeIcons.list,
              suffixVal: "",
              startingStr: db.companionValueToStr(horizon.horizon),
              onValidate: (s) => null,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
              ],
              onSubmit: (s) => s.isEmpty
                  ? updateHorizon(
                      horizon.copyWith(horizon: const d.Value.absent()))
                  : updateHorizon(horizon.copyWith(horizon: d.Value(s))),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: "Information place holder",
              child: HideInfoCheckbox(
                title: "Horizon upper depth",
                titleWidget: "Unreported",
                checkValue:
                    db.companionValueToStr(horizon.horizonUpper) == "-1.0",
                onChange: (b) => b!
                    ? updateHorizon(
                        horizon.copyWith(horizonUpper: const d.Value(-1)))
                    : updateHorizon(
                        horizon.copyWith(horizonUpper: const d.Value.absent())),
                child: DataInput(
                  boxLabel: "Measure to the nearest 0.1",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "cm",
                  startingStr: db.companionValueToStr(horizon.horizonUpper),
                  paddingGeneral: const EdgeInsets.all(0),
                  onValidate: (s) => errorHorUpperDepth(s),
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                  ],
                  onSubmit: (s) => s.isEmpty
                      ? updateHorizon(horizon.copyWith(
                          horizonUpper: const d.Value.absent()))
                      : updateHorizon(horizon.copyWith(
                          horizonUpper: d.Value(double.parse(s)))),
                ),
              ),
            ),
            HideInfoCheckbox(
              title: "Average thickness of horizon",
              titleWidget: "Unreported",
              checkValue: db.companionValueToStr(horizon.thickness) == "-1.0",
              onChange: (b) => b!
                  ? updateHorizon(
                      horizon.copyWith(thickness: const d.Value(-1)))
                  : updateHorizon(
                      horizon.copyWith(thickness: const d.Value.absent())),
              child: DataInput(
                boxLabel: "Measure to the nearest 0.1",
                prefixIcon: FontAwesomeIcons.ruler,
                suffixVal: "cm",
                startingStr: db.companionValueToStr(horizon.thickness),
                paddingGeneral: const EdgeInsets.all(0),
                onValidate: (s) => errorHorThickness(s),
                inputType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                  ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                ],
                onSubmit: (s) => s.isEmpty
                    ? updateHorizon(
                        horizon.copyWith(thickness: const d.Value.absent()))
                    : updateHorizon(
                        horizon.copyWith(thickness: d.Value(double.parse(s)))),
              ),
            ),
            FutureBuilder(
                future: getSoilColorName(db.companionValueToStr(horizon.color)),
                initialData: "Please select color",
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return DropDownAsyncList(
                    title: "Soil colour",
                    searchable: true,
                    onChangedFn: (s) => db.referenceTablesDao
                        .getSoilColorCode(s!)
                        .then((code) => updateHorizon(
                              horizon.copyWith(color: d.Value(code)),
                            )),
                    asyncItems: (s) =>
                        db.referenceTablesDao.getSoilColorNameList(),
                    selectedItem: text.data ?? "Error loading color name",
                  );
                }),
            DropDownDefault(
                title: "Horizon type",
                onChangedFn: (s) => s == "Mineral"
                    ? updateHorizon(horizon.copyWith(
                        mineralType: d.Value(s!),
                        texture: const d.Value.absent(),
                        cfCobb: const d.Value.absent(),
                        cfGrav: const d.Value.absent(),
                        cfStone: const d.Value.absent()))
                    : updateHorizon(horizon.copyWith(
                        mineralType: d.Value(s!),
                        texture: const d.Value("-1"),
                        cfCobb: const d.Value(-1),
                        cfGrav: const d.Value(-1),
                        cfStone: const d.Value(-1))),
                itemsList: const ["Mineral", "Non-mineral"],
                selectedItem:
                    db.companionValueToStr(horizon.mineralType).isEmpty
                        ? "Please select mineral type"
                        : db.companionValueToStr(horizon.mineralType)),
            Visibility(
                visible:
                    db.companionValueToStr(horizon.mineralType) == "Mineral",
                child: Column(
                  children: [
                    FutureBuilder(
                        future: getSoilTextureName(
                            db.companionValueToStr(horizon.texture)),
                        initialData: "Please select texture",
                        builder:
                            (BuildContext context, AsyncSnapshot<String> text) {
                          return DropDownAsyncList(
                            title: "Soil texture",
                            searchable: true,
                            onChangedFn: (s) => db.referenceTablesDao
                                .getSoilTextureCode(s!)
                                .then(
                                  (code) => updateHorizon(
                                      horizon.copyWith(texture: d.Value(code))),
                                ),
                            asyncItems: (s) =>
                                db.referenceTablesDao.getSoilTextureNameList(),
                            selectedItem:
                                text.data ?? "Error loading texture name",
                          );
                        }),
                    Column(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: kPaddingV * 2),
                          child: TextHeaderSeparator(
                            title: "Coarse Fragment Content",
                            fontSize: 20,
                          ),
                        ),
                        HideInfoCheckbox(
                          title: "Volumetric percent gravel",
                          titleWidget: "Not applicable",
                          padding: const EdgeInsets.all(0),
                          checkValue:
                              db.companionValueToStr(horizon.cfGrav) == "-9",
                          onChange: (b) => b!
                              ? updateHorizon(
                                  horizon.copyWith(cfGrav: const d.Value(-9)))
                              : updateHorizon(horizon.copyWith(
                                  cfGrav: const d.Value.absent())),
                          child: DataInput(
                            boxLabel:
                                "The percent coarse fragment content by volume of the mineral "
                                "horizon. (Diameter < 7.5 cm or length < 15 cm.)",
                            prefixIcon: FontAwesomeIcons.percent,
                            suffixVal: "%",
                            startingStr: db.companionValueToStr(horizon.cfGrav),
                            paddingGeneral: const EdgeInsets.all(0),
                            onValidate: (s) => errorCf(s),
                            inputType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              ThousandsFormatter(
                                  allowFraction: true, decimalPlaces: 1),
                            ],
                            onSubmit: (s) => s.isEmpty
                                ? updateHorizon(horizon.copyWith(
                                    cfGrav: const d.Value.absent()))
                                : updateHorizon(horizon.copyWith(
                                    cfGrav: d.Value(int.parse(s)))),
                          ),
                        ),
                        HideInfoCheckbox(
                          title: "Volumetric percent cobbles",
                          titleWidget: "Not applicable",
                          padding: const EdgeInsets.all(0),
                          checkValue:
                              db.companionValueToStr(horizon.cfCobb) == "-9",
                          onChange: (b) => b!
                              ? updateHorizon(
                                  horizon.copyWith(cfCobb: const d.Value(-9)))
                              : updateHorizon(horizon.copyWith(
                                  cfCobb: const d.Value.absent())),
                          child: DataInput(
                            boxLabel:
                                "The percent coarse fragment (diameter = 7.5 to 25 cm or "
                                "length = 15 to 38 cm) content by volume of the mineral horizon.",
                            prefixIcon: FontAwesomeIcons.percent,
                            suffixVal: "%",
                            startingStr: db.companionValueToStr(horizon.cfCobb),
                            paddingGeneral: const EdgeInsets.all(0),
                            onValidate: (s) => errorCf(s),
                            inputType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              ThousandsFormatter(
                                  allowFraction: true, decimalPlaces: 1),
                            ],
                            onSubmit: (s) => s.isEmpty
                                ? updateHorizon(horizon.copyWith(
                                    cfCobb: const d.Value.absent()))
                                : updateHorizon(horizon.copyWith(
                                    cfCobb: d.Value(int.parse(s)))),
                          ),
                        ),
                        HideInfoCheckbox(
                          title: "Volumetric percent stone",
                          titleWidget: "Not applicable",
                          padding: const EdgeInsets.all(0),
                          checkValue:
                              db.companionValueToStr(horizon.cfStone) == "-9",
                          onChange: (b) => b!
                              ? updateHorizon(
                                  horizon.copyWith(cfStone: const d.Value(-9)))
                              : updateHorizon(horizon.copyWith(
                                  cfStone: const d.Value.absent())),
                          child: DataInput(
                            boxLabel:
                                "The percent coarse fragment (diameter > 25 cm or length > 38 "
                                "cm) content by volume of the mineral horizon.",
                            prefixIcon: FontAwesomeIcons.percent,
                            suffixVal: "%",
                            startingStr:
                                db.companionValueToStr(horizon.cfStone),
                            paddingGeneral: const EdgeInsets.all(0),
                            onValidate: (s) => errorCf(s),
                            inputType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              ThousandsFormatter(
                                  allowFraction: true, decimalPlaces: 1),
                            ],
                            onSubmit: (s) => s.isEmpty
                                ? updateHorizon(horizon.copyWith(
                                    cfStone: const d.Value.absent()))
                                : updateHorizon(horizon.copyWith(
                                    cfStone: d.Value(int.parse(s)))),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: SaveEntryButton(
                saveRetFn: () => onSave(goToHorizonPage),
                saveAndAddFn: () => onSave(goToNewHorizonEntry),
                delVisible: horizon.id != const d.Value.absent(),
                deleteFn: () => Popups.show(
                  context,
                  PopupContinue("Warning: Deleting $title",
                      contentText: "You are about to delete this feature. "
                          "Are you sure you want to continue?",
                      rightBtnOnPressed: () {
                    //close popup
                    context.pop();
                    context.pushNamed(DeletePage.routeName, extra: {
                      DeletePage.keyObjectName:
                          "Soil Pit Feature: ${horizon.toString()}",
                      DeletePage.keyDeleteFn: () => db.soilPitTablesDao
                          .deleteSoilPitHorizonDescription(horizon.id.value)
                          .then((value) => goToHorizonPage()),
                    });
                  }),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
