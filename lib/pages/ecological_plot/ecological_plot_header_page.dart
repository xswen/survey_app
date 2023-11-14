import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ecological_plot/ecological_plot_species_page.dart';
import 'package:survey_app/providers/ecological_plot_providers.dart';
import 'package:survey_app/widgets/buttons/custom_button_styles.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/set_transect_num_builder.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
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

  void markComplete() async {
    final db = Database.instance;
    if (parentComplete) {
      Popups.show(context, popupSurveyComplete);
    } else if (ecpH.complete.value) {
      updateEcpHData(ecpH.copyWith(complete: const d.Value(false)));
    } else {
      List<String>? errors = errorCheck();
      errors == null
          ? updateEcpHData(ecpH.copyWith(complete: const d.Value(true)))
          : Popups.show(context, PopupErrorsFoundList(errors: errors));
    }
  }

  //Error Checks
  List<String>? errorCheck() {
    final db = ref.read(databaseProvider);
    List<String> results = [];
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
    } else if (0.000025 > double.parse(text!) || double.parse(text!) > 1.0) {
      return "Input out of range. Must be between 0.000025 to 1.0 inclusive.";
    }
    return null;
  }

  String? errorMeasPlotSize(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (0.000025 > double.parse(text!) || double.parse(text!) > 1.0) {
      return "Input out of range. Must be between 0.000025 to 1.0 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<EcpSpeciesData>> speciesList =
        ref.watch(ecpSpeciesListProvider(ecpHId));

    return db.companionValueToStr(ecpH.id).isEmpty
        ? Scaffold(
            appBar: OurAppBar(
              "$title: Transect ${db.companionValueToStr(ecpH.ecpNum)}",
            ),
            body: const Center(child: kLoadingWidget))
        : Scaffold(
            appBar: OurAppBar(
              "$title: Transect ${db.companionValueToStr(ecpH.ecpNum)}",
              onLocaleChange: () {},
              backFn: () {
                ref.refresh(ecpTransListProvider(ecpId));
                context.pop();
              },
            ),
            floatingActionButton: FloatingCompleteButton(
              title: "Surface Substrate",
              complete: db.companionValueToStr(ecpH.complete).isEmpty
                  ? false
                  : ecpH.complete.value,
              onPressed: () => markComplete(),
            ),
            endDrawer: DrawerMenu(onLocaleChange: () {}),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
              child: Column(
                children: [
                  SetTransectNumBuilder(
                    getUsedTransNums:
                        db.ecologicalPlotTablesDao.getUsedTransNums(ecpId),
                    startingTransNum: db.companionValueToStr(ecpH.ecpNum),
                    selectedItem: db.companionValueToStr(ecpH.ecpNum).isEmpty
                        ? "Please select transect number"
                        : db.companionValueToStr(ecpH.ecpNum),
                    transList: kTransectNumsList,
                    updateTransNum: (int ecpNum) =>
                        updateEcpHData(ecpH.copyWith(ecpNum: d.Value(ecpNum))),
                    onBeforePopup: (s) async {
                      if (ecpH.complete.value) {
                        Popups.show(context, popupPageComplete);
                        return false;
                      }
                      return true;
                    },
                  ),
                  DataInput(
                    readOnly: ecpH.complete.value,
                    title: "The nominal area of the ecological Sample Plot",
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: kPaddingH / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Layers",
                          style: TextStyle(fontSize: kTextTitleSize),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: kPaddingH),
                          child: ElevatedButton(
                              onPressed: () async => ecpH.complete.value
                                  ? Popups.show(context, popupPageComplete)
                                  : createNewSpeciesCompanion(),
                              style: CustomButtonStyles.inactiveButton(
                                  isActive: !ecpH.complete.value),
                              child: const Text("Add layer")),
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
                              } else {
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
