import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../database/daos/large_tree_plot_tables_dao.dart';
import '../../providers/large_tree_plot_providers.dart';
import '../../providers/survey_info_providers.dart';
import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';
import 'large_tree_plot_tree_info_list_entry_page.dart';

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

  // Columns from LtpTreeDamage
  ColumnHeaders damageAgent = ColumnHeaders("Damage Agent");
  ColumnHeaders damageLocation = ColumnHeaders("Damage Location");
  ColumnHeaders severityPct = ColumnHeaders("Severity %");
  ColumnHeaders severity = ColumnHeaders("Severity");

  // Columns from LtpTreeRemoved
  ColumnHeaders reason = ColumnHeaders("Removal Reason");

  // Columns from LtpTreeRenamed
  ColumnHeaders treeNumPrev = ColumnHeaders("Previous Tree #");

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
        damageAgent,
        damageLocation,
        severityPct,
        severity,
        reason,
        treeNumPrev,
        edit,
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

  late final int surveyId;
  late final int ltpId;

  late bool parentComplete = false;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    ltpId = PathParamValue.getLtpSummaryId(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup("Large Tree Plot");

    _loadData();

    super.initState();
  }

  void _loadData() async {
    final ltp =
        await Database.instance.largeTreePlotTablesDao.getLtpSummary(ltpId);

    if (mounted) {
      setState(() {
        parentComplete = ltp.complete;
      });
    }
  }

  List<DataGridRow> generateDataGridRows(List<LtpMergedTreeEntry> treeList) {
    return treeList.asMap().entries.map<DataGridRow>((entry) {
      final index = entry.key;
      final dataGridRow = entry.value;
      final ltpTree = dataGridRow.ltpTree;
      final ltpTreeDamage = dataGridRow.ltpTreeDamage;
      final ltpTreeRemoved = dataGridRow.ltpTreeRemoved;
      final ltpTreeRenamed = dataGridRow.ltpTreeRenamed;

      return DataGridRow(cells: [
        DataGridCell<int>(columnName: columnData.id.name, value: index),
        DataGridCell<int>(
            columnName: columnData.sector.name, value: ltpTree.sector),
        DataGridCell<int>(
            columnName: columnData.treeNum.name, value: ltpTree.treeNum),
        DataGridCell<String>(
            columnName: columnData.origPlotArea.name,
            value: ltpTree.origPlotArea),
        DataGridCell<String>(
            columnName: columnData.lgTreeGenus.name,
            value: ltpTree.lgTreeGenus),
        DataGridCell<String>(
            columnName: columnData.lgTreeSpecies.name,
            value: ltpTree.lgTreeSpecies),
        DataGridCell<String>(
            columnName: columnData.lgTreeVariety.name,
            value: ltpTree.lgTreeVariety),
        DataGridCell<String>(
            columnName: columnData.lgTreeStatus.name,
            value: ltpTree.lgTreeStatus),
        DataGridCell<double>(
            columnName: columnData.dbh.name, value: ltpTree.dbh),
        DataGridCell<double>(
            columnName: columnData.height.name, value: ltpTree.height),
        DataGridCell<String>(
            columnName: columnData.crownClass.name, value: ltpTree.crownClass),
        DataGridCell<double>(
            columnName: columnData.crownBase.name, value: ltpTree.crownBase),
        DataGridCell<double>(
            columnName: columnData.crownTop.name, value: ltpTree.crownTop),
        DataGridCell<String>(
            columnName: columnData.stemCond.name, value: ltpTree.stemCond),
        DataGridCell<int>(
            columnName: columnData.crownCond.name, value: ltpTree.crownCond),
        DataGridCell<int>(
            columnName: columnData.barkRet.name, value: ltpTree.barkRet),
        DataGridCell<int>(
            columnName: columnData.woodCond.name, value: ltpTree.woodCond),
        DataGridCell<int>(
            columnName: columnData.azimuth.name, value: ltpTree.azimuth),
        DataGridCell<double>(
            columnName: columnData.distance.name, value: ltpTree.distance),

        // LtpTreeDamage columns
        DataGridCell<String>(
            columnName: columnData.damageAgent.name,
            value: ltpTreeDamage?.damageAgent),
        DataGridCell<String>(
            columnName: columnData.damageLocation.name,
            value: ltpTreeDamage?.damageLocation),
        DataGridCell<int>(
            columnName: columnData.severityPct.name,
            value: ltpTreeDamage?.severityPct),
        DataGridCell<String>(
            columnName: columnData.severity.name,
            value: ltpTreeDamage?.severity),

        // LtpTreeRemoved columns
        DataGridCell<String>(
            columnName: columnData.reason.name, value: ltpTreeRemoved?.reason),

        // LtpTreeRenamed columns
        DataGridCell<int>(
            columnName: columnData.treeNumPrev.name,
            value: ltpTreeRenamed?.treeNumPrev),

        DataGridCell<LtpMergedTreeEntry>(
            columnName: columnData.edit.name, value: dataGridRow),
      ]);
    }).toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<LtpMergedTreeEntry> treeList) {
    DataGridSourceBuilder source = DataGridSourceBuilder(
      dataGridRows: generateDataGridRows(treeList),
    );

    source.sortedColumns.add(SortColumnDetails(
      name: columnData.sector.name,
      sortDirection: DataGridSortDirection.ascending,
    ));
    source.sortedColumns.add(SortColumnDetails(
      name: columnData.treeNum.name,
      sortDirection: DataGridSortDirection.ascending,
    ));
    source.sort();

    return source;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    AsyncValue<List<LtpMergedTreeEntry>> entryList =
        ref.watch(ltpMergedTreeEntryListProvider(ltpId));

    return entryList.when(
      error: (err, stack) => Text("Error: $err"),
      loading: () =>
          const DefaultPageLoadingScaffold(title: "Large Tree - Tree List"),
      data: (entryListData) {
        DataGridSourceBuilder source = getSourceBuilder(entryListData);

        return Scaffold(
          appBar: OurAppBar(
            "Large Tree Plot",
            backFn: () {
              ref.refresh(updateSurveyCardProvider(surveyId));
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
                            onPressed: () async => parentComplete
                                ? Popups.show(context, completeWarningPopup)
                                : context.pushNamed(
                                    LargeTreePlotTreeInfoListEntryPage
                                        .routeName,
                                    pathParameters: widget.state.pathParameters,
                                    extra: null),
                            style: CustomButtonStyles.inactiveButton(
                                isActive: !parentComplete),
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
                          if (parentComplete) {
                            Popups.show(context, completeWarningPopup);
                          } else {
                            int idx = source.dataGridRows[
                                    details.rowColumnIndex.rowIndex - 1]
                                .getCells()[0]
                                .value;

                            LtpMergedTreeEntry entry = entryListData[
                                details.rowColumnIndex.rowIndex - 1];

                            context.pushNamed(
                                LargeTreePlotTreeInfoListEntryPage.routeName,
                                pathParameters: widget.state.pathParameters,
                                extra: entryListData[idx]);
                          }
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
