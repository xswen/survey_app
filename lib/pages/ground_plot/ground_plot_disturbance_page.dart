import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_entry_page.dart';
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
                  columnName: columnData.agent.name, value: ""),
              DataGridCell<String>(columnName: columnData.year.name, value: ""),
              DataGridCell<int>(columnName: columnData.extent.name, value: 0),
              DataGridCell<int>(
                  columnName: columnData.treeMortality.name, value: 0),
              DataGridCell<String>(
                  columnName: columnData.mortalityBasis.name,
                  value: dataGridRow.lgTreeSpecies),
              DataGridCell<String>(
                  columnName: columnData.comments.name, value: ""),
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
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceAround,
                children: [
                  const Text(
                    "Natural Disturbance to the Plot Vegetation",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => false
                            ? Popups.show(context, completeWarningPopup)
                            : context.pushNamed(
                                GroundPlotDisturbanceEntryPage.routeName,
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
      // Center(
      //     child: Padding(
      //   padding: const EdgeInsets.symmetric(
      //       vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
      //   child: ElevatedButton(
      //     child: const Text("tmp"),
      //     onPressed: () {
      //       context.pushNamed(GroundPlotDisturbanceEntryPage.routeName,
      //           pathParameters: widget.state.pathParameters);
      //     },
      //   ),
      // )),
    );
  }
}
