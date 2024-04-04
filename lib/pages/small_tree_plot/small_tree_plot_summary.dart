import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../formatters/thousands_formatter.dart';
import '../../providers/small_tree_plot_providers.dart';
import '../../providers/survey_info_providers.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/date_select.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';
import 'small_tree_species_entry_page.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders smallTreeNumber = ColumnHeaders("Small Tree Number");
  ColumnHeaders originalPlotArea = ColumnHeaders("Original Plot Area");
  ColumnHeaders genus = ColumnHeaders("Genus");
  ColumnHeaders species = ColumnHeaders("Species");
  ColumnHeaders variety = ColumnHeaders("Variety");
  ColumnHeaders treeStatus = ColumnHeaders("Tree Status");
  ColumnHeaders dbhCm = ColumnHeaders("DBH (cm)");
  ColumnHeaders heightM = ColumnHeaders("Height (m)");
  ColumnHeaders mOrEHt = ColumnHeaders("M or E Ht.");
  ColumnHeaders stemCondition = ColumnHeaders("Stem Condition");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [
        smallTreeNumber,
        originalPlotArea,
        genus,
        species,
        variety,
        treeStatus,
        dbhCm,
        heightM,
        mOrEHt,
        stemCondition,
        edit,
      ];
}

class SmallTreePlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "smallTreePlotSummary";
  static const String dataName = "dataKey";
  static const String listName = "listKey";

  final GoRouterState state;
  const SmallTreePlotSummaryPage(this.state, {super.key});

  @override
  SmallTreePlotSummaryPageState createState() =>
      SmallTreePlotSummaryPageState();
}

