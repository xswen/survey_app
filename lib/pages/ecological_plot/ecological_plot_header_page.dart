import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ecological_plot/ecological_plot_species_page.dart';
import 'package:survey_app/providers/ecological_plot_providers.dart';
import 'package:survey_app/widgets/buttons/custom_button_styles.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/ecp_plot_num_select_builder.dart';
import '../../widgets/builders/ecp_plot_type_select_builder.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../../widgets/popups/popup_marked_complete.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders speciesNum = ColumnHeaders("Species #");
  ColumnHeaders layerId = ColumnHeaders("Layer Id");
  ColumnHeaders genus = ColumnHeaders("Genus");
  ColumnHeaders species = ColumnHeaders("Species");
  ColumnHeaders variety = ColumnHeaders("Variety");
  ColumnHeaders speciesPct = ColumnHeaders("Species %");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [speciesNum, layerId, genus, species, variety, speciesPct, edit];
}

class EcologicalPlotHeaderPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotHeader";
  final GoRouterState state;
  const EcologicalPlotHeaderPage(this.state, {super.key});

  @override
  EcologicalPlotHeaderPageState createState() =>
      EcologicalPlotHeaderPageState();
}

class EcologicalPlotHeaderPageState
    extends ConsumerState<EcologicalPlotHeaderPage> {
  final String title = "Ecological Plot";
  late final PopupDismiss popupPageComplete =
      Popups.generateCompleteErrorPopup(title);
  final PopupDismiss popupSurveyComplete =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late bool parentComplete = false;
  late EcpHeaderCompanion ecpH = const EcpHeaderCompanion();
  late EcpHeaderData startingEcpH;

  late final int surveyId;
  late final int ecpId;
  late final int ecpHId;

  final ColNames columnData = ColNames();

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    ecpId = PathParamValue.getEcpSummaryId(widget.state);
    ecpHId = PathParamValue.getEcpHeaderId(widget.state);

    _loadData();
    super.initState();
  }

  void _loadData() async {
    final ecp =
        await Database.instance.ecologicalPlotTablesDao.getSummary(ecpId);
    final value =
        await Database.instance.ecologicalPlotTablesDao.getHeaderFromId(ecpHId);

    if (mounted) {
      setState(() {
        parentComplete = ecp.complete;
        startingEcpH = value;
        ecpH = value.toCompanion(true);
      });
    }
  }

  List<DataGridRow> generateDataGridRows(List<EcpSpeciesData> speciesList) {
    return speciesList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: columnData.speciesNum.name,
                  value: dataGridRow.speciesNum),
              DataGridCell<String>(
                  columnName: columnData.layerId.name,
                  value: dataGridRow.layerId),
              DataGridCell<String>(
                  columnName: columnData.genus.name, value: dataGridRow.genus),
              DataGridCell<String>(
                  columnName: columnData.species.name,
                  value: dataGridRow.species),
              DataGridCell<String>(
                  columnName: columnData.variety.name,
                  value: dataGridRow.variety),
              DataGridCell<double>(
                  columnName: columnData.speciesPct.name,
                  value: dataGridRow.speciesPct),
              DataGridCell<EcpSpeciesData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<EcpSpeciesData> speciesList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(speciesList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.speciesNum.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  void updateEcpHData(EcpHeaderCompanion ecpHC) {
    final db = ref.read(databaseProvider);
    (db.update(db.ecpHeader)..where((tbl) => tbl.id.equals(ecpHId)))
        .write(ecpHC)
        .then((value) => setState(() => ecpH = ecpHC));
  }

  void createNewSpeciesCompanion() => ref
          .read(databaseProvider)
          .ecologicalPlotTablesDao
          .getNextSpeciesNum(ecpHId)
          .then((speciesNum) {
        context.pushNamed(EcologicalPlotSpeciesPage.routeName,
            pathParameters: PathParamGenerator.ecpSpecies(
                widget.state, speciesNum.toString()),
            extra: EcpSpeciesCompanion(
              ecpHeaderId: d.Value(ecpHId),
              speciesNum: d.Value(speciesNum),
            ));
      });

  //Error Checks
  List<String>? errorCheck() {
    final db = ref.read(databaseProvider);
    List<String> results = [];

    ecpH.ecpNum == const d.Value.absent() ? results.add("Plot number") : null;

    errorNomPlotSize(db.companionValueToStr(ecpH.nomPlotSize)) != null
        ? results.add("Nominal Area of Plot")
        : null;
    errorMeasPlotSize(db.companionValueToStr(ecpH.measPlotSize)) != null
        ? results.add("Measured Area of Plot")
        : null;
    return results.isEmpty ? null : results;
  }

  String? errorNomPlotSize(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (0.000025 > double.parse(text!) || double.parse(text) > 1.0) {
      return "Input out of range. Must be between 0.000025 to 1.0 inclusive.";
    }
    return null;
  }

  String? errorMeasPlotSize(String? text) {
    double nomPlotSize = ecpH.nomPlotSize == const d.Value.absent()
        ? -1
        : ecpH.nomPlotSize.value ?? -1;

    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (0.000025 > double.parse(text!) || double.parse(text) > 1.0) {
      return "Input out of range. Must be between 0.000025 to 1.0 inclusive.";
    } else if (nomPlotSize < double.parse(text)) {
      return "Sample plot size cannot be larger than total ecp area size";
    }
    return null;
  }

  bool checkPlotNumExists() {
    if (ecpH.ecpNum == const d.Value.absent()) {
      Popups.show(
          context,
          const PopupDismiss(
            "Error: Missing Plot Number",
            contentText: "A plot number is required to change pages."
                "Please enter a plot number to move forward.",
          ));
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<EcpSpeciesData>> speciesList =
        ref.watch(ecpSpeciesListProvider(ecpHId));

    String fullTitle =
        "$title: ${db.companionValueToStr(ecpH.plotType)}${db.companionValueToStr(ecpH.ecpNum)}";

    void markComplete() async {
      final db = Database.instance;
      if (parentComplete) {
        Popups.show(context, popupSurveyComplete);
      } else if (ecpH.complete.value) {
        updateEcpHData(ecpH.copyWith(complete: const d.Value(false)));
      } else {
        List<String>? errors = errorCheck();
        errors == null
            ? db.ecologicalPlotTablesDao.getSpeciesList(ecpHId).then(
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
                          rightBtnOnPressed: () {
                            updateEcpHData(
                                ecpH.copyWith(complete: const d.Value(true)));
                            context.pop();
                            Popups.show(
                                context, PopupMarkedComplete(title: fullTitle));
                          },
                        ));
                  } else {
                    updateEcpHData(
                        ecpH.copyWith(complete: const d.Value(true)));
                    Popups.show(context, PopupMarkedComplete(title: fullTitle));
                  }
                },
              )
            : Popups.show(context, PopupErrorsFoundList(errors: errors));
      }
    }

    return db.companionValueToStr(ecpH.id).isEmpty
        ? Scaffold(
            appBar: OurAppBar(
              fullTitle,
            ),
            body: const Center(child: kLoadingWidget))
        : Scaffold(
            appBar: OurAppBar(
              fullTitle,
              complete: ecpH.complete.value,
              onLocaleChange: () {},
              backFn: () {
                if (checkPlotNumExists()) {
                  ref.refresh(ecpTransListProvider(ecpId));
                  context.pop();
                }
              },
            ),
            endDrawer: DrawerMenu(onLocaleChange: () {}),
            bottomNavigationBar: MarkCompleteButton(
                title: fullTitle,
                complete: ecpH.complete.value,
                onPressed: () => markComplete()),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
              child: Column(
                children: [
                  EcpPlotTypeSelectBuilder(
                      enabled: !ecpH.complete.value,
                      code: db.companionValueToStr(ecpH.plotType),
                      updatePlotType: (code) => setState(() => ecpH =
                          ecpH.copyWith(
                              plotType: d.Value(code),
                              ecpNum: const d.Value.absent()))),
                  EcpPlotNumSelectBuilder(
                      enabled: !ecpH.complete.value,
                      ecpSId: ecpH.ecpSummaryId.value,
                      startingPlotType: startingEcpH.plotType.toString(),
                      plotType: db.companionValueToStr(ecpH.plotType),
                      startingEcpNum: startingEcpH.ecpNum.toString(),
                      selectedEcpNum: db.companionValueToStr(ecpH.ecpNum),
                      updateEcpNum: (ecpNum) => updateEcpHData(
                          ecpH.copyWith(ecpNum: d.Value(ecpNum)))),
                  DataInput(
                    readOnly: ecpH.complete.value,
                    title: "The total area of ecological plot",
                    boxLabel: "Report to Dec 5.4 in hectares",
                    prefixIcon: FontAwesomeIcons.ruler,
                    suffixVal: "ha",
                    startingStr: db.companionValueToStr(ecpH.nomPlotSize),
                    onValidate: (s) => errorNomPlotSize(s) == "Can't be empty"
                        ? null
                        : errorNomPlotSize(s),
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                      ThousandsFormatter(allowFraction: true, decimalPlaces: 6),
                    ],
                    onSubmit: (s) {
                      s.isEmpty
                          ? updateEcpHData(
                              ecpH.copyWith(nomPlotSize: const d.Value(null)))
                          : errorNomPlotSize(s) == null
                              ? updateEcpHData(ecpH.copyWith(
                                  nomPlotSize: d.Value(double.parse(s))))
                              : ecpH = ecpH.copyWith(
                                  nomPlotSize: d.Value(double.parse(s)));
                    },
                  ),
                  DataInput(
                    readOnly: ecpH.complete.value,
                    title: "The measured area of the ecological sample plot",
                    boxLabel: "Report to Dec 5.4 in hectares",
                    prefixIcon: FontAwesomeIcons.ruler,
                    suffixVal: "ha",
                    startingStr: db.companionValueToStr(ecpH.measPlotSize),
                    onValidate: (s) => errorMeasPlotSize(s) == "Can't be empty"
                        ? null
                        : errorMeasPlotSize(s),
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                      ThousandsFormatter(allowFraction: true, decimalPlaces: 6),
                    ],
                    onSubmit: (s) {
                      s.isEmpty
                          ? updateEcpHData(
                              ecpH.copyWith(measPlotSize: const d.Value(null)))
                          : errorMeasPlotSize(s) == null
                              ? updateEcpHData(ecpH.copyWith(
                                  measPlotSize: d.Value(double.parse(s))))
                              : ecpH = ecpH.copyWith(
                                  measPlotSize: d.Value(double.parse(s)));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kPaddingH / 2,
                        right: kPaddingH / 2,
                        top: kPaddingV * 2,
                        bottom: kPaddingV),
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
                                if (checkPlotNumExists()) {
                                  ecpH.complete.value
                                      ? Popups.show(context, popupPageComplete)
                                      : createNewSpeciesCompanion();
                                }
                              },
                              style: CustomButtonStyles.inactiveButton(
                                  isActive: !ecpH.complete.value),
                              child: const Text("Add species")),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: speciesList.when(
                    data: (speciesList) {
                      DataGridSourceBuilder source =
                          getSourceBuilder(speciesList);

                      return Center(
                        child: TableCreationBuilder(
                          source: source,
                          columnWidthMode: ColumnWidthMode.lastColumnFill,
                          colNames: columnData.getColHeadersList(),
                          onCellTap: (DataGridCellTapDetails details) async {
                            // Assuming the "edit" column index is 2
                            if (details.column.columnName ==
                                    columnData.edit.name &&
                                details.rowColumnIndex.rowIndex != 0) {
                              if (ecpH.complete.value || parentComplete) {
                                Popups.show(context, popupPageComplete);
                              } else if (checkPlotNumExists()) {
                                int pId = source.dataGridRows[
                                        details.rowColumnIndex.rowIndex - 1]
                                    .getCells()[0]
                                    .value;

                                db.ecologicalPlotTablesDao
                                    .getSpeciesFromId(pId)
                                    .then((value) => context.pushNamed(
                                        EcologicalPlotSpeciesPage.routeName,
                                        pathParameters:
                                            PathParamGenerator.ecpSpecies(
                                                widget.state,
                                                value.speciesNum.toString()),
                                        extra: value.toCompanion(true)));
                              }
                            }
                          },
                        ),
                      );
                    },
                    error: (err, stack) => Text("Error: $err"),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  )),
                ],
              ),
            ),
          );
  }
}
