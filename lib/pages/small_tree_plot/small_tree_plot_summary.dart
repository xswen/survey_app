import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/tables/table_creation_builder.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/date_select.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

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
  final GoRouterState state;
  const SmallTreePlotSummaryPage(this.state, {super.key});

  @override
  SmallTreePlotSummaryPageState createState() =>
      SmallTreePlotSummaryPageState();
}

class SmallTreePlotSummaryPageState
    extends ConsumerState<SmallTreePlotSummaryPage> {
  final ColNames columnData = ColNames();

  List<DataGridRow> generateDataGridRows(List<String> plots) {
    return [
      DataGridRow(cells: [
        DataGridCell<String>(columnName: columnData.id.name, value: "tmp"),
        const DataGridCell<String>(columnName: 'smallTreeNumber', value: "tmp"),
        const DataGridCell<String>(
            columnName: 'originalPlotArea', value: "tmp"),
        const DataGridCell<String>(columnName: 'genus', value: "temp"),
        const DataGridCell<String>(columnName: 'species', value: "temp"),
        const DataGridCell<String>(columnName: 'variety', value: "temp"),
        const DataGridCell<String>(columnName: 'treeStatus', value: "temp"),
        const DataGridCell<String>(columnName: 'dbhCm', value: "temp"),
        const DataGridCell<String>(columnName: 'heightM', value: "temp"),
        const DataGridCell<String>(columnName: 'mOrEHt', value: "temp"),
        const DataGridCell<String>(columnName: 'stemCondition', value: "temp"),
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

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Small Tree Plot",
        backFn: () {
          //ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
        child: Column(
          children: [
            CalendarSelect(
              date: DateTime.now(),
              label: "Enter Measurement Date",
              readOnly: false,
              setStateFn: (DateTime date) async => (),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Plots",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => null,
                        style: ButtonStyle(
                            backgroundColor: false
                                ? MaterialStateProperty.all<Color>(Colors.grey)
                                : null),
                        child: const Text("Add plot")),
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
    );
  }
}