class SmallTreePlotSummaryPageState
    extends ConsumerState<SmallTreePlotSummaryPage> {
  final ColNames columnData = ColNames();
  final String title = "Small Tree Plot";
  late final int surveyId;
  late final int stpId;

  //Placeholder values
  bool parentComplete = false;
  StpSummaryCompanion stp = const StpSummaryCompanion();
  List<StpSpeciesData> stpSpeciesList = [];

  late final PopupDismiss popupPageComplete =
      Popups.generateCompleteErrorPopup(title);
  final PopupDismiss popupSurveyComplete =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    stpId = PathParamValue.getStpSummaryId(widget.state);

    _loadData();
    super.initState();
  }

  void _loadData() async {
    final value =
        await Database.instance.smallTreePlotTablesDao.getStpSummary(stpId);
    final survey =
        await Database.instance.surveyInfoTablesDao.getSurvey(surveyId);

    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        parentComplete = survey.complete;
        stp = value.toCompanion(true);
      });
    }
  }

  List<DataGridRow> generateDataGridRows(List<StpSpeciesData> speciesList) {
    return speciesList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: columnData.smallTreeNumber.name,
                  value: dataGridRow.treeNum),
              DataGridCell<String>(
                  columnName: columnData.originalPlotArea.name,
                  value: dataGridRow.origPlotArea),
              DataGridCell<String>(
                  columnName: columnData.genus.name, value: dataGridRow.genus),
              DataGridCell<String>(
                  columnName: columnData.species.name,
                  value: dataGridRow.species),
              DataGridCell<String>(
                  columnName: columnData.variety.name,
                  value: dataGridRow.variety),
              DataGridCell<String>(
                  columnName: columnData.treeStatus.name,
                  value: dataGridRow.status),
              DataGridCell<double>(
                  columnName: columnData.dbhCm.name, value: dataGridRow.dbh),
              DataGridCell<double>(
                  columnName: columnData.heightM.name,
                  value: dataGridRow.height),
              DataGridCell<String>(
                  columnName: columnData.mOrEHt.name,
                  value: dataGridRow.measHeight),
              DataGridCell<String>(
                  columnName: columnData.stemCondition.name,
                  value: dataGridRow.stemCondition),
              DataGridCell<StpSpeciesData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<StpSpeciesData> speciesList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(speciesList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.smallTreeNumber.name,
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  //Error Checks
  List<String>? errorCheck() {
    final db = ref.read(databaseProvider);
    List<String> results = [];
    if (db.companionValueToStr(stp.id).isEmpty) {
      return results = ["Error getting stp"];
    }

    db.companionValueToStr(stp.plotType).isEmpty
        ? results.add("Plot type")
        : null;

    _errorNom(db.companionValueToStr(stp.nomPlotSize)) != null
        ? results.add("Nominal Area of Plot")
        : null;
    _errorMeas(db.companionValueToStr(stp.measPlotSize)) != null
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
    final AsyncValue<List<StpSpeciesData>> speciesList =
        ref.watch(stpSpeciesListProvider(stpId));

    void updateStpData(StpSummaryCompanion data) {
      final db = ref.read(databaseProvider);

      (db.update(db.stpSummary)..where((t) => t.id.equals(stpId)))
          .write(data)
          .then((value) => setState(() => stp = data));
    }

    void updateStpCompanion(StpSummaryCompanion newStp) =>
        setState(() => stp = newStp);

    void markComplete() async {
      final db = Database.instance;

      void enterComplete() {
        updateStpData(stp.copyWith(complete: const d.Value(true)));
        ref.refresh(updateSurveyCardProvider(surveyId));
        context.pop();
      }

      if (parentComplete) {
        Popups.show(context, popupSurveyComplete);
      } else if (stp.complete.value) {
        updateStpData(stp.copyWith(complete: const d.Value(false)));
      } else {
        List<String>? errors = errorCheck();
        errors == null
            ? db.smallTreePlotTablesDao.getSpeciesList(stpId).then(
                (value) {
                  if (value.isEmpty) {
                    Popups.show(
                        context,
                        PopupContinue(
                          "Warning: No species entered",
                          contentText: "No species have been recorded for "
                              "this plot. Pressing continue means you are "
                              "confirming that the survey was completed and "
                              "there were no pieces to record.\n"
                              "Are you sure you want to continue?",
                          rightBtnOnPressed: () => enterComplete(),
                        ));
                  } else {
                    enterComplete();
                  }
                },
              )
            : Popups.show(context, PopupErrorsFoundList(errors: errors));
      }
    }

    return db.companionValueToStr(stp.id).isEmpty
        ? DefaultPageLoadingScaffold(title: title)
        : Scaffold(
            appBar: OurAppBar(
              title,
              backFn: () {
                ref.refresh(updateSurveyCardProvider(surveyId));
                context.pop();
              },
            ),
            bottomNavigationBar: MarkCompleteButton(
                title: "Small Tree Plot",
                complete: stp.complete.value,
                onPressed: () => markComplete()),
            endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
                child: ListView(
                  children: [
                    CalendarSelect(
                      date: stp.measDate.value,
                      label: "Enter Measurement Date",
                      readOnly: stp.complete.value,
                      onDateSelected: (DateTime date) {
                        updateStpData(stp.copyWith(measDate: d.Value(date)));
                      },
                    ),
                    ReferenceNameSelectBuilder(
                      name: db.referenceTablesDao
                          .getStpTypeName(db.companionValueToStr(stp.plotType)),
                      asyncListFn: db.referenceTablesDao.getStpTypeList,
                      enabled: !stp.complete.value,
                      onChange: (s) => db.referenceTablesDao
                          .getStpTypeCode(s)
                          .then((value) => updateStpData(
                              stp.copyWith(plotType: d.Value(value)))),
                    ),
                    HideInfoCheckbox(
                      title: "Nominal Plot Size",
                      titleWidget: "Unreported",
                      checkValue: stp.nomPlotSize.value == -1,
                      onChange: (b) {
                        stp.nomPlotSize.value == -1
                            ? updateStpData(
                                stp.copyWith(nomPlotSize: const d.Value(null)))
                            : updateStpData(
                                stp.copyWith(nomPlotSize: const d.Value(-1)));
                      },
                      child: DataInput(
                          boxLabel: "Report to the nearest 0.0001ha",
                          prefixIcon: FontAwesomeIcons.rulerCombined,
                          suffixVal: "ha",
                          inputType: const TextInputType.numberWithOptions(
                              decimal: true),
                          startingStr: db.companionValueToStr(stp.nomPlotSize),
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
                                ? updateStpData(stp.copyWith(
                                    nomPlotSize: const d.Value(null)))
                                : _errorNom(s) == null
                                    ? updateStpData(stp.copyWith(
                                        nomPlotSize: d.Value(double.parse(s))))
                                    : stp = stp.copyWith(
                                        nomPlotSize: d.Value(double.parse(s)));
                          },
                          onValidate: _errorNom),
                    ),
                    DataInput(
                        title: "Measured Plot Size",
                        boxLabel: "Report to the nearest 0.0001ha",
                        prefixIcon: FontAwesomeIcons.chartArea,
                        suffixVal: "ha",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        startingStr: db.companionValueToStr(stp.measPlotSize),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          ThousandsFormatter(
                              allowFraction: true,
                              decimalPlaces: 6,
                              maxDigitsBeforeDecimal: 1),
                        ],
                        onSubmit: (s) {
                          s.isEmpty
                              ? updateStpData(stp.copyWith(
                                  measPlotSize: const d.Value(null)))
                              : _errorNom(s) == null
                                  ? updateStpData(stp.copyWith(
                                      measPlotSize: d.Value(double.parse(s))))
                                  : stp = stp.copyWith(
                                      measPlotSize: d.Value(double.parse(s)));
                        },
                        onValidate: _errorMeas),
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
                                onPressed: () async => context.pushNamed(
                                    SmallTreeSpeciesEntryPage.routeName,
                                    pathParameters: widget.state.pathParameters,
                                    extra: StpSpeciesCompanion(
                                        stpSummaryId: stp.id)),
                                style: ButtonStyle(
                                    backgroundColor: false
                                        ? MaterialStateProperty.all<Color>(
                                            Colors.grey)
                                        : null),
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
                                if (stp.complete.value || parentComplete) {
                                  Popups.show(context, popupPageComplete);
                                } else {
                                  int pId = source.dataGridRows[
                                          details.rowColumnIndex.rowIndex - 1]
                                      .getCells()[0]
                                      .value;

                                  db.smallTreePlotTablesDao
                                      .getStpSpecies(pId)
                                      .then((value) => context.pushNamed(
                                          SmallTreeSpeciesEntryPage.routeName,
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
