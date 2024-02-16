import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/stump_plot/stump_plot_species_entry_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../formatters/thousands_formatter.dart';
import '../../providers/survey_info_providers.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/date_select.dart';
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
  late final int surveyId;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    super.initState();
  }

  List<DataGridRow> generateDataGridRows(List<String> plots) {
    return [
      DataGridRow(cells: [
        DataGridCell<String>(columnName: columnData.id.name, value: "tmp"),
        DataGridCell<String>(
            columnName: columnData.stumpNumber.name, value: "tmp"),
        DataGridCell<String>(
            columnName: columnData.originalPlotArea.name, value: "tmp"),
        DataGridCell<String>(columnName: columnData.genus.name, value: "tmp"),
        DataGridCell<String>(columnName: columnData.species.name, value: "tmp"),
        DataGridCell<String>(columnName: columnData.variety.name, value: "tmp"),
        DataGridCell<String>(
            columnName: columnData.topDiameterInsideBark.name, value: "tmp"),
        DataGridCell<String>(
            columnName: columnData.topDiameterIncludingBark.name, value: "tmp"),
        DataGridCell<String>(
            columnName: columnData.stumpLength.name, value: "tmp"),
        DataGridCell<String>(
            columnName: columnData.decayClass.name, value: "tmp"),
        DataGridCell<String>(columnName: columnData.edit.name, value: "edit"),
      ])
    ];
  }

  DataGridSourceBuilder getSourceBuilder(List<String> stations) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(stations));
    // source.sortedColumns.add(SortColumnDetails(
    //     name: columnData.stationNum.toString(),
    //     sortDirection: DataGridSortDirection.ascending));
    // source.sort();

    return source;
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
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Stump Plot",
        backFn: () {
          ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      bottomNavigationBar: MarkCompleteButton(
          title: "Stump Plot", complete: false, onPressed: () => null),
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
                readOnly: false,
                setStateFn: (DateTime date) async => (),
              ),
              ReferenceNameSelectBuilder(
                name: db.referenceTablesDao.getShrubPlotTypeName(""),
                asyncListFn: db.referenceTablesDao.getShrubPlotTypeList,
                enabled: true,
                onChange: (s) => db.referenceTablesDao
                    .getShrubStatusCode(s)
                    .then((value) => null),
              ),
              HideInfoCheckbox(
                title: "Nominal Plot Size",
                titleWidget: "Unreported",
                checkValue: false,
                onChange: (b) => -1,
                child: DataInput(
                    boxLabel: "Report to the nearest 0.0001ha",
                    prefixIcon: FontAwesomeIcons.rulerCombined,
                    suffixVal: "ha",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    startingStr: "",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      ThousandsFormatter(
                          allowFraction: true,
                          decimalPlaces: 6,
                          maxDigitsBeforeDecimal: 1),
                    ],
                    paddingGeneral: const EdgeInsets.only(top: 0),
                    onSubmit: (s) {},
                    onValidate: _errorNom),
              ),
              HideInfoCheckbox(
                title: "Measured Plot Size",
                titleWidget: "Unreported",
                checkValue: false,
                onChange: (b) => -1,
                child: DataInput(
                    boxLabel: "Report to the nearest 0.0001ha",
                    prefixIcon: FontAwesomeIcons.chartArea,
                    suffixVal: "ha",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    startingStr: "",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      ThousandsFormatter(
                          allowFraction: true,
                          decimalPlaces: 6,
                          maxDigitsBeforeDecimal: 1),
                    ],
                    paddingGeneral: const EdgeInsets.only(top: 0),
                    onSubmit: (s) {},
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
                          onPressed: () async => context.pushNamed(
                              StumpPlotSpeciesEntryPage.routeName,
                              pathParameters: widget.state.pathParameters),
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
              TableCreationBuilder(
                source: getSourceBuilder(["hi"]),
                colNames: columnData.getColHeadersList(),
                onCellTap: (DataGridCellTapDetails details) {},
                columnWidthMode: ColumnWidthMode.fitByColumnName,
              )
            ],
          ),
        ),
      ),
    );
  }
}
