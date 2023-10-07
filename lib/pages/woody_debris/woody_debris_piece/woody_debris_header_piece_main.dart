import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/constants/text_designs.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/wrappers/column_header_object.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constants/margins_padding.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/drawer_menu.dart';
import '../../../widgets/popups/popup_dismiss.dart';
import '../../../widgets/popups/popups.dart';
import '../../../widgets/tables/table_creation_builder.dart';
import '../../../widgets/tables/table_data_grid_source_builder.dart';
import 'builders/woody_debris_small_piece_builder.dart';
import 'woody_debris_piece_accu_odd_page.dart';
import 'woody_debris_piece_round_page.dart';

class _ColNames {
  _ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders pieceNum = ColumnHeaders("Piece Number");
  ColumnHeaders type = ColumnHeaders("Type");
  ColumnHeaders genus = ColumnHeaders("Genus");
  ColumnHeaders species = ColumnHeaders("Species");
  ColumnHeaders horLen = ColumnHeaders("Horizontal Length");
  ColumnHeaders verDep = ColumnHeaders("Vertical Depth");
  ColumnHeaders diameter = ColumnHeaders("Diameter");
  ColumnHeaders tiltAngle = ColumnHeaders("Tilt Angle");
  ColumnHeaders decayClass = ColumnHeaders("Decay Class");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameId, sort: false);

  String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [
        pieceNum,
        type,
        genus,
        species,
        horLen,
        verDep,
        diameter,
        tiltAngle,
        decayClass,
        edit
      ];
}

class WoodyDebrisHeaderPieceMain extends StatefulWidget {
  static const String routeName = "woodyDebrisTransectPieceMain";
  static const keyWdSmall = "wdSmall";
  static const keyTransNum = "transNum";
  static const keyTransComplete = "transectComplete";
  static const keyDecayClass = "decayClass";
  const WoodyDebrisHeaderPieceMain(
      {Key? key,
      required this.wdSmall,
      required this.transNum,
      required this.decayClass,
      required this.transComplete})
      : super(key: key);

  final WoodyDebrisSmallData wdSmall;
  final int transNum;
  final int? decayClass;
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
  late int? decayClass;
  late bool transComplete;
  late DataGridSourceBuilder largePieceDataSource =
      DataGridSourceBuilder(dataGridRows: []);
  _ColNames columnData = _ColNames();

