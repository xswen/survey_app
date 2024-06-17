import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/shrub_plot/shrub_plot_species_entry_page.dart';
import 'package:survey_app/providers/shrub_plot_providers.dart';
import 'package:survey_app/widgets/disable_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../formatters/thousands_formatter.dart';
import '../../providers/survey_info_providers.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/date_select.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();

  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders recordNumber = ColumnHeaders("Record #");
  ColumnHeaders genus = ColumnHeaders("Genus");
  ColumnHeaders species = ColumnHeaders("Species");
  ColumnHeaders variety = ColumnHeaders("Variety");
  ColumnHeaders status = ColumnHeaders("Status");
  ColumnHeaders bdClass = ColumnHeaders("BD Class");
  ColumnHeaders frequency = ColumnHeaders("Frequency");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [recordNumber, genus, species, variety, status, bdClass, frequency, edit];
}

class ShrubPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "shrubPlotSummary";
  final GoRouterState state;

  const ShrubPlotSummaryPage(this.state, {super.key});

  @override
  ShrubPlotSummaryPageState createState() => ShrubPlotSummaryPageState();
}

class ShrubPlotSummaryPageState extends ConsumerState<ShrubPlotSummaryPage> {
  final ColNames columnData = ColNames();
  final String title = "Shrub Plot";
  late final int surveyId;
  late final int shrubId;

  //Placeholder values
  bool parentComplete = false;
  ShrubSummaryCompanion shrubComp = const ShrubSummaryCompanion();
  List<ShrubListEntryData> entryList = [];

