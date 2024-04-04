import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/shrub_plot/shrub_plot_species_entry_page.dart';
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
            columnName: columnData.recordNumber.name, value: "tmp"),
        const DataGridCell<String>(columnName: 'genus', value: "tmp"),
        const DataGridCell<String>(columnName: 'species', value: "tmp"),
        const DataGridCell<String>(columnName: 'variety', value: "tmp"),
        const DataGridCell<String>(columnName: 'status', value: "tmp"),
        const DataGridCell<String>(columnName: 'bdClass', value: "tmp"),
        const DataGridCell<String>(columnName: 'frequency', value: "tmp"),
        DataGridCell<String>(
            columnName: columnData.edit.name,
            value: "edit"), // Assuming colNames is an instance of ColNames
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
        "Shrub Plot",
        backFn: () {
          ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      bottomNavigationBar: MarkCompleteButton(
          title: "Shrub Plot", complete: false, onPressed: () => null),
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
                onDateSelected: (DateTime date) async => (),
              ),
              ReferenceNameSelectBuilder(
                name: db.referenceTablesDao.getShrubPlotTypeName(""),
                asyncListFn: db.referenceTablesDao.getShrubPlotTypeList,
                enabled: true,
                onChange: (s) => db.referenceTablesDao
                    .getShrubPlotTypeCode(s)
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
                              ShrubPlotSpeciesEntryPage.routeName,
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
                  onCellTap: (DataGridCellTapDetails details) {})
            ],
          ),
        ),
      ),
    );
  }
}
