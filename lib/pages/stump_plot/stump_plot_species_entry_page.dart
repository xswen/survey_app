import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/stump_plot/stump_plot_summary_page.dart';
import 'package:survey_app/providers/stump_plot_providers.dart';
import 'package:survey_app/widgets/builders/decay_class_select_builder.dart';
import 'package:survey_app/widgets/buttons/save_entry_button.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/ltp_genus_select_builder.dart';
import '../../widgets/builders/ltp_species_select_builder.dart';
import '../../widgets/builders/ltp_variety_select_builder.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../delete_page.dart';

class StumpPlotSpeciesEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "stumpPlotSpeciesEntry";
  final GoRouterState state;
  const StumpPlotSpeciesEntryPage(this.state, {super.key});

  @override
  StumpPlotSpeciesEntryPageState createState() =>
      StumpPlotSpeciesEntryPageState();
}

class StumpPlotSpeciesEntryPageState
    extends ConsumerState<StumpPlotSpeciesEntryPage> {
  final String title = "Small Tree Plot Species Entry";
  late final int stumpId;
  late bool moreInfo;
  late StumpEntryCompanion entry;

  @override
  void initState() {
    stumpId = PathParamValue.getStumpSummaryId(widget.state);
    entry = widget.state.extra as StumpEntryCompanion;
    moreInfo = false;
    super.initState();
  }

  void addOrUpdateSpecies(void Function() fn) => ref
      .read(databaseProvider)
      .stumpPlotTablesDao
      .addOrUpdateStumpEntry(entry)
      .then((value) => fn());

  void returnToHeader() {
    ref.refresh(stumpEntryListProvider(stumpId));
    context.goNamed(StumpPlotSummaryPage.routeName,
        pathParameters:
            PathParamGenerator.stumpSummary(widget.state, stumpId.toString()));
  }

  void createNewSpeciesCompanion() => context.pushReplacementNamed(
        StumpPlotSpeciesEntryPage.routeName,
        pathParameters: widget.state.pathParameters,
        extra: StumpEntryCompanion(stumpSummaryId: d.Value(stumpId)),
      );

  void onSave(void Function() fn) {
    List<String>? errors = _errorCheck();
    if (errors != null) {
      Popups.show(context, PopupErrorsFoundList(errors: errors));
    } else {
      addOrUpdateSpecies(fn);
    }
  }

  List<String>? _errorCheck() {
    Database db = ref.read(databaseProvider);
    List<String> results = [];

    if (_errorStumpNum(db.companionValueToStr(entry.stumpNum)) != null) {
      results.add("Missing stumpNum");
    }
    if (entry.origPlotArea == const d.Value.absent()) {
      results.add("Missing origPlotArea");
    }
    if (entry.stumpGenus == const d.Value.absent()) {
      results.add("Missing stumpGenus");
    }
    if (entry.stumpSpecies == const d.Value.absent()) {
      results.add("Missing stumpSpecies");
    }
    if (entry.stumpVariety == const d.Value.absent()) {
      results.add("Missing stumpVariety");
    }
    if (entry.stumpDib != const d.Value(-1.0) &&
        _errorDib(db.companionValueToStr(entry.stumpDib)) != null) {
      results.add("Missing stumpDib");
    }
    if (entry.stumpDiameter != const d.Value(-1.0) &&
        _errorDiameter(db.companionValueToStr(entry.stumpDiameter)) != null) {
      results.add("Missing stumpDiameter");
    }
    if (entry.stumpDecay == const d.Value.absent()) {
      results.add("Missing stumpDecay");
    }
    if (entry.stumpLength != const d.Value(-1.0) &&
        _errorLength(db.companionValueToStr(entry.stumpLength)) != null) {
      results.add("Missing stumpLength");
    }

    return results.isEmpty ? null : results;
  }

  String? _errorStumpNum(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (int.parse(value) < 1 || int.parse(value) > 9999) {
      return "Tree number must be between 1 and 9999";
    }
    return null;
  }

  String? _errorDib(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 4.0 || double.parse(value) > 999.9) {
      return "Dbh must be between 4.0 and 999.9cm";
    }
    return null;
  }

  String? _errorDiameter(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 4.0 || double.parse(value) > 999.9) {
      return "Diameter must be between 4.0 and 999.9cm";
    }
    return null;
  }

  String? _errorLength(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 0.01 || double.parse(value) > 1.29) {
      return "Diameter must be between 0.01 and 1.29m";
    }
    return null;
  }

  void updateSpeciesCompanion(StumpEntryCompanion newSpecies) =>
      setState(() => entry = newSpecies);

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Stump Plot Species Entry",
        backFn: () {
          ref.refresh(stumpEntryListProvider(stumpId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
            DataInput(
                title: "Stump Number",
                prefixIcon: FontAwesomeIcons.tree,
                inputType:
                    const TextInputType.numberWithOptions(decimal: false),
                startingStr: db.companionValueToStr(entry.stumpNum),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  ThousandsFormatter(
                      allowFraction: false, maxDigitsBeforeDecimal: 4),
                ],
                onSubmit: (s) {
                  s.isEmpty
                      ? updateSpeciesCompanion(
                          entry.copyWith(stumpNum: const d.Value.absent()))
                      : updateSpeciesCompanion(
                          entry.copyWith(stumpNum: d.Value(int.parse(s))));
                },
                onValidate: _errorStumpNum),
            ReferenceNameSelectBuilder(
              title: "Original plot area",
              defaultSelectedValue: "Select plot area",
              name: db.referenceTablesDao.getStumpOrigPlotAreaName(
                  db.companionValueToStr(entry.origPlotArea)),
              asyncListFn: db.referenceTablesDao.getStumpOrigPlotAreaList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getStumpOrigPlotAreaCode(s)
                  .then((value) => updateSpeciesCompanion(
                      entry.copyWith(origPlotArea: d.Value(value)))),
            ),
            LtpGenusSelectBuilder(
                title: "Genus",
                enabled: true,
                updateGenusFn: (genus, species, variety) {
                  setState(() {
                    updateSpeciesCompanion(entry.copyWith(
                        stumpGenus: genus,
                        stumpSpecies: species,
                        stumpVariety: variety));
                  });
                },
                genusCode: db.companionValueToStr(entry.stumpGenus)),
            LtpSpeciesSelectBuilder(
                title: "Species",
                enabled: true,
                selectedSpeciesCode: db.companionValueToStr(entry.stumpSpecies),
                genusCode: db.companionValueToStr(entry.stumpGenus),
                updateSpeciesFn: (species, variety) {
                  setState(() {
                    updateSpeciesCompanion(entry.copyWith(
                        stumpSpecies: species, stumpVariety: variety));
                  });
                }),
            LtpVarietySelectBuilder(
                title: "Small tree Variety",
                enabled: true,
                genusCode: db.companionValueToStr(entry.stumpGenus),
                speciesCode: db.companionValueToStr(entry.stumpSpecies),
                selectedVarietyCode: db.companionValueToStr(entry.stumpVariety),
                updateVarietyFn: (variety) {
                  updateSpeciesCompanion(entry.copyWith(stumpVariety: variety));
                }),
            HideInfoCheckbox(
              title: "Stump DIB",
              titleWidget: "Unreported",
              checkValue: entry.stumpDib == const d.Value(-1.0),
              onChange: (b) {
                entry.stumpDib == const d.Value(-1.0)
                    ? updateSpeciesCompanion(
                        entry.copyWith(stumpDib: const d.Value.absent()))
                    : updateSpeciesCompanion(
                        entry.copyWith(stumpDib: const d.Value(-1.0)));
              },
              child: DataInput(
                  boxLabel: "Top inside bark diameter of stump in cm.",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "cm",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: db.companionValueToStr(entry.stumpDib),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    ThousandsFormatter(
                        allowFraction: true,
                        decimalPlaces: 1,
                        maxDigitsBeforeDecimal: 3),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {
                    s.isEmpty
                        ? updateSpeciesCompanion(
                            entry.copyWith(stumpDib: const d.Value.absent()))
                        : updateSpeciesCompanion(
                            entry.copyWith(stumpDib: d.Value(double.parse(s))));
                  },
                  onValidate: _errorDib),
            ),
            HideInfoCheckbox(
              title: "Stump diameter",
              titleWidget: "Unreported",
              checkValue: entry.stumpDiameter == const d.Value(-1.0),
              onChange: (b) {
                entry.stumpDiameter == const d.Value(-1.0)
                    ? updateSpeciesCompanion(
                        entry.copyWith(stumpDiameter: const d.Value.absent()))
                    : updateSpeciesCompanion(
                        entry.copyWith(stumpDiameter: const d.Value(-1.0)));
              },
              child: DataInput(
                  boxLabel: "Top diameter of stump including bark, if present. "
                      "If no bark present then STUMP_DIAMETER = STUMP_DIB. "
                      "Reported in cm.",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "cm",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: db.companionValueToStr(entry.stumpDiameter),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    ThousandsFormatter(
                        allowFraction: true,
                        decimalPlaces: 1,
                        maxDigitsBeforeDecimal: 3),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {
                    s.isEmpty
                        ? updateSpeciesCompanion(entry.copyWith(
                            stumpDiameter: const d.Value.absent()))
                        : updateSpeciesCompanion(entry.copyWith(
                            stumpDiameter: d.Value(double.parse(s))));
                  },
                  onValidate: _errorDiameter),
            ),
            HideInfoCheckbox(
              title: "Stump length",
              titleWidget: "Unreported",
              checkValue: entry.stumpLength == const d.Value(-1.0),
              onChange: (b) {
                entry.stumpLength == const d.Value(-1.0)
                    ? updateSpeciesCompanion(
                        entry.copyWith(stumpLength: const d.Value.absent()))
                    : updateSpeciesCompanion(
                        entry.copyWith(stumpLength: const d.Value(-1.0)));
              },
              child: DataInput(
                  boxLabel: "Length, measured to the nearest 0.01 m.",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "m",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: db.companionValueToStr(entry.stumpLength),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    ThousandsFormatter(
                        allowFraction: true,
                        decimalPlaces: 2,
                        maxDigitsBeforeDecimal: 1),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {
                    s.isEmpty
                        ? updateSpeciesCompanion(
                            entry.copyWith(stumpLength: const d.Value.absent()))
                        : updateSpeciesCompanion(entry.copyWith(
                            stumpLength: d.Value(double.parse(s))));
                  },
                  onValidate: _errorLength),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kPaddingV * 2),
              child: DecayClassSelectBuilder(
                title: "Decay Class",
                onChangedFn: (s) {
                  s == "Unreported"
                      ? updateSpeciesCompanion(
                          entry.copyWith(stumpDecay: const d.Value(-1)))
                      : updateSpeciesCompanion(
                          entry.copyWith(stumpDecay: d.Value(int.parse(s!))));
                },
                selectedItem: entry.stumpDecay == const d.Value(-1)
                    ? "Unreported"
                    : db.companionValueToStr(entry.stumpDecay),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: SaveEntryButton(
                saveRetFn: () => onSave(returnToHeader),
                saveAndAddFn: () => onSave(createNewSpeciesCompanion),
                delVisible: entry.id != const d.Value.absent(),
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
                          "Stump Species: ${db.companionValueToStr(entry.stumpNum)}",
                      DeletePage.keyDeleteFn: () {
                        (db.delete(db.stumpEntry)
                              ..where((tbl) => tbl.id.equals(entry.id.value)))
                            .go()
                            .then((value) => returnToHeader());
                      },
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
