import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constants/constant_values.dart';
import '../../../constants/margins_padding.dart';
import '../../../database/database.dart';
import '../../../global.dart';
import '../../../routes/route_names.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/popups/popup_dismiss.dart';
import '../../../widgets/tables/table_creation_builder.dart';
import '../../../widgets/tables/table_data_grid_source_builder.dart';
import '../../../widgets/text/text_header_separator.dart';
import 'woody_debris_small_piece_builder.dart';

class _ColNames {
  static String id = "id";
  static String pieceNum = "Piece Number";
  static String type = "Type";
  static String genus = "Genus";
  static String species = "Species";
  static String horLen = "Horizontal Length";
  static String verDep = "Vertical Depth";
  static String diameter = "Diameter";
  static String tiltAngle = "Tilt Angle";
  static String decayClass = "Decay Class";
  static String edit = kColHeaderMapKeyEdit;

  static String empty = "-";

  static List<Map<String, Object>> colHeadersList = [
    {kColHeaderMapKeyName: pieceNum, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: type, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: genus, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: species, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: horLen, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: verDep, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: diameter, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: tiltAngle, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: decayClass, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: edit, kColHeaderMapKeySort: false},
  ];
}

class WoodyDebrisPieceMainPage extends StatefulWidget {
  const WoodyDebrisPieceMainPage({super.key});

  @override
  State<WoodyDebrisPieceMainPage> createState() =>
      _WoodyDebrisPieceMainPageState();
}

class _WoodyDebrisPieceMainPageState extends State<WoodyDebrisPieceMainPage> {
  final _db = Get.find<Database>();
  final int _wdHeaderId = Get.arguments["wdSmall"].wdHeaderId;

  WoodyDebrisSmallData wdSm = Get.arguments["wdSmall"];
  int transNum = Get.arguments["transNum"];
  bool complete = Get.arguments["transectComplete"];

  late DataGridSourceBuilder largePieceDataSource =
      DataGridSourceBuilder(dataGridRows: []);

  final PopupDismiss completeWarningPopup =
      Global.generateCompleteErrorPopup("Transect");

  @override
  void initState() {
    super.initState();
    updatePieces();
  }

