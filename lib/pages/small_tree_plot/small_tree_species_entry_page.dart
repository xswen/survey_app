import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/small_tree_plot/small_tree_plot_summary.dart';
import 'package:survey_app/providers/small_tree_plot_providers.dart';
import 'package:survey_app/widgets/builders/ltp_genus_select_builder.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/ltp_species_select_builder.dart';
import '../../widgets/builders/ltp_variety_select_builder.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/save_entry_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../delete_page.dart';

class SmallTreeSpeciesEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "smallTreeSpeciesEntry";
  final GoRouterState state;
  const SmallTreeSpeciesEntryPage(this.state, {super.key});

  @override
  SmallTreeSpeciesEntryPageState createState() =>
      SmallTreeSpeciesEntryPageState();
}

class SmallTreeSpeciesEntryPageState
    extends ConsumerState<SmallTreeSpeciesEntryPage> {
  final String title = "Small Tree Plot Species Entry";
  late final int stpId;
  late bool moreInfo;
  late StpSpeciesCompanion speciesCompanion;

  @override
  void initState() {
    stpId = PathParamValue.getStpSummaryId(widget.state);
    speciesCompanion = widget.state.extra as StpSpeciesCompanion;
    moreInfo = false;
    super.initState();
  }

  void addOrUpdateSpecies(void Function() fn) => ref
      .read(databaseProvider)
      .smallTreePlotTablesDao
      .addOrUpdateStpSpecies(speciesCompanion)
      .then((value) => fn());

  void returnToHeader() {
    ref.refresh(stpSpeciesListProvider(stpId));
    context.goNamed(SmallTreePlotSummaryPage.routeName,
        pathParameters:
            PathParamGenerator.stpSummary(widget.state, stpId.toString()));
  }

  void createNewSpeciesCompanion() => context.pushReplacementNamed(
        SmallTreeSpeciesEntryPage.routeName,
        pathParameters: widget.state.pathParameters,
        extra: StpSpeciesCompanion(stpSummaryId: d.Value(stpId)),
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
    if (speciesCompanion.treeNum == const d.Value.absent()) {
      results.add("Missing treeNum");
    }
    if (speciesCompanion.origPlotArea == const d.Value.absent()) {
      results.add("Missing origPlotArea");
    }
    if (speciesCompanion.genus == const d.Value.absent()) {
      results.add("Missing genus");
    }
    if (speciesCompanion.species == const d.Value.absent()) {
      results.add("Missing species");
    }
    if (speciesCompanion.variety == const d.Value.absent()) {
      results.add("Missing variety");
    }
    if (speciesCompanion.status == const d.Value.absent()) {
      results.add("Missing status");
    }
    if (speciesCompanion.dbh != d.Value(-1.0) &&
        _errorDbh(db.companionValueToStr(speciesCompanion.dbh)) != null) {
      results.add("Error in Dbh");
    }
    if (speciesCompanion.height != d.Value(-1.0) &&
        _errorHeight(db.companionValueToStr(speciesCompanion.height)) != null) {
      results.add("Error in height");
    }
    if (speciesCompanion.measHeight == const d.Value.absent()) {
      results.add("Missing measHeight");
    }
    if (speciesCompanion.stemCondition == const d.Value.absent()) {
      results.add("Missing stemCondition");
    }

    return results.isEmpty ? null : results;
  }

  String? _errorTreeNum(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (int.parse(value) < 1 || int.parse(value) > 9999) {
      return "Tree number must be between 1 and 9999";
    }
    return null;
  }

  String? _errorDbh(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 0.1 || double.parse(value) > 8.9) {
      return "Dbh must be between 0.1 and 8.9cm";
    }
    return null;
  }

  String? _errorHeight(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 1.3 || double.parse(value) > 20) {
      return "Height3 must be between 1.3 and 20m";
    }
    return null;
  }

  void updateSpeciesCompanion(StpSpeciesCompanion newSpecies) =>
      setState(() => speciesCompanion = newSpecies);

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Small Tree Plot Species Entry",
        backFn: () {
          ref.refresh(stpSpeciesListProvider(stpId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
            DataInput(
                title: "Tree Number",
                prefixIcon: FontAwesomeIcons.tree,
                inputType:
                    const TextInputType.numberWithOptions(decimal: false),
                startingStr: db.companionValueToStr(speciesCompanion.treeNum),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  ThousandsFormatter(
                      allowFraction: false, maxDigitsBeforeDecimal: 4),
                ],
                onSubmit: (s) {
                  s.isEmpty
                      ? updateSpeciesCompanion(speciesCompanion.copyWith(
                          treeNum: const d.Value.absent()))
                      : updateSpeciesCompanion(speciesCompanion.copyWith(
                          treeNum: d.Value(int.parse(s))));
                },
                onValidate: _errorTreeNum),
            ReferenceNameSelectBuilder(
              title: "Original plot area",
              defaultSelectedValue: "Select plot area",
              name: db.referenceTablesDao.getStpOrigAreaName(
                  db.companionValueToStr(speciesCompanion.origPlotArea)),
              asyncListFn: db.referenceTablesDao.getStpOrigAreaList,
              enabled: true,
              onChange: (s) =>
                  db.referenceTablesDao.getStpOrigAreaCode(s).then((value) {
                updateSpeciesCompanion(
                    speciesCompanion.copyWith(origPlotArea: d.Value(value)));
              }),
            ),
            LtpGenusSelectBuilder(
                title: "Small tree genus",
                enabled: true,
                updateGenusFn: (genus, species, variety) {
                  setState(() {
                    updateSpeciesCompanion(speciesCompanion.copyWith(
                        genus: genus, species: species, variety: variety));
                  });
                },
                genusCode: db.companionValueToStr(speciesCompanion.genus)),
            LtpSpeciesSelectBuilder(
                title: "Small tree species",
                enabled: true,
                selectedSpeciesCode:
                    db.companionValueToStr(speciesCompanion.species),
                genusCode: db.companionValueToStr(speciesCompanion.genus),
                updateSpeciesFn: (species, variety) {
                  setState(() {
                    updateSpeciesCompanion(speciesCompanion.copyWith(
                        species: species, variety: variety));
                  });
                }),
            LtpVarietySelectBuilder(
                title: "Small tree Variety",
                enabled: true,
                genusCode: db.companionValueToStr(speciesCompanion.genus),
                speciesCode: db.companionValueToStr(speciesCompanion.species),
                selectedVarietyCode:
                    db.companionValueToStr(speciesCompanion.variety),
                updateVarietyFn: (variety) {
                  updateSpeciesCompanion(
                      speciesCompanion.copyWith(variety: variety));
                }),
            ReferenceNameSelectBuilder(
              title: "Small tree status",
              defaultSelectedValue: "Please select status",
              name: db.referenceTablesDao.getStpStatusName(
                  db.companionValueToStr(speciesCompanion.status)),
              asyncListFn: db.referenceTablesDao.getStpStatusList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao.getStpStatusCode(s).then(
                  (value) => updateSpeciesCompanion(
                      speciesCompanion.copyWith(status: d.Value(value)))),
            ),
            HideInfoCheckbox(
              title: "Small tree DBH",
              titleWidget: "Unreported",
              checkValue: speciesCompanion.dbh == const d.Value(-1.0),
              onChange: (b) {
                speciesCompanion.dbh == const d.Value(-1.0)
                    ? updateSpeciesCompanion(
                        speciesCompanion.copyWith(dbh: const d.Value.absent()))
                    : updateSpeciesCompanion(
                        speciesCompanion.copyWith(dbh: const d.Value(-1.0)));
              },
              child: DataInput(
                  boxLabel: "Report to the nearest 0.1cm",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "cm",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: db.companionValueToStr(speciesCompanion.dbh),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    ThousandsFormatter(
                        allowFraction: true,
                        decimalPlaces: 1,
                        maxDigitsBeforeDecimal: 1),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {
                    s.isEmpty
                        ? updateSpeciesCompanion(speciesCompanion.copyWith(
                            dbh: const d.Value.absent()))
                        : updateSpeciesCompanion(speciesCompanion.copyWith(
                            dbh: d.Value(double.parse(s))));
                  },
                  onValidate: _errorDbh),
            ),
            HideInfoCheckbox(
              title: "Small tree height",
              titleWidget: "Unreported",
              checkValue: speciesCompanion.height == const d.Value(-1.0),
              onChange: (b) {
                speciesCompanion.height == const d.Value(-1.0)
                    ? updateSpeciesCompanion(speciesCompanion.copyWith(
                        height: const d.Value.absent()))
                    : updateSpeciesCompanion(
                        speciesCompanion.copyWith(height: const d.Value(-1.0)));
              },
              child: DataInput(
                  boxLabel: "Report to the nearest 0.1m",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "m",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: db.companionValueToStr(speciesCompanion.height),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    ThousandsFormatter(
                        allowFraction: true,
                        decimalPlaces: 1,
                        maxDigitsBeforeDecimal: 2),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {
                    s.isEmpty
                        ? updateSpeciesCompanion(speciesCompanion.copyWith(
                            height: const d.Value.absent()))
                        : updateSpeciesCompanion(speciesCompanion.copyWith(
                            height: d.Value(double.parse(s))));
                  },
                  onValidate: _errorHeight),
            ),
            ReferenceNameSelectBuilder(
              title: "Measured or estimated small tree height",
              defaultSelectedValue: "Select height",
              name: db.referenceTablesDao.getStpHeightName(
                  db.companionValueToStr(speciesCompanion.measHeight)),
              asyncListFn: db.referenceTablesDao.getStpHeightList,
              enabled: true,
              onChange: (s) =>
                  db.referenceTablesDao.getStpHeightCode(s).then((value) {
                updateSpeciesCompanion(
                    speciesCompanion.copyWith(measHeight: d.Value(value)));
              }),
            ),
            ReferenceNameSelectBuilder(
              title: "Stem condition",
              defaultSelectedValue: "Select stem condition",
              name: db.referenceTablesDao.getStpStemConditionName(
                  db.companionValueToStr(speciesCompanion.stemCondition)),
              asyncListFn: db.referenceTablesDao.getStpStemConditionList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getStpStemConditionCode(s)
                  .then((value) => updateSpeciesCompanion(speciesCompanion
                      .copyWith(stemCondition: d.Value(value)))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: SaveEntryButton(
                saveRetFn: () => onSave(returnToHeader),
                saveAndAddFn: () => onSave(createNewSpeciesCompanion),
                delVisible: speciesCompanion.id != const d.Value.absent(),
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
                          "Small Tree Plot Species Tree: ${db.companionValueToStr(speciesCompanion.treeNum)}",
                      DeletePage.keyDeleteFn: () {
                        (db.delete(db.stpSpecies)
                              ..where((tbl) =>
                                  tbl.id.equals(speciesCompanion.id.value)))
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
