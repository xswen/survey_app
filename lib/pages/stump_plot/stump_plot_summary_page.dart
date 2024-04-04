import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/stump_plot/stump_plot_species_entry_page.dart';
import 'package:survey_app/providers/stump_plot_providers.dart';
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
  ColumnHeaders stumpNumber = ColumnHeaders("Stump Number");
  ColumnHeaders originalPlotArea = ColumnHeaders("Original Plot Area");
  ColumnHeaders genus = ColumnHeaders("Genus");
  ColumnHeaders species = ColumnHeaders("Species");
  ColumnHeaders variety = ColumnHeaders("Variety");
  ColumnHeaders topDiameterInsideBark =
      ColumnHeaders("Top Diameter Inside Bark");
  ColumnHeaders topDiameterIncludingBark =
      ColumnHeaders("Top Diameter Including Bark");
  ColumnHeaders stumpLength = ColumnHeaders("Stump Length");
  ColumnHeaders decayClass = ColumnHeaders("Decay Class");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [
        stumpNumber,
        originalPlotArea,
        genus,
        species,
        variety,
        topDiameterInsideBark,
        topDiameterIncludingBark,
        stumpLength,
        decayClass,
        edit,
      ];
}

class StumpPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "stumpPlotSummary";
  final GoRouterState state;
  const StumpPlotSummaryPage(this.state, {super.key});

  @override
  StumpPlotSummaryPageState createState() => StumpPlotSummaryPageState();
}

class StumpPlotSummaryPageState extends ConsumerState<StumpPlotSummaryPage> {
  final ColNames columnData = ColNames();
  final String title = "Sti,[ Plot";
  late final int surveyId;
  late final int stumpId;

  //Placeholder values
  bool parentComplete = false;
  StumpSummaryCompanion stump = const StumpSummaryCompanion();
  List<StumpEntryData> entryList = [];

  late final PopupDismiss popupPageComplete =
      Popups.generateCompleteErrorPopup(title);
  final PopupDismiss popupSurveyComplete =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    stumpId = PathParamValue.getStumpSummaryId(widget.state);

