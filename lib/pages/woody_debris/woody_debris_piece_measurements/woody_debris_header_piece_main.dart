import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constants/constant_values.dart';
import '../../../constants/margins_padding.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/buttons/floating_complete_button.dart';
import '../../../widgets/popups/popup_dismiss.dart';
import '../../../widgets/popups/popups.dart';
import '../../../widgets/tables/table_data_grid_source_builder.dart';
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
          ],
        ),
      ),
    );
  }
}