  late final PopupDismiss popupPageComplete =
      Popups.generateCompleteErrorPopup(title);
  final PopupDismiss popupSurveyComplete =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    shrubId = PathParamValue.getShrubSummaryId(widget.state);
    _loadData();
    super.initState();
  }

  void _loadData() async {
    final value =
        await Database.instance.shrubPlotTablesDao.getShrubSummary(shrubId);
    final survey =
        await Database.instance.surveyInfoTablesDao.getSurvey(surveyId);

    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        parentComplete = survey.complete;
        shrubComp = value.toCompanion(true);
      });
    }
  }

  List<DataGridRow> generateDataGridRows(List<ShrubListEntryData> entryList) {
    return entryList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: columnData.recordNumber.name,
                  value: dataGridRow.recordNum),
              DataGridCell<String>(
                  columnName: columnData.genus.name,
                  value: dataGridRow.shrubGenus),
              DataGridCell<String>(
                  columnName: columnData.species.name,
                  value: dataGridRow.shrubSpecies),
              DataGridCell<String>(
                  columnName: columnData.variety.name,
                  value: dataGridRow.shrubVariety),
              DataGridCell<String>(
                  columnName: columnData.status.name,
                  value: dataGridRow.shrubStatus),
              DataGridCell<int>(
                  columnName: columnData.bdClass.name,
                  value: dataGridRow.bdClass),
              DataGridCell<int>(
                  columnName: columnData.frequency.name,
                  value: dataGridRow.frequency),
              DataGridCell<ShrubListEntryData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<ShrubListEntryData> entryList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(entryList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.recordNumber.name,
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  //Error Checks
  List<String>? errorCheck() {
    final db = ref.read(databaseProvider);
    List<String> results = [];
    if (db.companionValueToStr(shrubComp.id).isEmpty) {
      return results = ["Error getting shrub id"];
    }

    db.companionValueToStr(shrubComp.plotType).isEmpty
        ? results.add("Plot type")
        : null;

    _errorNom(db.companionValueToStr(shrubComp.nomPlotSize)) != null &&
            shrubComp.nomPlotSize != const d.Value(-1.0)
        ? results.add("Nominal Area of Plot")
        : null;
    _errorMeas(db.companionValueToStr(shrubComp.measPlotSize)) != null
        ? results.add("Measured Area of Plot")
        : null;
    return results.isEmpty ? null : results;
  }

  String? _errorNom(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 0.0020 || double.parse(value) > 0.04) {
      return "Dbh must be between 0.0020 and 0.04ha";
    }
    return null;
  }

  String? _errorMeas(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 0.0005 || double.parse(value) > 0.04) {
      return "Dbh must be between 0.0005 and 0.04ha";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<ShrubListEntryData>> entryList =
        ref.watch(shrubEntryListProvider(shrubId));

    void updateShrubData(ShrubSummaryCompanion data) {
      (db.update(db.shrubSummary)..where((t) => t.id.equals(shrubId)))
          .write(data)
          .then((value) {
        setState(() {
          shrubComp = data;
        });
      });
    }

    void markComplete() async {
      void enterComplete() {
        updateShrubData(shrubComp.copyWith(complete: const d.Value(true)));
      }

      if (parentComplete) {
        Popups.show(context, popupSurveyComplete);
      } else if (shrubComp.complete.value) {
        updateShrubData(shrubComp.copyWith(complete: const d.Value(false)));
      } else {
        List<String>? errors = errorCheck();
        errors == null
            ? db.shrubPlotTablesDao.getShrubEntryList(shrubId).then(
                (value) {
                  if (value.isEmpty) {
                    Popups.show(
                        context,
                        PopupContinue(
                          "Warning: No entries entered",
                          contentText: "No entries have been recorded for "
                              "this plot. Pressing continue means you are "
                              "confirming that the survey was completed and "
                              "there were no entries to record.\n"
                              "Are you sure you want to continue?",
                          rightBtnOnPressed: () {
                            updateShrubData(shrubComp.copyWith(
                                complete: const d.Value(true)));
                            context.pop();
                          },
                        ));
                  } else {
                    updateShrubData(
                        shrubComp.copyWith(complete: const d.Value(true)));
                  }
                },
              )
            : Popups.show(context, PopupErrorsFoundList(errors: errors));
      }
    }

    return db.companionValueToStr(shrubComp.id).isEmpty
        ? DefaultPageLoadingScaffold(title: title)
        : Scaffold(
            appBar: OurAppBar(
              title,
              complete: shrubComp.complete.value,
              backFn: () {
                ref.refresh(updateSurveyCardProvider(surveyId));
                context.pop();
              },
            ),
            bottomNavigationBar: MarkCompleteButton(
                title: title,
                complete: shrubComp.complete.value,
                onPressed: () => markComplete()),
            endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
                child: ListView(
                  children: [
                    CalendarSelect(
                      date: shrubComp.measDate.value,
                      label: "Enter Measurement Date",
                      readOnly: shrubComp.complete.value,
                      onDateSelected: (DateTime date) => updateShrubData(
                          shrubComp.copyWith(measDate: d.Value(date))),
                    ),
                    ReferenceNameSelectBuilder(
                      name: db.referenceTablesDao.getShrubPlotTypeName(
                          db.companionValueToStr(shrubComp.plotType)),
                      asyncListFn: db.referenceTablesDao.getShrubPlotTypeList,
                      enabled: !shrubComp.complete.value,
                      onChange: (s) => db.referenceTablesDao
                          .getShrubPlotTypeCode(s)
                          .then((value) => updateShrubData(
                              shrubComp.copyWith(plotType: d.Value(value)))),
                    ),
                    DisableWidget(
                      disabled: shrubComp.complete.value,
                      child: HideInfoCheckbox(
                        title: "Nominal Plot Size",
                        titleWidget: "Unreported",
                        checkValue: shrubComp.nomPlotSize.value == -1,
                        onChange: (b) {
                          shrubComp.nomPlotSize.value == -1
                              ? updateShrubData(shrubComp.copyWith(
                                  nomPlotSize: const d.Value(null)))
                              : updateShrubData(shrubComp.copyWith(
                                  nomPlotSize: const d.Value(-1)));
                        },
                        child: DataInput(
                            boxLabel: "Report to the nearest 0.0001ha",
                            prefixIcon: FontAwesomeIcons.rulerCombined,
                            suffixVal: "ha",
                            inputType: const TextInputType.numberWithOptions(
                                decimal: true),
                            startingStr:
                                db.companionValueToStr(shrubComp.nomPlotSize),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              ThousandsFormatter(
                                  allowFraction: true,
                                  decimalPlaces: 6,
                                  maxDigitsBeforeDecimal: 1),
                            ],
                            paddingGeneral: const EdgeInsets.only(top: 0),
                            onSubmit: (s) {
                              s.isEmpty
                                  ? updateShrubData(shrubComp.copyWith(
                                      nomPlotSize: const d.Value(null)))
                                  : _errorNom(s) == null
                                      ? updateShrubData(shrubComp.copyWith(
                                          nomPlotSize:
                                              d.Value(double.parse(s))))
                                      : shrubComp = shrubComp.copyWith(
                                          nomPlotSize:
                                              d.Value(double.parse(s)));
                            },
                            onValidate: _errorNom),
                      ),
                    ),
                    DisableWidget(
                      disabled: shrubComp.complete.value,
                      child: DataInput(
                          title: "Measured Plot Size",
                          boxLabel: "Report to the nearest 0.0001ha",
                          prefixIcon: FontAwesomeIcons.chartArea,
                          suffixVal: "ha",
                          inputType: const TextInputType.numberWithOptions(
                              decimal: true),
                          startingStr:
                              db.companionValueToStr(shrubComp.measPlotSize),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            ThousandsFormatter(
                                allowFraction: true,
                                decimalPlaces: 6,
                                maxDigitsBeforeDecimal: 1),
                          ],
                          onSubmit: (s) {
                            s.isEmpty
                                ? updateShrubData(shrubComp.copyWith(
                                    measPlotSize: const d.Value(null)))
                                : _errorNom(s) == null
                                    ? updateShrubData(shrubComp.copyWith(
                                        measPlotSize: d.Value(double.parse(s))))
                                    : shrubComp = shrubComp.copyWith(
                                        measPlotSize: d.Value(double.parse(s)));
                          },
                          onValidate: _errorMeas),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Species",
                            style: TextStyle(fontSize: kTextTitleSize),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: kPaddingH),
                            child: ElevatedButton(
                                onPressed: () async {
                                  shrubComp.complete.value
                                      ? Popups.show(context, popupPageComplete)
                                      : context.pushNamed(
                                          ShrubPlotSpeciesEntryPage.routeName,
                                          pathParameters:
                                              widget.state.pathParameters,
                                          extra: ShrubListEntryCompanion(
                                              shrubSummaryId: shrubComp.id));
                                },
                                style: CustomButtonStyles.inactiveButton(
                                    isActive: !shrubComp.complete.value),
                                child: const Text("Add entry")),
                          ),
                        ],
                      ),
                    ),
                    entryList.when(
                        data: (entryList) {
                          DataGridSourceBuilder source =
                              getSourceBuilder(entryList);

                          return TableCreationBuilder(
                            source: source,
                            colNames: columnData.getColHeadersList(),
                            onCellTap: (DataGridCellTapDetails details) async {
                              // Assuming the "edit" column index is 2
                              if (details.column.columnName ==
                                      columnData.edit.name &&
                                  details.rowColumnIndex.rowIndex != 0) {
                                if (shrubComp.complete.value ||
                                    parentComplete) {
                                  Popups.show(context, popupPageComplete);
                                } else {
                                  int pId = source.dataGridRows[
                                          details.rowColumnIndex.rowIndex - 1]
                                      .getCells()[0]
                                      .value;

                                  db.shrubPlotTablesDao
                                      .getShrubSpeciesEntry(pId)
                                      .then((value) => context.pushNamed(
                                          ShrubPlotSpeciesEntryPage.routeName,
                                          pathParameters:
                                              widget.state.pathParameters,
                                          extra: value.toCompanion(true)));
                                }
                              }
                            },
                          );
                        },
                        error: (err, stack) => Text("Error: $err"),
                        loading: () =>
                            const Center(child: CircularProgressIndicator())),
                  ],
                ),
              ),
            ),
          );
  }
}
