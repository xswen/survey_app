import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_feature_entry_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders pitCode = ColumnHeaders("Soil Pit Code");
  ColumnHeaders feature = ColumnHeaders("Soil Feature");
  ColumnHeaders depthFeature = ColumnHeaders("Depth to Soil Feature");
  ColumnHeaders comments = ColumnHeaders("Comment - to be added");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [pitCode, feature, depthFeature, comments, edit];
}

class SoilPitFeaturePage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitFeature";
  final GoRouterState state;
  const SoilPitFeaturePage(this.state, {super.key});

  @override
  SoilPitFeaturePageState createState() => SoilPitFeaturePageState();
}

class SoilPitFeaturePageState extends ConsumerState<SoilPitFeaturePage> {
  final String title = "Soil Pit Feature";
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

  List<DataGridRow> generateDataGridRows(List<SoilPitFeatureData> data) => data
      .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
            DataGridCell<int>(
                columnName: columnData.id.name, value: dataGridRow.id),
            DataGridCell<String>(
                columnName: columnData.pitCode.name,
                value: dataGridRow.soilPitCodeField),
            DataGridCell<String>(
                columnName: columnData.feature.name,
                value: dataGridRow.soilPitSoilFeature),
            DataGridCell<int>(
                columnName: columnData.depthFeature.name,
                value: dataGridRow.depthFeature),
            DataGridCell<String>(
                columnName: columnData.comments.name,
                value: "functionality to be added"),
            kEditColumnDataGridCell,
          ]))
      .toList();

  DataGridSourceBuilder getSourceBuilder(List<SoilPitFeatureData> data) {
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
    final AsyncValue<List<SoilPitFeatureData>> featureList =
        ref.watch(soilFeatureListProvider(spId));

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
                    "Depths",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => parentComplete
                            ? Popups.show(context, completeWarningPopup)
                            : context.pushNamed(
                                SoilPitFeatureEntryPage.routeName,
                                pathParameters:
                                    PathParamGenerator.soilPitSummary(
                                        widget.state, spId.toString()),
                                extra: SoilPitFeatureCompanion(
                                    soilPitSummaryId: d.Value(spId))),
                        style: CustomButtonStyles.inactiveButton(
                            isActive: !parentComplete),
                        child: const Text("Add depth")),
                  ),
                ],
              ),
            ),
            Expanded(
                child: featureList.when(
              data: (dataList) {
                DataGridSourceBuilder source = getSourceBuilder(dataList);

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
                          db.soilPitTablesDao.getFeature(id).then((value) =>
                              context.pushNamed(
                                  SoilPitFeatureEntryPage.routeName,
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
