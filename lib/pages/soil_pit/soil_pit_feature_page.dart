import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    d.Value.absent();
    return const Placeholder();
  }
}
