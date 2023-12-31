import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_removed_list_entry_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders treeNum = ColumnHeaders("Tree #");
  ColumnHeaders reason = ColumnHeaders("Reason");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [treeNum, reason, edit];
}

class LargeTreePlotTreeRemovedListPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotTreeRemovedList";
  final GoRouterState state;
  const LargeTreePlotTreeRemovedListPage(this.state, {super.key});

  @override
  LargeTreePlotTreeRemovedListPageState createState() =>
      LargeTreePlotTreeRemovedListPageState();
}

class LargeTreePlotTreeRemovedListPageState
    extends ConsumerState<LargeTreePlotTreeRemovedListPage> {
  final ColNames columnData = ColNames();
  late final PopupDismiss completeWarningPopup;

  @override
  void initState() {
    //spId = PathParamValue.getSoilPitSummary(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup("Large Tree Plot");
    //_loadData();
    super.initState();
  }

  List<DataGridRow> generateDataGridRows(List<LtpTreeRemovedData> removedList) {
    return removedList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: columnData.reason.name,
                  value: dataGridRow.reason),
              DataGridCell<LtpTreeRemovedData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<LtpTreeRemovedData> removedList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(removedList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.treeNum.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Removed Trees",
        backFn: () {
          //ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
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
                    "Removed Trees List",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => false
                            ? null //Popups.show(context, completeWarningPopup)
                            : context.pushNamed(
                                LargeTreePlotTreeRemovedListEntryPage.routeName,
                                pathParameters: widget.state.pathParameters,
                                extra: null),
                        style:
                            CustomButtonStyles.inactiveButton(isActive: !false),
                        child: const Text("Add removed tree")),
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