  List<DataGridRow> generateDataGridRows(List<WoodyDebrisOddData> piecesOdd,
      List<WoodyDebrisRoundData> piecesRound) {
    List<DataGridRow> oddGrid = piecesOdd
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: columnData.pieceNum.name,
                  value: dataGridRow.pieceNum),
              DataGridCell<String>(
                  columnName: columnData.type.name,
                  value: dataGridRow.accumOdd),
              DataGridCell<String>(
                  columnName: columnData.genus.name, value: dataGridRow.genus),
              DataGridCell<String>(
                  columnName: columnData.species.name,
                  value: dataGridRow.species),
              DataGridCell<String>(
                  columnName: columnData.horLen.name,
                  value: dataGridRow.horLength.toString()),
              DataGridCell<String>(
                  columnName: columnData.verDep.name,
                  value: dataGridRow.verDepth.toString()),
              DataGridCell<String>(
                  columnName: columnData.diameter.name,
                  value: columnData.empty),
              DataGridCell<String>(
                  columnName: columnData.tiltAngle.name,
                  value: columnData.empty),
              DataGridCell<String>(
                  columnName: columnData.decayClass.name,
                  value: dataGridRow.decayClass == -1
                      ? "Missing"
                      : dataGridRow.decayClass.toString()),
              DataGridCell<bool>(
                  columnName: columnData.edit.name, value: false),
            ]))
        .toList();

    List<DataGridRow> roundGrid = piecesRound
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<int>(
                  columnName: columnData.pieceNum.name,
                  value: dataGridRow.pieceNum),
              DataGridCell<String>(
                  columnName: columnData.type.name, value: "R"),
              DataGridCell<String>(
                  columnName: columnData.genus.name, value: dataGridRow.genus),
              DataGridCell<String>(
                  columnName: columnData.species.name,
                  value: dataGridRow.species),
              DataGridCell<String>(
                  columnName: columnData.horLen.name, value: columnData.empty),
              DataGridCell<String>(
                  columnName: columnData.verDep.name, value: columnData.empty),
              DataGridCell<String>(
                  columnName: columnData.diameter.name,
                  value: dataGridRow.diameter.toString()),
              DataGridCell<String>(
                  columnName: columnData.tiltAngle.name,
                  value: dataGridRow.tiltAngle == -1
                      ? "Missing"
                      : dataGridRow.tiltAngle.toString()),
              DataGridCell<String>(
                  columnName: columnData.decayClass.name,
                  value: dataGridRow.decayClass == -1
                      ? "Missing"
                      : dataGridRow.decayClass.toString()),
              DataGridCell<String?>(
                  columnName: columnData.edit.name, value: null),
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
            name: columnData.pieceNum.name,
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
    decayClass = widget.decayClass;
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
        context.pushNamed(WoodyDebrisPieceAccuOddPage.routeName, extra: {
          WoodyDebrisPieceAccuOddPage.keyPiece: wdOdd
        }).then((value) => updatePieces());
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
                  context.pushNamed(WoodyDebrisPieceRoundPage.routeName,
                      extra: {
                        WoodyDebrisPieceRoundPage.keyPiece: wdRound
                      }).then((value) => updatePieces());
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
        {WoodyDebrisOddData? odd,
        WoodyDebrisRoundData? round,
        void Function()? deleteFn}) {
      if (transComplete) {
        Popups.show(context, completeWarningPopup);
      } else if (odd != null) {
        context.pushNamed(WoodyDebrisPieceAccuOddPage.routeName, extra: {
          WoodyDebrisPieceAccuOddPage.keyPiece: odd.toCompanion(true),
          WoodyDebrisPieceAccuOddPage.keyDeleteFn: deleteFn
        }).then((value) => updatePieces());
      } else if (round != null) {
        context.pushNamed(WoodyDebrisPieceRoundPage.routeName, extra: {
          WoodyDebrisPieceRoundPage.keyPiece: round.toCompanion(true),
          WoodyDebrisPieceRoundPage.keyDeleteFn: deleteFn
        }).then((value) => updatePieces());
      } else {
        debugPrint("Error: No data given");
      }
    }

    return Scaffold(
      appBar: OurAppBar("$title: Transect $transNum"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
        child: Column(
          children: [
            WoodyDebrisSmallPieceBuilder(
                wdSm: wdSm, decayClass: decayClass, complete: transComplete),
            const SizedBox(
              height: kPaddingV * 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingH / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Coarse Woody Debris",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
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
                ],
              ),
            ),
            Expanded(
              child: TableCreationBuilder(
                source: largePieceDataSource,
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                colNames: columnData.getColHeadersList(),
                onCellTap: (DataGridCellTapDetails details) async {
                  // Assuming the "edit" column index is 2
                  if (details.column.columnName == columnData.edit.name &&
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
                            (wdRound) => changeWdPieceData(
                                round: wdRound,
                                deleteFn: () => (db.delete(db.woodyDebrisRound)
                                      ..where(
                                          (tbl) => tbl.id.equals(wdRound.id)))
                                    .go()
                                    .then((value) => context.pop())));
                      } else {
                        db.woodyDebrisTablesDao.getWdOddAccu(pId).then(
                            (wdOdd) => changeWdPieceData(
                                odd: wdOdd,
                                deleteFn: () => (db.delete(db.woodyDebrisOdd)
                                      ..where((tbl) => tbl.id.equals(wdOdd.id)))
                                    .go()
                                    .then((value) => context.pop())));
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
