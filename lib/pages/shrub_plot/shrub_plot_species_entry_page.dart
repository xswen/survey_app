import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/shrub_plot/shrub_plot_summary.dart';
import 'package:survey_app/providers/shrub_plot_providers.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/ltp_genus_select_builder.dart';
import '../../widgets/builders/ltp_species_select_builder.dart';
import '../../widgets/builders/ltp_variety_select_builder.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/save_entry_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../delete_page.dart';

class ShrubPlotSpeciesEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "shrubPlotSpeciesEntry";
  final GoRouterState state;
  const ShrubPlotSpeciesEntryPage(this.state, {super.key});

  @override
  ShrubPlotSpeciesEntryPageState createState() =>
      ShrubPlotSpeciesEntryPageState();
}

class ShrubPlotSpeciesEntryPageState
    extends ConsumerState<ShrubPlotSpeciesEntryPage> {
  final String title = "Shrub Plot Entry";
  late final int shrubId;
  late bool moreInfo;
  late ShrubListEntryCompanion shrubEntry;

  @override
  void initState() {
    shrubId = PathParamValue.getShrubSummaryId(widget.state);
    shrubEntry = widget.state.extra as ShrubListEntryCompanion;
    moreInfo = false;
    super.initState();
  }

  void addOrUpdateSpecies(void Function() fn) => ref
      .read(databaseProvider)
      .shrubPlotTablesDao
      .addOrUpdateShrubListEntry(shrubEntry)
      .then((value) => fn());

  void returnToHeader() {
    ref.refresh(shrubEntryListProvider(shrubId));
    context.goNamed(ShrubPlotSummaryPage.routeName,
        pathParameters:
            PathParamGenerator.shrubSummary(widget.state, shrubId.toString()));
  }

  void createNewSpeciesCompanion() => context.pushReplacementNamed(
        ShrubPlotSpeciesEntryPage.routeName,
        pathParameters: widget.state.pathParameters,
        extra: ShrubListEntryCompanion(shrubSummaryId: d.Value(shrubId)),
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

    if (shrubEntry.recordNum == const d.Value.absent()) {
      results.add("Missing recordNum");
    }
    if (shrubEntry.shrubGenus == const d.Value.absent()) {
      results.add("Missing shrubGenus");
    }
    if (shrubEntry.shrubSpecies == const d.Value.absent()) {
      results.add("Missing shrubSpecies");
    }
    if (shrubEntry.shrubVariety == const d.Value.absent()) {
      results.add("Missing shrubVariety");
    }
    if (shrubEntry.shrubStatus == const d.Value.absent()) {
      results.add("Missing shrubStatus");
    }
    if (shrubEntry.bdClass == const d.Value.absent() &&
        shrubEntry.bdClass != const d.Value(-1)) {
      results.add("Missing bdClass");
    }
    if (shrubEntry.frequency == const d.Value.absent()) {
      results.add("Missing frequency");
    }

    return results.isEmpty ? null : results;
  }

  String? _errorRecordNum(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (int.parse(value) < 1 || int.parse(value) > 9999) {
      return "Record number must be between 1 and 9999";
    }
    return null;
  }

  String? _errorFrequency(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 1 || double.parse(value) > 999) {
      return "Dbh must be between 1 and 999";
    }
    return null;
  }

  void updateCompanion(ShrubListEntryCompanion newComp) =>
      setState(() => shrubEntry = newComp);

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: OurAppBar(
        "Shrub Plot Species Entry",
        backFn: () {
          ref.refresh(shrubEntryListProvider(shrubId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
            DataInput(
                title: "Record Number",
                prefixIcon: FontAwesomeIcons.tree,
                inputType:
                    const TextInputType.numberWithOptions(decimal: false),
                startingStr: db.companionValueToStr(shrubEntry.recordNum),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  ThousandsFormatter(
                      allowFraction: false, maxDigitsBeforeDecimal: 4),
                ],
                onSubmit: (s) {
                  s.isEmpty
                      ? updateCompanion(shrubEntry.copyWith(
                          recordNum: const d.Value.absent()))
                      : updateCompanion(shrubEntry.copyWith(
                          recordNum: d.Value(int.parse(s))));
                },
                onValidate: _errorRecordNum),
            LtpGenusSelectBuilder(
                title: "Genus",
                enabled: true,
                updateGenusFn: (genus, species, variety) {
                  setState(() {
                    updateCompanion(shrubEntry.copyWith(
                        shrubGenus: genus,
                        shrubSpecies: species,
                        shrubVariety: variety));
                  });
                },
                genusCode: db.companionValueToStr(shrubEntry.shrubGenus)),
            LtpSpeciesSelectBuilder(
                title: "Species",
                enabled: true,
                selectedSpeciesCode:
                    db.companionValueToStr(shrubEntry.shrubSpecies),
                genusCode: db.companionValueToStr(shrubEntry.shrubGenus),
                updateSpeciesFn: (species, variety) {
                  setState(() {
                    updateCompanion(shrubEntry.copyWith(
                        shrubSpecies: species, shrubVariety: variety));
                  });
                }),
            LtpVarietySelectBuilder(
                title: "Variety",
                enabled: true,
                genusCode: db.companionValueToStr(shrubEntry.shrubGenus),
                speciesCode: db.companionValueToStr(shrubEntry.shrubSpecies),
                selectedVarietyCode:
                    db.companionValueToStr(shrubEntry.shrubVariety),
                updateVarietyFn: (variety) {
                  updateCompanion(shrubEntry.copyWith(shrubVariety: variety));
                }),
            ReferenceNameSelectBuilder(
              title: "Status",
              defaultSelectedValue: "Please select status",
              name: db.referenceTablesDao.getShrubStatusName(
                  db.companionValueToStr(shrubEntry.shrubStatus)),
              asyncListFn: db.referenceTablesDao.getShrubStatusList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao.getShrubStatusCode(s).then(
                  (value) => updateCompanion(
                      shrubEntry.copyWith(shrubStatus: d.Value(value)))),
            ),
            ReferenceNameSelectBuilder(
              title: "Basal diameter class",
              defaultSelectedValue: "Please diameter class",
              name: db.referenceTablesDao.getShrubBasalDiameterName(
                  db.companionValueToStr(shrubEntry.bdClass)),
              asyncListFn: db.referenceTablesDao.getShrubBasalDiameterList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getShrubBasalDiameterCode(s)
                  .then((value) => updateCompanion(shrubEntry.copyWith(
                      bdClass: d.Value(int.tryParse(value) ?? -1)))),
            ),
            DataInput(
                title: "Frequency",
                boxLabel:
                    "Number of primary stems tallied for each unique combination",
                prefixIcon: FontAwesomeIcons.tree,
                inputType:
                    const TextInputType.numberWithOptions(decimal: false),
                startingStr: "",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  ThousandsFormatter(maxDigitsBeforeDecimal: 3),
                ],
                onSubmit: (s) {
                  s.isEmpty
                      ? updateCompanion(shrubEntry.copyWith(
                          frequency: const d.Value.absent()))
                      : updateCompanion(shrubEntry.copyWith(
                          frequency: d.Value(int.parse(s))));
                },
                onValidate: _errorFrequency),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: SaveEntryButton(
                saveRetFn: () => onSave(returnToHeader),
                saveAndAddFn: () => onSave(createNewSpeciesCompanion),
                delVisible: shrubEntry.id != const d.Value.absent(),
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
                          "Shrub Plot Entry: ${db.companionValueToStr(shrubEntry.recordNum)}",
                      DeletePage.keyDeleteFn: () {
                        (db.delete(db.shrubListEntry)
                              ..where(
                                  (tbl) => tbl.id.equals(shrubEntry.id.value)))
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
