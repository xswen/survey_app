import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../database/database.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_content_format.dart';
import '../../widgets/popups/popup_dismiss_dep.dart';

class _ColNames {
  static String id = "id";
  static String station = "stationNum";
  static String type = "type";
  static String depth = "depth";
  static String depthLimit = "depthLimit";
  static String edit = "edit";

  static String empty = "-";
}

class _TallyDataSource extends DataGridSource {
  _TallyDataSource({required List<SurfaceSubstrateTallyData> stations}) {
    dataGridRows = stations
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: _ColNames.id, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: _ColNames.station, value: dataGridRow.stationNum),
              DataGridCell<String>(
                  columnName: _ColNames.type, value: dataGridRow.substrateType),
              DataGridCell<String>(
                  columnName: _ColNames.depth,
                  value: Global.nullableToStr(dataGridRow.depth)),
              DataGridCell<String>(
                  columnName: _ColNames.depthLimit,
                  value: Global.nullableToStr(dataGridRow.depthLimit)),
              DataGridCell<SurfaceSubstrateTallyData>(
                  columnName: _ColNames.edit, value: dataGridRow),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    //skip Id. Id is only here for referencing
    DataGridRow newRow = DataGridRow(cells: row.getCells().sublist(1));
    return DataGridRowAdapter(
        cells: newRow.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id')
              ? Alignment.centerRight
              : Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: (dataGridCell.columnName == "edit")
              ? const Icon(FontAwesomeIcons.penToSquare)
              : Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.visible,
                ));
    }).toList());
  }
}

class SurfaceSubstrateHeaderPage extends StatefulWidget {
  const SurfaceSubstrateHeaderPage({Key? key}) : super(key: key);

  @override
  State<SurfaceSubstrateHeaderPage> createState() =>
      _SurfaceSubstrateHeaderPageState();
}

