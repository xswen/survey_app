import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_treatment_entry_page.dart';
import 'package:survey_app/providers/ground_plot_providers.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();

  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders type = ColumnHeaders("Type");
  ColumnHeaders year = ColumnHeaders("Treatment Year");
  ColumnHeaders extent = ColumnHeaders("Treatment Extent (%)");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [type, year, extent, edit];
}

class GroundPlotTreatmentPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotTreatment";
  final GoRouterState state;

  const GroundPlotTreatmentPage(this.state, {super.key});

  @override
  GroundPlotTreatmentPageState createState() => GroundPlotTreatmentPageState();
}

class GroundPlotTreatmentPageState
    extends ConsumerState<GroundPlotTreatmentPage> {
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

  List<DataGridRow> generateDataGridRows(List<GpTreatmentData> data) {
    return data
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: columnData.type.name,
                  value: dataGridRow.treatType),
              DataGridCell<int>(
                  columnName: columnData.year.name, value: dataGridRow.treatYr),
              DataGridCell<int>(
                  columnName: columnData.extent.name,
                  value: dataGridRow.treatPct),
              DataGridCell<GpTreatmentData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<GpTreatmentData> data) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(data));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.id.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  void goToEntryPage(GpTreatmentCompanion data) =>
      context.pushNamed(GroundPlotTreatmentEntryPage.routeName,
          pathParameters: widget.state.pathParameters, extra: data);

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<GpTreatmentData>> dataList =
        ref.watch(gpTreatmentListProvider(summaryId));

    return Scaffold(
      appBar: const OurAppBar("Plot Treatment/Activity"),
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
                  const Text(
                    "Treatment",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => parentComplete
                            ? Popups.show(context, completeWarningPopup)
                            : goToEntryPage(GpTreatmentCompanion(
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

                                db.siteInfoTablesDao.getGpTreatment(pId).then(
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
