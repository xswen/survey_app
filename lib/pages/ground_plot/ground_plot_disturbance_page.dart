import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_entry_page.dart';
import 'package:survey_app/providers/ground_plot_providers.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();

  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders agent = ColumnHeaders("Disturbance Agent");
  ColumnHeaders year = ColumnHeaders("Disturbance Year");
  ColumnHeaders extent = ColumnHeaders("Disturbance Extent");
  ColumnHeaders treeMortality = ColumnHeaders("Tree Mortality");
  ColumnHeaders mortalityBasis = ColumnHeaders("Mortality Basis");
  ColumnHeaders comments = ColumnHeaders("Specific Disturbance Comments");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [agent, year, extent, treeMortality, mortalityBasis, comments, edit];
}

class GroundPlotDisturbancePage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotDisturbance";
  final GoRouterState state;

  const GroundPlotDisturbancePage(this.state, {super.key});

  @override
  GroundPlotDisturbancePageState createState() =>
      GroundPlotDisturbancePageState();
}

class GroundPlotDisturbancePageState
    extends ConsumerState<GroundPlotDisturbancePage> {
  final ColNames columnData = ColNames();
  late final PopupDismiss completeWarningPopup;
  late bool parentComplete = false;
  late final int surveyId;
  late final int summaryId;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    summaryId = PathParamValue.getGpSummaryId(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup("Ground plot");
    _loadData();
    super.initState();
  }

  void _loadData() async {
    final GpSummaryData data = await Database.instance.siteInfoTablesDao
        .getGpSummaryBySurveyId(surveyId);

    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        parentComplete = data.complete;
      });
    }
  }

  List<DataGridRow> generateDataGridRows(
      List<GpDisturbanceData> distAgentList) {
    return distAgentList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: columnData.agent.name,
                  value: dataGridRow.distAgent),
              DataGridCell<int>(
                  columnName: columnData.year.name, value: dataGridRow.distYr),
              DataGridCell<int>(
                  columnName: columnData.extent.name,
                  value: dataGridRow.distPct),
              DataGridCell<int>(
                  columnName: columnData.treeMortality.name,
                  value: dataGridRow.mortPct),
              DataGridCell<String>(
                  columnName: columnData.mortalityBasis.name,
                  value: dataGridRow.mortBasis),
              DataGridCell<String>(
                  columnName: columnData.comments.name,
                  value: dataGridRow.agentType),
              DataGridCell<GpDisturbanceData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(
      List<GpDisturbanceData> distAgentList) {
    DataGridSourceBuilder source = DataGridSourceBuilder(
        dataGridRows: generateDataGridRows(distAgentList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.id.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  void goToEntryPage(GpDisturbanceCompanion data) =>
      context.pushNamed(GroundPlotDisturbanceEntryPage.routeName,
          pathParameters: widget.state.pathParameters, extra: data);

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<GpDisturbanceData>> dataList =
        ref.watch(gpDistDataListProvider(summaryId));

    return Scaffold(
      appBar: const OurAppBar("Disturbances"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Natural Disturbance to the Plot Vegetation",
                      style: TextStyle(fontSize: kTextTitleSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => parentComplete
                            ? Popups.show(context, completeWarningPopup)
                            : goToEntryPage(GpDisturbanceCompanion(
                                gpSummaryId: d.Value(summaryId))),
                        style:
                            CustomButtonStyles.inactiveButton(isActive: !false),
                        child: const Text("Add tree")),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: dataList.when(
                    data: (dataList) {
                      DataGridSourceBuilder source = getSourceBuilder(dataList);
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
                              if (parentComplete) {
                                Popups.show(context, completeWarningPopup);
                              } else {
                                int pId = source.dataGridRows[
                                        details.rowColumnIndex.rowIndex - 1]
                                    .getCells()[0]
                                    .value;

                                db.siteInfoTablesDao.getGpDisturbance(pId).then(
                                    (value) =>
                                        goToEntryPage(value.toCompanion(true)));
                              }
                            }
                          },
                        ),
                      );
                    },
                    error: (err, stack) => Text("Error: $err"),
                    loading: () =>
                        const Center(child: CircularProgressIndicator())),
              ),
            )
          ],
        ),
      )),
    );
  }
}