    _loadData();
    super.initState();
  }

  void _loadData() async {
    final value =
        await Database.instance.stumpPlotTablesDao.getStumpSummary(stumpId);
    final survey =
        await Database.instance.surveyInfoTablesDao.getSurvey(surveyId);

    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        parentComplete = survey.complete;
        stump = value.toCompanion(true);
      });
    }
  }

  List<DataGridRow> generateDataGridRows(List<StumpEntryData> stumpList) {
    return stumpList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: columnData.stumpNumber.name,
                  value: dataGridRow.stumpNum),
              DataGridCell<String>(
                  columnName: columnData.originalPlotArea.name,
                  value: dataGridRow.origPlotArea),
              DataGridCell<String>(
                  columnName: columnData.genus.name,
                  value: dataGridRow.stumpGenus),
              DataGridCell<String>(
                  columnName: columnData.species.name,
                  value: dataGridRow.stumpSpecies),
              DataGridCell<String>(
                  columnName: columnData.variety.name,
                  value: dataGridRow.stumpVariety),
              DataGridCell<double>(
                  columnName: columnData.topDiameterInsideBark.name,
                  value: dataGridRow.stumpDib),
              DataGridCell<double>(
                  columnName: columnData.topDiameterIncludingBark.name,
                  value: dataGridRow.stumpDiameter),
              DataGridCell<int>(
                  columnName: columnData.decayClass.name,
                  value: dataGridRow.stumpDecay),
              DataGridCell<double>(
                  columnName: columnData.stumpLength.name,
                  value: dataGridRow.stumpLength),
              DataGridCell<StumpEntryData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<StumpEntryData> stumpList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(stumpList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.stumpNumber.name,
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  //Error Checks
  List<String>? errorCheck() {
    final db = ref.read(databaseProvider);
    List<String> results = [];
    if (db.companionValueToStr(stump.id).isEmpty) {
      return results = ["Error getting stump"];
    }

    db.companionValueToStr(stump.plotType).isEmpty
        ? results.add("Plot type")
        : null;

    _errorNom(db.companionValueToStr(stump.nomPlotSize)) != null &&
            stump.nomPlotSize != const d.Value(-1.0)
        ? results.add("Nominal Area of Plot")
        : null;
    _errorMeas(db.companionValueToStr(stump.measPlotSize)) != null
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
    final AsyncValue<List<StumpEntryData>> speciesList =
        ref.watch(stumpEntryListProvider(stumpId));

    void updateData(StumpSummaryCompanion data) {
      final db = ref.read(databaseProvider);

      (db.update(db.stumpSummary)..where((t) => t.id.equals(stumpId)))
          .write(data)
          .then((value) => setState(() => stump = data));
    }

    void markComplete() async {
      final db = Database.instance;

      void enterComplete() {
        updateData(stump.copyWith(complete: const d.Value(true)));
      }

      if (parentComplete) {
        Popups.show(context, popupSurveyComplete);
      } else if (stump.complete.value) {
        updateData(stump.copyWith(complete: const d.Value(false)));
      } else {
        List<String>? errors = errorCheck();
        errors == null
            ? db.stumpPlotTablesDao.getStumpEntryList(stumpId).then(
                (value) {
                  if (value.isEmpty) {
                    Popups.show(
                        context,
                        PopupContinue(
                          "Warning: No entries entered",
                          contentText: "No entries have been recorded for "
                              "this plot. Pressing continue means you are "
                              "confirming that the survey was completed and "
                              "there were no pieces to record.\n"
                              "Are you sure you want to continue?",
                          rightBtnOnPressed: () {
                            enterComplete();
                            context.pop();
                          },
                        ));
                  } else {
                    enterComplete();
                  }
                },
              )
            : Popups.show(context, PopupErrorsFoundList(errors: errors));
      }
    }

    return db.companionValueToStr(stump.id).isEmpty
        ? DefaultPageLoadingScaffold(title: title)
        : Scaffold(
            appBar: OurAppBar(
              "Stump Plot",
              backFn: () {
                ref.refresh(updateSurveyCardProvider(surveyId));
                context.pop();
              },
            ),
            bottomNavigationBar: MarkCompleteButton(
                title: "Stump Plot",
                complete: stump.complete.value,
                onPressed: () => markComplete()),
            endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
                child: ListView(
                  children: [
                    CalendarSelect(
                      date: DateTime.now(),
                      label: "Enter Measurement Date",
                      readOnly: stump.complete.value,
                      onDateSelected: (DateTime date) =>
                          updateData(stump.copyWith(measDate: d.Value(date))),
                    ),
                    ReferenceNameSelectBuilder(
                      name: db.referenceTablesDao.getStumpPlotTypeName(
                          db.companionValueToStr(stump.plotType)),
                      asyncListFn: db.referenceTablesDao.getStumpPlotTypeList,
                      enabled: !stump.complete.value,
                      onChange: (s) => db.referenceTablesDao
                          .getStumpPlotTypeCode(s)
                          .then((value) => updateData(
                              stump.copyWith(plotType: d.Value(value)))),
                    ),
                    DisableWidget(
                      disabled: stump.complete.value,
                      child: HideInfoCheckbox(
                        title: "Nominal Plot Size",
                        titleWidget: "Unreported",
                        checkValue: stump.nomPlotSize.value == -1,
                        onChange: (b) {
                          stump.nomPlotSize.value == -1
                              ? updateData(stump.copyWith(
                                  nomPlotSize: const d.Value(null)))
                              : updateData(stump.copyWith(
                                  nomPlotSize: const d.Value(-1)));
                        },
                        child: DataInput(
                            boxLabel: "Report to the nearest 0.0001ha",
                            prefixIcon: FontAwesomeIcons.rulerCombined,
                            suffixVal: "ha",
                            inputType: const TextInputType.numberWithOptions(
                                decimal: true),
                            startingStr:
                                db.companionValueToStr(stump.nomPlotSize),
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
                                  ? updateData(stump.copyWith(
                                      nomPlotSize: const d.Value(null)))
                                  : _errorNom(s) == null
                                      ? updateData(stump.copyWith(
                                          nomPlotSize:
                                              d.Value(double.parse(s))))
                                      : stump = stump.copyWith(
                                          nomPlotSize:
                                              d.Value(double.parse(s)));
                            },
                            onValidate: _errorNom),
                      ),
                    ),
                    DisableWidget(
                      disabled: stump.complete.value,
                      child: DataInput(
                          title: "Measured Plot Size",
                          boxLabel: "Report to the nearest 0.0001ha",
                          prefixIcon: FontAwesomeIcons.chartArea,
                          suffixVal: "ha",
                          inputType: const TextInputType.numberWithOptions(
                              decimal: true),
                          startingStr:
                              db.companionValueToStr(stump.measPlotSize),
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
                                ? updateData(stump.copyWith(
                                    measPlotSize: const d.Value(null)))
                                : _errorNom(s) == null
                                    ? updateData(stump.copyWith(
                                        measPlotSize: d.Value(double.parse(s))))
                                    : stump = stump.copyWith(
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
                                  stump.complete.value
                                      ? Popups.show(context, popupPageComplete)
                                      : context.pushNamed(
                                          StumpPlotSpeciesEntryPage.routeName,
                                          pathParameters:
                                              widget.state.pathParameters,
                                          extra: StumpEntryCompanion(
                                              stumpSummaryId: stump.id));
                                },
                                style: CustomButtonStyles.inactiveButton(
                                    isActive: !stump.complete.value),
                                child: const Text("Add species")),
                          ),
                        ],
                      ),
                    ),
                    speciesList.when(
                        data: (speciesList) {
                          DataGridSourceBuilder source =
                              getSourceBuilder(speciesList);

                          return TableCreationBuilder(
                            source: source,
                            colNames: columnData.getColHeadersList(),
                            onCellTap: (DataGridCellTapDetails details) async {
                              // Assuming the "edit" column index is 2
                              if (details.column.columnName ==
                                      columnData.edit.name &&
                                  details.rowColumnIndex.rowIndex != 0) {
                                if (stump.complete.value || parentComplete) {
                                  Popups.show(context, popupPageComplete);
                                } else {
                                  int pId = source.dataGridRows[
                                          details.rowColumnIndex.rowIndex - 1]
                                      .getCells()[0]
                                      .value;

                                  db.stumpPlotTablesDao.getStumpEntry(pId).then(
                                      (value) => context.pushNamed(
                                          StumpPlotSpeciesEntryPage.routeName,
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
