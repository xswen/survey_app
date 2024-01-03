import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_info_list_entry_page.dart';
import 'package:survey_app/widgets/tables/table_creation_builder.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders sector = ColumnHeaders("Sector");
  ColumnHeaders treeNum = ColumnHeaders("Tree #");
  ColumnHeaders origPlotArea = ColumnHeaders("Original Plot Area");
  ColumnHeaders lgTreeGenus = ColumnHeaders("Genus");
  ColumnHeaders lgTreeSpecies = ColumnHeaders("Species");
  ColumnHeaders lgTreeVariety = ColumnHeaders("Variety");
  ColumnHeaders lgTreeStatus = ColumnHeaders("Status");
  ColumnHeaders dbh = ColumnHeaders("DBH");
  ColumnHeaders height = ColumnHeaders("Height");
  ColumnHeaders crownClass = ColumnHeaders("Crown Class");
  ColumnHeaders crownBase = ColumnHeaders("Crown Base");
  ColumnHeaders crownTop = ColumnHeaders("Crown Top");
  ColumnHeaders stemCond = ColumnHeaders("Stem Condition");
  ColumnHeaders crownCond = ColumnHeaders("Crown Condition");
  ColumnHeaders barkRet = ColumnHeaders("Bark Retention");
  ColumnHeaders woodCond = ColumnHeaders("Wood Condition");
  ColumnHeaders azimuth = ColumnHeaders("Azimuth");
  ColumnHeaders distance = ColumnHeaders("Distance");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [
        sector,
        treeNum,
        origPlotArea,
        lgTreeGenus,
        lgTreeSpecies,
        lgTreeVariety,
        lgTreeStatus,
        dbh,
        height,
        crownClass,
        crownBase,
        crownTop,
        stemCond,
        crownCond,
        barkRet,
        woodCond,
        azimuth,
        distance,
        edit
      ];
}

class LargeTreePlotTreeInfoListPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotTreeInfoList";
  final GoRouterState state;
  const LargeTreePlotTreeInfoListPage(this.state, {super.key});

  @override
  LargeTreePlotTreeInfoListPageState createState() =>
      LargeTreePlotTreeInfoListPageState();
}

class LargeTreePlotTreeInfoListPageState
    extends ConsumerState<LargeTreePlotTreeInfoListPage> {
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
              DataGridCell<int>(
                  columnName: columnData.sector.name,
                  value: dataGridRow.sector),
              DataGridCell<int>(
                  columnName: columnData.treeNum.name,
                  value: dataGridRow.treeNum),
              DataGridCell<String>(
                  columnName: columnData.origPlotArea.name,
                  value: dataGridRow.origPlotArea),
              DataGridCell<String>(
                  columnName: columnData.lgTreeGenus.name,
                  value: dataGridRow.lgTreeGenus),
              DataGridCell<String>(
                  columnName: columnData.lgTreeSpecies.name,
                  value: dataGridRow.lgTreeSpecies),
              DataGridCell<String>(
                  columnName: columnData.lgTreeVariety.name,
                  value: dataGridRow.lgTreeVariety),
              DataGridCell<String>(
                  columnName: columnData.lgTreeStatus.name,
                  value: dataGridRow.lgTreeStatus),
              DataGridCell<double>(
                  columnName: columnData.dbh.name, value: dataGridRow.dbh),
              DataGridCell<double>(
                  columnName: columnData.height.name,
                  value: dataGridRow.height),
              DataGridCell<String>(
                  columnName: columnData.crownClass.name,
                  value: dataGridRow.crownClass),
              DataGridCell<double>(
                  columnName: columnData.crownBase.name,
                  value: dataGridRow.crownBase),
              DataGridCell<double>(
                  columnName: columnData.crownTop.name,
                  value: dataGridRow.crownTop),
              DataGridCell<String>(
                  columnName: columnData.stemCond.name,
                  value: dataGridRow.stemCond),
              DataGridCell<int>(
                  columnName: columnData.crownCond.name,
                  value: dataGridRow.crownCond),
              DataGridCell<int>(
                  columnName: columnData.barkRet.name,
                  value: dataGridRow.barkRet),
              DataGridCell<int>(
                  columnName: columnData.woodCond.name,
                  value: dataGridRow.woodCond),
              DataGridCell<int>(
                  columnName: columnData.azimuth.name,
                  value: dataGridRow.azimuth),
              DataGridCell<double>(
                  columnName: columnData.distance.name,
                  value: dataGridRow.distance),
              DataGridCell<LtpTreeData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<LtpTreeData> treeList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(treeList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.sector.toString(),
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
        "Large Tree Plot",
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
                                LargeTreePlotInfoListEntryPage.routeName,
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
