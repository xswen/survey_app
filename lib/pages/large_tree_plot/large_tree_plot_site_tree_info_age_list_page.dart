import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_site_tree_info_age_list_entry_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();

  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders quadrant = ColumnHeaders("Quadrant");
  ColumnHeaders treeNum = ColumnHeaders("Tree #");
  ColumnHeaders siteType = ColumnHeaders("Site Type");
  ColumnHeaders boreDOB = ColumnHeaders("Bore DOB");
  ColumnHeaders boreHt = ColumnHeaders("Bore Height");
  ColumnHeaders suitHt = ColumnHeaders("Suit Height");
  ColumnHeaders suitAge = ColumnHeaders("Suit Age");
  ColumnHeaders fieldAge = ColumnHeaders("Age of Field");
  ColumnHeaders proCode = ColumnHeaders("Prorate Code");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [
        quadrant,
        treeNum,
        siteType,
        boreDOB,
        boreHt,
        suitHt,
        suitAge,
        fieldAge,
        proCode,
        edit
      ];
}

class LargeTreePlotSiteTreeInfoAgeListPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotSiteTreeInfoAgeList";
  final GoRouterState state;

  const LargeTreePlotSiteTreeInfoAgeListPage(this.state, {super.key});

  @override
  LargeTreePlotSiteTreeInfoAgeListPageState createState() =>
      LargeTreePlotSiteTreeInfoAgeListPageState();
}

class LargeTreePlotSiteTreeInfoAgeListPageState
    extends ConsumerState<LargeTreePlotSiteTreeInfoAgeListPage> {
  final ColNames columnData = ColNames();
  late final PopupDismiss completeWarningPopup;

  @override
  void initState() {
    //spId = PathParamValue.getSoilPitSummary(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup("Large Tree Plot");
    //_loadData();
    super.initState();
  }

  List<DataGridRow> generateDataGridRows(List<LtpTreeAgeData> treeList) {
    return treeList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: columnData.quadrant.name,
                  value: dataGridRow.quadrant),
              DataGridCell<int>(
                  columnName: columnData.treeNum.name,
                  value: dataGridRow.treeNum),
              DataGridCell<String>(
                  columnName: columnData.siteType.name,
                  value: dataGridRow.siteType),
              DataGridCell<double>(
                  columnName: columnData.boreDOB.name,
                  value: dataGridRow.boreDOB),
              DataGridCell<double>(
                  columnName: columnData.boreHt.name,
                  value: dataGridRow.boreHt),
              DataGridCell<String>(
                  columnName: columnData.suitHt.name,
                  value: dataGridRow.suitHt),
              DataGridCell<String>(
                  columnName: columnData.suitAge.name,
                  value: dataGridRow.suitAge),
              DataGridCell<int>(
                  columnName: columnData.fieldAge.name,
                  value: dataGridRow.fieldAge),
              DataGridCell<String>(
                  columnName: columnData.proCode.name,
                  value: dataGridRow.proCode),
              DataGridCell<LtpTreeAgeData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<LtpTreeAgeData> treeList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(treeList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.quadrant.toString(),
        sortDirection: DataGridSortDirection.ascending));
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
        "Large Tree Info Age",
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
                    "Large Trees",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => false
                            ? Popups.show(context, completeWarningPopup)
                            : context.pushNamed(
                                LargeTreePlotSiteTreeInfoAgeListEntryPage
                                    .routeName,
                                pathParameters: widget.state.pathParameters,
                                extra: null),
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
