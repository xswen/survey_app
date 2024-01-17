import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_treatment_entry_page.dart';
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

  @override
  void initState() {
    //spId = PathParamValue.getSoilPitSummary(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup("Large Tree Plot");
    //_loadData();
    super.initState();
  }

  List<DataGridRow> generateDataGridRows(List<LtpTreeData> treeList) {
    return treeList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<String>(columnName: columnData.type.name, value: ""),
              DataGridCell<int>(columnName: columnData.year.name, value: 0),
              DataGridCell<int>(columnName: columnData.extent.name, value: 0),
              DataGridCell<LtpTreeData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<LtpTreeData> treeList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(treeList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.type.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.year.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
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
                        onPressed: () async => false
                            ? Popups.show(context, completeWarningPopup)
                            : context.pushNamed(
                                GroundPlotTreatmentEntryPage.routeName,
                                pathParameters: widget.state.pathParameters),
                        style:
                            CustomButtonStyles.inactiveButton(isActive: !false),
                        child: const Text("Add tree")),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: TableCreationBuilder(
                  source: getSourceBuilder([]),
                  columnWidthMode: ColumnWidthMode.lastColumnFill,
                  colNames: columnData.getColHeadersList(),
                  onCellTap: (DataGridCellTapDetails details) async {
                    // Assuming the "edit" column index is 2
                    if (details.column.columnName == columnData.edit.name &&
                        details.rowColumnIndex.rowIndex != 0) {
                      // if (ssh.complete.value || parentComplete) {
                      //   Popups.show(context, popupPageComplete);
                      // } else {
                      //   int pId = source.dataGridRows[
                      //   details.rowColumnIndex.rowIndex - 1]
                      //       .getCells()[0]
                      //       .value;
                      //
                      //   db.surfaceSubstrateTablesDao
                      //       .getSsTallyFromId(pId)
                      //       .then((value) => context.pushNamed(
                      //       SurfaceSubstrateStationInfoPage
                      //           .routeName,
                      //       pathParameters:
                      //       PathParamGenerator.ssStationInfo(
                      //           widget.state,
                      //           value.stationNum.toString()),
                      //       extra: value.toCompanion(true)));
                      // }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
