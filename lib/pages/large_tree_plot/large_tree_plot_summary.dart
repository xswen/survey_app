import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
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

class LargeTreePlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotSummary";
  final GoRouterState state;
  const LargeTreePlotSummaryPage(this.state, {super.key});

  @override
  LargeTreePlotSummaryPageState createState() =>
      LargeTreePlotSummaryPageState();
}

class LargeTreePlotSummaryPageState
    extends ConsumerState<LargeTreePlotSummaryPage> {
  final ColNames columnData = ColNames();

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
          child: ListView(
            children: [
              DropDownDefault(
                  title: "Plot type",
                  onChangedFn: (s) {},
                  itemsList: [],
                  selectedItem: "Please select plot type"),
              DataInput(
                  title: "Nominal plot Size",
                  onSubmit: (s) {},
                  onValidate: (s) {}),
              DataInput(
                  title: "Measured plot Size",
                  onSubmit: (s) {},
                  onValidate: (s) {}),
              DropDownDefault(
                  title: "Plot split",
                  onChangedFn: (s) {},
                  itemsList: [],
                  selectedItem: "Please select plot split"),
              const SizedBox(height: kPaddingV),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.tree),
                space: kPaddingIcon,
                label: "Tree Information",
                onPressed: () {
                  // navToSiteInfo();
                },
                padding: const EdgeInsets.symmetric(vertical: kPaddingV),
              ),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                space: kPaddingIcon,
                label: "Removed Trees",
                onPressed: () {
                  // navToSiteInfo();
                },
                padding: const EdgeInsets.symmetric(vertical: kPaddingV),
              ),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.info),
                space: kPaddingIcon,
                label: "Site Tree and Age Information",
                onPressed: () {
                  // navToSiteInfo();
                },
                padding: const EdgeInsets.symmetric(vertical: kPaddingV),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
