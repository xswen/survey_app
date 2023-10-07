import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/widgets/tables/table_data_grid_source_builder.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../database/database.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/popups/popups.dart';
import '../../wrappers/column_header_object.dart';

class _ColNames {
  _ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders stationNum = ColumnHeaders("Station Num");
  ColumnHeaders type = ColumnHeaders("Type");
  ColumnHeaders depth = ColumnHeaders("Depth");
  ColumnHeaders depthLimit = ColumnHeaders("Depth Limit");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [stationNum, type, depth, depthLimit, edit];
}

class SurfaceSubstrateHeaderPage extends StatefulWidget {
  static const String routeName = "surfaceSubstrateHeader";
  static const String keySurfaceSubstrateHeaderCompanion =
      "surfaceSubstrateHeaderCompanion";
  static const String keySurfaceSubstrateTalliesData =
      "surfaceSubstrateTalliesData";
  static const String keySummaryComplete = "summaryComplete";

  const SurfaceSubstrateHeaderPage(
      {Key? key,
      required this.ssh,
      required this.stations,
      required this.summaryComplete})
      : super(key: key);
  final SurfaceSubstrateHeaderCompanion ssh;
  final List<SurfaceSubstrateTallyData> stations;
  final bool summaryComplete;

  @override
  State<SurfaceSubstrateHeaderPage> createState() =>
      _SurfaceSubstrateHeaderPageState();
}

class _SurfaceSubstrateHeaderPageState
    extends State<SurfaceSubstrateHeaderPage> {
  String title = "Surface Substrate Header";
  _ColNames columnData = _ColNames();
  late SurfaceSubstrateHeaderCompanion ssh;
  late List<SurfaceSubstrateTallyData> stations;
  late DataGridSourceBuilder tallyDataSource =
      DataGridSourceBuilder(dataGridRows: []);

  List<DataGridRow> generateDataGridRows(
          List<SurfaceSubstrateTallyData> stations) =>
      stations
          .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
                DataGridCell<int>(
                    columnName: columnData.id.name, value: dataGridRow.id),
                DataGridCell<int>(
                    columnName: columnData.stationNum.name,
                    value: dataGridRow.stationNum),
                DataGridCell<String>(
                    columnName: columnData.type.name,
                    value: dataGridRow.substrateType),
                DataGridCell<String>(
                    columnName: columnData.depth.name,
                    value: dataGridRow.depth?.toString() ?? ""),
                DataGridCell<String>(
                    columnName: columnData.depthLimit.name,
                    value: dataGridRow.depthLimit?.toString() ?? ""),
                DataGridCell<SurfaceSubstrateTallyData>(
                    columnName: columnData.edit.name, value: dataGridRow),
              ]))
          .toList();

  void updateStations() {
    final Database db = Database.instance;

    if (db.companionValueToStr(ssh.id).isEmpty) return;

    db.surfaceSubstrateTablesDao.getSsTallyList(ssh.id.value).then((value) {
      tallyDataSource =
          DataGridSourceBuilder(dataGridRows: generateDataGridRows(value));
      tallyDataSource.sortedColumns.add(SortColumnDetails(
          name: columnData.stationNum.toString(),
          sortDirection: DataGridSortDirection.ascending));
      tallyDataSource.sort();
      setState(() {});
    });
  }

  @override
  void initState() {
    ssh = widget.ssh;
    stations = widget.stations;
    updateStations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

    return Scaffold(
      appBar: OurAppBar("$title"),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
        child: Text("what"),
      ),
    );
  }
}
