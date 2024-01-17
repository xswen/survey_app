import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_origin_entry_page.dart';
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
              DataGridCell<String>(
                  columnName: columnData.vegCover.name, value: ""),
              DataGridCell<String>(
                  columnName: columnData.regenType.name, value: ""),
              DataGridCell<int>(
                  columnName: columnData.regenYear.name, value: 0),
              DataGridCell<LtpTreeData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<LtpTreeData> treeList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(treeList));
    // source.sortedColumns.add(SortColumnDetails(
    //     name: columnData.sector.toString(),
    //     sortDirection: DataGridSortDirection.ascending));
    // source.sortedColumns.add(SortColumnDetails(
    //     name: columnData.treeNum.toString(),
    //     sortDirection: DataGridSortDirection.ascending));
    // source.sort();

    return source;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
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
                  Expanded(
                    child: const Text(
                      "Origins",
                      style: TextStyle(fontSize: kTextTitleSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => false
                            ? Popups.show(context, completeWarningPopup)
                            : context.pushNamed(
                                GroundPlotOriginEntryPage.routeName,
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
