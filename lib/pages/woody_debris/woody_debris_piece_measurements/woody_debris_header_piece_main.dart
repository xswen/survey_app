import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_piece_measurements/woody_debris_piece_round_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constants/constant_values.dart';
import '../../../constants/margins_padding.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/buttons/floating_complete_button.dart';
import '../../../widgets/popups/popup_dismiss.dart';
import '../../../widgets/popups/popups.dart';
import '../../../widgets/tables/table_creation_builder.dart';
import '../../../widgets/tables/table_data_grid_source_builder.dart';
import '../../../widgets/text/text_header_separator.dart';
import '../woody_debris_piece_accu_odd_page.dart';
import 'builders/woody_debris_small_piece_builder.dart';

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

class WoodyDebrisHeaderPieceMain extends StatefulWidget {
  static const String routeName = "woodyDebrisTransectPieceMain";
  static const keyWdSmall = "wdSmall";
  static const keyTransNum = "transNum";
  static const keyTransComplete = "transectComplete";
  const WoodyDebrisHeaderPieceMain(
      {Key? key,
      required this.wdSmall,
      required this.transNum,
      required this.transComplete})
      : super(key: key);

  final WoodyDebrisSmallData wdSmall;
  final int transNum;
  final bool transComplete;

  @override
  State<WoodyDebrisHeaderPieceMain> createState() =>
      _WoodyDebrisHeaderPieceMainState();
}

class _WoodyDebrisHeaderPieceMainState
    extends State<WoodyDebrisHeaderPieceMain> {
  String get title => "Woody Debris Pieces";

  late WoodyDebrisSmallData wdSm;
  late int transNum;
  late bool transComplete;
  late DataGridSourceBuilder largePieceDataSource =
      DataGridSourceBuilder(dataGridRows: []);

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
    final Database db = Database.instance;
    db.woodyDebrisTablesDao.getWdOddList(wdSm.wdHeaderId).then((odd) {
      db.woodyDebrisTablesDao.getWdRoundList(wdSm.wdHeaderId).then((round) {
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
  void initState() {
    wdSm = widget.wdSmall;
    transNum = widget.transNum;
    transComplete = widget.transComplete;
    updatePieces();
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

    void createOddOrAccuPiece(String type) {
      db.woodyDebrisTablesDao
          .getLastWdPieceNum(wdSm.wdHeaderId)
          .then((lastPieceNum) {
        int pieceNum = lastPieceNum + 1;
        WoodyDebrisOddCompanion wdOdd = WoodyDebrisOddCompanion(
            wdHeaderId: d.Value(wdSm.wdHeaderId),
            pieceNum: d.Value(pieceNum),
            accumOdd: d.Value(type));
        context
            .pushNamed(WoodyDebrisPieceAccuOddPage.routeName, extra: wdOdd)
            .then((value) => updatePieces());
      });
    }

    void addPiece() => Popups.show(
        context,
        SimpleDialog(
          title: const Text("Create New: "),
          children: [
            SimpleDialogOption(
              onPressed: () {
                context.pop();
                createOddOrAccuPiece(db.woodyDebrisTablesDao.odd);
              },
              child: const Text("Odd Piece"),
            ),
            SimpleDialogOption(
              onPressed: () {
                context.pop();
                createOddOrAccuPiece(db.woodyDebrisTablesDao.accumulation);
              },
              child: const Text("Accumulation"),
            ),
            SimpleDialogOption(
              onPressed: () async {
                db.woodyDebrisTablesDao
                    .getLastWdPieceNum(wdSm.wdHeaderId)
                    .then((lastPieceNum) {
                  int pieceNum = lastPieceNum + 1;
                  WoodyDebrisRoundCompanion wdRound = WoodyDebrisRoundCompanion(
                      wdHeaderId: d.Value(wdSm.wdHeaderId),
                      pieceNum: d.Value(pieceNum));
                  context.pop();
                  context
                      .pushNamed(WoodyDebrisPieceRoundPage.routeName,
                          extra: wdRound)
                      .then((value) => updatePieces());
                });
              },
              child: const Text("Round Piece"),
            ),
            SimpleDialogOption(
              onPressed: () => context.pop(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Cancel")],
              ),
            ),
          ],
        ));

    void changeWdPieceData(
        {WoodyDebrisOddData? odd, WoodyDebrisRoundData? round}) {
      if (transComplete) {
        Popups.show(context, completeWarningPopup);
      } else if (odd != null) {
        context
            .pushNamed(WoodyDebrisPieceAccuOddPage.routeName,
                extra: odd.toCompanion(true))
            .then((value) => WoodyDebrisPieceAccuOddPage);
      } else if (round != null) {
        context
            .pushNamed(WoodyDebrisPieceRoundPage.routeName,
                extra: round.toCompanion(true))
            .then((value) => updatePieces());
      } else {
        debugPrint("Error: No data given");
      }
    }

    return Scaffold(
      appBar: OurAppBar("$title: Transect $transNum"),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
        child: Column(
          children: [
            WoodyDebrisSmallPieceBuilder(wdSm: wdSm, complete: transComplete),
            const SizedBox(
              height: kPaddingV * 2,
            ),
            TextHeaderSeparator(
              title: "Large Woody Debris",
              sideWidget: Padding(
                padding: const EdgeInsets.only(left: kPaddingH),
                child: ElevatedButton(
                    onPressed: () => transComplete
                        ? Popups.show(context, completeWarningPopup)
                        : addPiece(),
                    style: ButtonStyle(
                        backgroundColor: transComplete
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
                    if (transComplete) {
                      Popups.show(context, completeWarningPopup);
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
                        db.woodyDebrisTablesDao.getWdRound(pId).then(
                            (wdRound) => changeWdPieceData(round: wdRound));
                      } else {
                        db.woodyDebrisTablesDao
                            .getWdOddAccu(pId)
                            .then((wdOdd) => changeWdPieceData(odd: wdOdd));
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
