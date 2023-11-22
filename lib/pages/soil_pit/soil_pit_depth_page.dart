import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';
import 'soil_pit_depth_entry_page.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders pitCode = ColumnHeaders("Soil Pit Code");
  ColumnHeaders depthMin = ColumnHeaders("Depth to Mineral Samples");
  ColumnHeaders depthOrg = ColumnHeaders("Depth to Organic Samples");
  ColumnHeaders comments = ColumnHeaders("Comment - to be added");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [pitCode, depthMin, depthOrg, comments, edit];
}

class SoilPitDepthPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitDepth";
  final GoRouterState state;
  const SoilPitDepthPage(this.state, {super.key});

  @override
  SoilPitDepthPageState createState() => SoilPitDepthPageState();
}

class SoilPitDepthPageState extends ConsumerState<SoilPitDepthPage> {
  final String title = "Soil Pit Depth";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late bool parentComplete = false;

  late final int spId;

  ColNames columnData = ColNames();

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummary(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);
    _loadData();
    super.initState();
  }

  void _loadData() async {
    final parent = await Database.instance.soilPitTablesDao.getSummary(spId);

    if (mounted) {
      setState(() {
        parentComplete = parent.complete;
      });
    }
  }

  List<DataGridRow> generateDataGridRows(List<SoilPitDepthData> data) => data
      .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
            DataGridCell<int>(
                columnName: columnData.id.name, value: dataGridRow.id),
            DataGridCell<String>(
                columnName: columnData.pitCode.name,
                value: dataGridRow.soilPitCodeCompiled),
            DataGridCell<double>(
                columnName: columnData.depthMin.name,
                value: dataGridRow.depthMin),
            DataGridCell<double>(
                columnName: columnData.depthOrg.name,
                value: dataGridRow.depthOrg),
            DataGridCell<String>(
                columnName: columnData.comments.name,
                value: "functionality to be added"),
            kEditColumnDataGridCell,
          ]))
      .toList();

  DataGridSourceBuilder getSourceBuilder(List<SoilPitDepthData> data) {
    DataGridSourceBuilder soilDepthDataSource =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(data));
    soilDepthDataSource.sortedColumns.add(SortColumnDetails(
        name: columnData.id.name,
        sortDirection: DataGridSortDirection.ascending));
    soilDepthDataSource.sort();

    return soilDepthDataSource;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<SoilPitDepthData>> depthList =
        ref.watch(soilDepthListProvider(spId));

    return Scaffold(
      appBar: OurAppBar(
        title,
        onLocaleChange: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Layers",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => parentComplete
                            ? Popups.show(context, completeWarningPopup)
                            : context.pushNamed(SoilPitDepthEntryPage.routeName,
                                pathParameters:
                                    PathParamGenerator.soilPitSummary(
                                        widget.state, spId.toString()),
                                extra: SoilPitDepthCompanion(
                                    soilPitSummaryId: d.Value(spId))),
                        style: CustomButtonStyles.inactiveButton(
                            isActive: !parentComplete),
                        child: const Text("Add layer")),
                  ),
                ],
              ),
            ),
            Expanded(
                child: depthList.when(
              data: (depthDataList) {
                DataGridSourceBuilder source = getSourceBuilder(depthDataList);

                return Center(
                  child: TableCreationBuilder(
                    source: source,
                    columnWidthMode: ColumnWidthMode.lastColumnFill,
                    colNames: columnData.getColHeadersList(),
                    onCellTap: (DataGridCellTapDetails details) async {
                      // Assuming the "edit" column index is 2
                      if (details.column.columnName == columnData.edit.name &&
                          details.rowColumnIndex.rowIndex != 0) {
                        if (parentComplete) {
                          Popups.show(context, surveyCompleteWarningPopup);
                        } else {
                          int id = source
                              .dataGridRows[details.rowColumnIndex.rowIndex - 1]
                              .getCells()[0]
                              .value;
                          db.soilPitTablesDao.getDepth(id).then((value) =>
                              context.pushNamed(SoilPitDepthEntryPage.routeName,
                                  pathParameters:
                                      PathParamGenerator.soilPitSummary(
                                          widget.state, spId.toString()),
                                  extra: value.toCompanion(true)));
                        }
                      }
                    },
                  ),
                );
              },
              error: (err, stack) => Text("Error: $err"),
              loading: () => const Center(child: CircularProgressIndicator()),
            )),
          ],
        ),
      ),
    );
  }
}