class _SurfaceSubstrateHeaderPageState extends State<SurfaceSubstrateHeaderPage>
    with Global {
  final _db = Get.find<Database>();

  SurfaceSubstrateHeaderCompanion ssh = Get.arguments["ssc"];
  bool summaryComplete = Get.arguments["summaryComplete"];

  late _TallyDataSource tallyDs = _TallyDataSource(stations: []);

  final PopupDismissDep _completeWarningPopup =
      Global.generateCompleteErrorPopup("Transect");
  final PopupDismissDep _prevPageCompleteWarning =
      Global.generatePreviousMarkedCompleteErrorPopup("Surface Substrate");

  //remove id columns
  late final List<String> _tallyColumnNames;

  @override
  void initState() {
    updateTallyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar("Surface Substrate: Transect ${ssh.transNum}"),
      floatingActionButton: FloatingCompleteButton(
        title: "Surface Substrate",
        complete: ssh.complete.value,
        onPressed: () {
          if (summaryComplete) {
            Get.dialog(_prevPageCompleteWarning);
          } else {
            String? errorMsg = _errorCheck();
            if (ssh.complete.value || errorMsg == null) {
              ssh = ssh.copyWith(complete: d.Value(!ssh.complete.value));
              _updateSsData(ssh);
              setState(() {});
            } else {
              Get.dialog(PopupDismissDep(
                title: "Error were found in the following places",
                contentWidget: PopupContentFormat(
                  titles: const [""],
                  details: [errorMsg],
                ),
              ));
            }
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        child: Center(
          child: Column(
            children: <Widget>[
              DataInput(
                  readOnly: ssh.complete.value,
                  onTap: () {
                    ssh.complete.value
                        ? Get.dialog(_completeWarningPopup)
                        : null;
                  },
                  title: "The measured length of the sample transect.",
                  boxLabel: "Report to the nearest 0.1cm",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "cm",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: Global.dbCompanionValueToStr(ssh.nomTransLen),
                  errorMsg: _errorNomTransLen(
                      Global.dbCompanionValueToStr(ssh.nomTransLen)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                  ],
                  onSubmit: (String s) {
                    double.tryParse(s) != null
                        ? ssh =
                            ssh.copyWith(nomTransLen: d.Value(double.parse(s)))
                        : ssh =
                            ssh.copyWith(nomTransLen: const d.Value.absent());
                    _errorNomTransLen(s) == null && double.tryParse(s) != null
                        ? _updateSsData(SurfaceSubstrateHeaderCompanion(
                            nomTransLen: d.Value(double.parse(s))))
                        : null;
                    setState(() {});
                  }),
              DataInput(
                  readOnly: ssh.complete.value,
                  onTap: () {
                    ssh.complete.value
                        ? Get.dialog(_completeWarningPopup)
                        : null;
                  },
                  title: "Transect azimuth.",
                  boxLabel: "Report in degrees",
                  prefixIcon: FontAwesomeIcons.angleLeft,
                  suffixVal: "\u00B0",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: false),
                  startingStr: Global.dbCompanionValueToStr(ssh.transAzimuth),
                  errorMsg: _errorTransAzim(
                      Global.dbCompanionValueToStr(ssh.transAzimuth)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    ThousandsFormatter(allowFraction: false),
                  ],
                  onSubmit: (String s) {
                    int.tryParse(s) != null
                        ? ssh =
                            ssh.copyWith(transAzimuth: d.Value(int.parse(s)))
                        : ssh =
                            ssh.copyWith(transAzimuth: const d.Value.absent());
                    _errorTransAzim(s) == null && int.tryParse(s) != null
                        ? _updateSsData(SurfaceSubstrateHeaderCompanion(
                            transAzimuth: d.Value(int.parse(s))))
                        : null;
                    setState(() {});
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Stations",
                    style: kTitleStyle,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        ssh.complete.value
                            ? Get.dialog(_completeWarningPopup)
                            : _editTallyData(null);
                      },
                      style: ButtonStyle(
                          backgroundColor: ssh.complete.value
                              ? MaterialStateProperty.all<Color>(Colors.grey)
                              : null),
                      child: const Text("Add station")),
                ],
              ),
              Expanded(
                child: SfDataGrid(
                  source: tallyDs,
                  allowSorting: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: _ColNames.station,
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Station Num',
                              overflow: TextOverflow.visible,
                            )),
                        allowSorting: true),
                    GridColumn(
                        columnName: _ColNames.type,
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Substrate Type',
                              overflow: TextOverflow.visible,
                            )),
                        allowSorting: true),
                    GridColumn(
                        columnName: _ColNames.depth,
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Depth',
                              overflow: TextOverflow.visible,
                            )),
                        allowSorting: true),
                    GridColumn(
                        columnName: _ColNames.depthLimit,
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Species',
                              overflow: TextOverflow.visible,
                            )),
                        allowSorting: true),
                    GridColumn(
                        columnName: _ColNames.edit,
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Edit',
                              overflow: TextOverflow.visible,
                            )),
                        allowSorting: false),
                  ],
                  onCellTap: (DataGridCellTapDetails details) async {
                    // Assuming the "edit" column index is 2
                    if (details.column.columnName == "edit" &&
                        details.rowColumnIndex.rowIndex != 0) {
                      if (summaryComplete || ssh.complete.value) {
                        Get.dialog(_completeWarningPopup);
                      } else {
                        int pId = tallyDs
                            .dataGridRows[details.rowColumnIndex.rowIndex - 1]
                            .getCells()[0]
                            .value;
                        _editTallyData(pId);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editTallyData(int? pId) async {
    SurfaceSubstrateTallyCompanion tallyData;

    if (pId != null) {
      tallyData = (await _db.surfaceSubstrateTablesDao.getSsTallyFromId(pId))!
          .toCompanion(true);
    } else {
      int stationNum =
          await _db.surfaceSubstrateTablesDao.getNextStationNum(ssh.id.value);
      tallyData = SurfaceSubstrateTallyCompanion(
          ssDataId: d.Value(ssh.id.value), stationNum: d.Value(stationNum));
    }

    var temp = await Get.toNamed(Routes.surfaceSubstrateStationInfo,
        arguments: tallyData);
    updateTallyData();
  }

  void updateTallyData() {
    _db.surfaceSubstrateTablesDao.getSsTallyList(ssh.id.value).then(
        (value) => setState(() => tallyDs = _TallyDataSource(stations: value)));
  }

  Future<void> _updateSsData(SurfaceSubstrateHeaderCompanion entry) async {
    (_db.update(_db.surfaceSubstrateHeader)
          ..where((t) => t.id.equals(ssh.id.value)))
        .write(entry);
  }

  String? _errorCheck() {
    String result = "";
    _errorNomTransLen(Global.dbCompanionValueToStr(ssh.nomTransLen)) != null
        ? result += "Nominal Transect Length \n"
        : null;
    _errorTransAzim(Global.dbCompanionValueToStr(ssh.transAzimuth)) != null
        ? result += "Transect Azimuth \n"
        : null;
    return result.isEmpty ? null : result;
  }

  //measured length of the sample transect (m). 10.0 to 150.0
  String? _errorNomTransLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (10.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 10.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Transect azimuth (degrees) 0 to 360
  String? _errorTransAzim(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    }
    if (0 > int.parse(text) || int.parse(text) > 360) {
      return "Input out of range. Must be between 0 to 360 inclusive.";
    }
    return null;
  }
}