  List<DataGridRow> generateDataGridRows(List<WoodyDebrisOddData> piecesOdd,
      List<WoodyDebrisRoundData> piecesRound) {
    List<DataGridRow> oddGrid = piecesOdd
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: _ColNames.id, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: _ColNames.pieceNum, value: dataGridRow.pieceNum),
              DataGridCell<String>(
                  columnName: _ColNames.type, value: dataGridRow.accumOdd),
              DataGridCell<String>(
                  columnName: _ColNames.genus, value: dataGridRow.genus),
              DataGridCell<String>(
                  columnName: _ColNames.species, value: dataGridRow.species),
              DataGridCell<String>(
                  columnName: _ColNames.horLen,
                  value: dataGridRow.horLength.toString()),
              DataGridCell<String>(
                  columnName: _ColNames.verDep,
                  value: dataGridRow.verDepth.toString()),
              DataGridCell<String>(
                  columnName: _ColNames.diameter, value: _ColNames.empty),
              DataGridCell<String>(
                  columnName: _ColNames.tiltAngle, value: _ColNames.empty),
              DataGridCell<String>(
                  columnName: _ColNames.decayClass,
                  value: dataGridRow.decayClass == -1
                      ? "Missing"
                      : dataGridRow.decayClass.toString()),
              DataGridCell<bool>(columnName: _ColNames.edit, value: false),
            ]))
        .toList();

    List<DataGridRow> roundGrid = piecesRound
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: _ColNames.id, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: _ColNames.pieceNum, value: dataGridRow.pieceNum),
              DataGridCell<String>(columnName: _ColNames.type, value: "R"),
              DataGridCell<String>(
                  columnName: _ColNames.genus, value: dataGridRow.genus),
              DataGridCell<String>(
                  columnName: _ColNames.species, value: dataGridRow.species),
              DataGridCell<String>(
                  columnName: _ColNames.horLen, value: _ColNames.empty),
              DataGridCell<String>(
                  columnName: _ColNames.verDep, value: _ColNames.empty),
              DataGridCell<String>(
                  columnName: _ColNames.diameter,
                  value: dataGridRow.diameter.toString()),
              DataGridCell<String>(
                  columnName: _ColNames.tiltAngle,
                  value: dataGridRow.tiltAngle == -1
                      ? "Missing"
                      : dataGridRow.tiltAngle.toString()),
              DataGridCell<String>(
                  columnName: _ColNames.decayClass,
                  value: dataGridRow.decayClass == -1
                      ? "Missing"
                      : dataGridRow.decayClass.toString()),
              DataGridCell<String?>(columnName: _ColNames.edit, value: null),
            ]))
        .toList();

    return [...oddGrid, ...roundGrid];
  }

  void updatePieces() {
    _db.woodyDebrisTablesDao.getWdOddList(wdSm.wdHeaderId).then((odd) {
      _db.woodyDebrisTablesDao.getWdRoundList(wdSm.wdHeaderId).then((round) {
        largePieceDataSource = DataGridSourceBuilder(
            dataGridRows: generateDataGridRows(odd, round));
        largePieceDataSource.sortedColumns.add(SortColumnDetails(
            name: _ColNames.pieceNum,
            sortDirection: DataGridSortDirection.ascending));
        largePieceDataSource.sort();
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar("Woody Debris Pieces: Transect $transNum"),
      body: Column(
        children: [
          WoodyDebrisSmallPieceBuilder(wdSm: wdSm, complete: complete),
          const SizedBox(
            height: kPaddingV * 2,
          ),
          TextHeaderSeparator(
            title: "Large Woody Debris",
            sideWidget: Padding(
              padding: const EdgeInsets.only(left: kPaddingH),
              child: ElevatedButton(
                  onPressed: () async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                    } else {
                      _createButton();
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: complete
                          ? MaterialStateProperty.all<Color>(Colors.grey)
                          : null),
                  child: const Text("Add Piece")),
            ),
          ),
          Expanded(
            child: TableCreationBuilder(
              source: largePieceDataSource,
              colNames: _ColNames.colHeadersList,
              onCellTap: (DataGridCellTapDetails details) async {
                // Assuming the "edit" column index is 2
                if (details.column.columnName == _ColNames.edit &&
                    details.rowColumnIndex.rowIndex != 0) {
                  if (complete) {
                    Get.dialog(completeWarningPopup);
                  } else {
                    int pId = largePieceDataSource
                        .dataGridRows[details.rowColumnIndex.rowIndex - 1]
                        .getCells()[0]
                        .value;

                    if (largePieceDataSource
                            .dataGridRows[details.rowColumnIndex.rowIndex - 1]
                            .getCells()[2]
                            .value ==
                        "R") {
                      WoodyDebrisRoundData wdRound =
                          await _db.woodyDebrisTablesDao.getWdRound(pId);
                      changeWdPieceData(null, wdRound);
                    } else {
                      WoodyDebrisOddData wdOdd =
                          await _db.woodyDebrisTablesDao.getWdOddAccu(pId);
                      changeWdPieceData(wdOdd, null);
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void changeWdPieceData(
      WoodyDebrisOddData? odd, WoodyDebrisRoundData? round) async {
    if (complete) {
      Get.dialog(completeWarningPopup);
    } else if (odd != null) {
      var tmp = await Get.toNamed(Routes.woodyDebrisPieceAddOddAccu,
          arguments: odd.toCompanion(true));
    } else if (round != null) {
      var tmp = await Get.toNamed(Routes.woodyDebrisPieceAddRound,
          arguments: round.toCompanion(true));
    } else {
      printError(info: "Error: No data given");
    }

    updatePieces();
  }

  _createButton() {
    Get.dialog(SimpleDialog(
      title: const Text("Create New: "),
      children: [
        SimpleDialogOption(
          onPressed: () async {
            _createOdd(_db.woodyDebrisTablesDao.odd);
          },
          child: const Text("Odd Piece"),
        ),
        SimpleDialogOption(
          onPressed: () {
            _createOdd(_db.woodyDebrisTablesDao.accumulation);
          },
          child: const Text("Accumulation"),
        ),
        SimpleDialogOption(
          onPressed: () async {
            WoodyDebrisRoundCompanion wdRound = WoodyDebrisRoundCompanion(
                wdHeaderId: d.Value(_wdHeaderId),
                pieceNum: d.Value((await _db.woodyDebrisTablesDao
                        .getLastWdPieceNum(_wdHeaderId)) +
                    1));
            var val = await Get.toNamed(Routes.woodyDebrisPieceAddRound,
                arguments: wdRound);
            updatePieces();
          },
          child: const Text("Round Piece"),
        ),
        SimpleDialogOption(
          onPressed: () => Get.back(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [Text("Cancel")],
          ),
        ),
      ],
    ));
  }

  _createOdd(String type) async {
    WoodyDebrisOddCompanion wdOdd = WoodyDebrisOddCompanion(
      wdHeaderId: d.Value(_wdHeaderId),
      pieceNum: d.Value(
          (await _db.woodyDebrisTablesDao.getLastWdPieceNum(_wdHeaderId)) + 1),
      accumOdd: d.Value(type),
    );
    var val =
        await Get.toNamed(Routes.woodyDebrisPieceAddOddAccu, arguments: wdOdd);
    updatePieces();
  }
}
