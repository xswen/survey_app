import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_origin_entry_page.dart';
import 'package:survey_app/providers/ground_plot_providers.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();

  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders vegCover = ColumnHeaders("Veg. cover origin");
  ColumnHeaders regenType = ColumnHeaders("Regeneration type");
  ColumnHeaders regenYear = ColumnHeaders("Regeneration year");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [vegCover, regenType, regenYear, edit];
}

class GroundPlotOriginPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotOrigin";
  final GoRouterState state;

  const GroundPlotOriginPage(this.state, {super.key});

  @override
  GroundPlotOriginPageState createState() => GroundPlotOriginPageState();
}

class GroundPlotOriginPageState extends ConsumerState<GroundPlotOriginPage> {
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

  List<DataGridRow> generateDataGridRows(List<GpOriginData> data) {
    return data
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: columnData.vegCover.name,
                  value: dataGridRow.vegOrig),
              DataGridCell<String>(
                  columnName: columnData.regenType.name,
                  value: dataGridRow.regenType),
              DataGridCell<int>(
                  columnName: columnData.regenYear.name,
                  value: dataGridRow.regenYr),
              DataGridCell<GpOriginData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<GpOriginData> data) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(data));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.id.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  void goToEntryPage(GpOriginCompanion data) =>
      context.pushNamed(GroundPlotOriginEntryPage.routeName,
          pathParameters: widget.state.pathParameters, extra: data);

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<GpOriginData>> dataList =
        ref.watch(gpOriginListProvider(summaryId));

    return Scaffold(
      appBar: const OurAppBar("Tree Cover Origin"),
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
                      "Origins",
                      style: TextStyle(fontSize: kTextTitleSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => parentComplete
                            ? Popups.show(context, completeWarningPopup)
                            : goToEntryPage(GpOriginCompanion(
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
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
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

                                db.siteInfoTablesDao.getGpOrigin(pId).then(
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
