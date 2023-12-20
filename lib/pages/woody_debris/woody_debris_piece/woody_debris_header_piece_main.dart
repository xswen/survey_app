import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/providers/woody_debris_providers.dart';
import 'package:survey_app/wrappers/column_header_object.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../widgets/box_increment.dart';
import '../../../widgets/tables/table_creation_builder.dart';
import '../../../widgets/tables/table_data_grid_source_builder.dart';
import '../../../widgets/text/text_header_separator.dart';

class ColNames {
  ColNames();
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
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

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

class WoodyDebrisHeaderPieceMainPage extends ConsumerStatefulWidget {
  const WoodyDebrisHeaderPieceMainPage(this.goRouterState, {super.key});
  static const String routeName = "woodyDebrisHeaderPieceMain";

  final GoRouterState goRouterState;

  @override
  WoodyDebrisHeaderPieceMainPageState createState() =>
      WoodyDebrisHeaderPieceMainPageState();
}

class WoodyDebrisHeaderPieceMainPageState
    extends ConsumerState<WoodyDebrisHeaderPieceMainPage> {
  final PopupDismiss completeWarningPopup =
      Popups.generateCompleteErrorPopup("Wood Debris Piece");
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int wdSmId;
  late final int wdhId;

  ColNames columnData = ColNames();

  @override
  void initState() {
    wdSmId = PathParamValue.getWdSmallId(widget.goRouterState);
    wdhId = PathParamValue.getWdHeaderId(widget.goRouterState)!;

    super.initState();
  }

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
              kEditColumnDataGridCell,
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
              kEditColumnDataGridCell,
            ]))
        .toList();

    return [...oddGrid, ...roundGrid];
  }

  DataGridSourceBuilder getSourceBuilder(
      List<WoodyDebrisOddData> odd, List<WoodyDebrisRoundData> round) {
    DataGridSourceBuilder largePieceDataSource =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(odd, round));
    largePieceDataSource.sortedColumns.add(SortColumnDetails(
        name: columnData.pieceNum.name,
        sortDirection: DataGridSortDirection.ascending));
    largePieceDataSource.sort();

    return largePieceDataSource;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    final AsyncValue<WoodyDebrisHeaderData> wdh = ref.watch(wdhProvider(wdhId));
    final wdSmall = ref.watch(wdSmallProvider(wdhId));
    final pieceOdd = ref.watch(wdPieceOddProvider(wdhId));
    final pieceRound = ref.watch(wdPieceRoundProvider(wdhId));

    return wdh.when(
        data: (wdh) => Scaffold(
              appBar: OurAppBar("Woody Debris: Transect ${wdh.transNum}"),
              endDrawer: DrawerMenu(onLocaleChange: () {}),
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: kPaddingV,
                    ),
                    const TextHeaderSeparator(title: "Small Woody Debris"),
                    const SizedBox(
                      height: kPaddingV,
                    ),

                    const SizedBox(
                      height: kPaddingV * 2,
                    ),
                    wdSmall.when(
                        data: (wdSm) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BoxIncrement(
                                  title: "Class 1",
                                  subtitle: "1.1 - 3.0cm",
                                  boxVal: wdSm!.swdTallyS.toString(),
                                  minusOnPress: () {
                                    wdh.complete
                                        ? Popups.show(
                                            context, completeWarningPopup)
                                        : (wdSm.swdTallyS > 0
                                            ? updateWdSm(
                                                WoodyDebrisSmallCompanion(
                                                    swdTallyS: d.Value(
                                                        wdSm.swdTallyS - 1)))
                                            : null);
                                  },
                                  addOnPress: () => wdh.complete
                                      ? Popups.show(
                                          context, completeWarningPopup)
                                      : updateWdSm(WoodyDebrisSmallCompanion(
                                          swdTallyS:
                                              d.Value(wdSm.swdTallyS + 1))),
                                ),
                                BoxIncrement(
                                  title: "Class 2",
                                  subtitle: "3.1 - 5.0cm",
                                  boxVal: wdSm.swdTallyM.toString(),
                                  minusOnPress: () {
                                    wdh.complete
                                        ? Popups.show(
                                            context, completeWarningPopup)
                                        : wdSm.swdTallyM > 0
                                            ? updateWdSm(
                                                WoodyDebrisSmallCompanion(
                                                    swdTallyM: d.Value(
                                                        wdSm.swdTallyM - 1)))
                                            : null;
                                  },
                                  addOnPress: () => wdh.complete
                                      ? Popups.show(
                                          context, completeWarningPopup)
                                      : updateWdSm(WoodyDebrisSmallCompanion(
                                          swdTallyM:
                                              d.Value(wdSm.swdTallyM + 1))),
                                ),
                                BoxIncrement(
                                  title: "Class 3",
                                  subtitle: "5.1 - 7.5cm",
                                  boxVal: wdSm.swdTallyL.toString(),
                                  minusOnPress: () {
                                    wdh.complete
                                        ? Popups.show(
                                            context, completeWarningPopup)
                                        : (wdSm.swdTallyL > 0
                                            ? updateWdSm(
                                                WoodyDebrisSmallCompanion(
                                                    swdTallyL: d.Value(
                                                        wdSm.swdTallyL - 1)))
                                            : null);
                                  },
                                  addOnPress: () => wdh.complete
                                      ? Popups.show(
                                          context, completeWarningPopup)
                                      : updateWdSm(WoodyDebrisSmallCompanion(
                                          swdTallyL:
                                              d.Value(wdSm.swdTallyL + 1))),
                                ),
                              ],
                            ),
                        error: (err, stack) => Text("Error: $err"),
                        loading: () =>
                            const Center(child: CircularProgressIndicator())),
                    //Coarse Woody debris
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kPaddingH / 2),
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
                                onPressed: () => wdh.complete
                                    ? Popups.show(context, completeWarningPopup)
                                    : addPiece(),
                                style: ButtonStyle(
                                    backgroundColor: wdh.complete
                                        ? MaterialStateProperty.all<Color>(
                                            Colors.grey)
                                        : null),
                                child: const Text("Add Piece")),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: pieceRound.when(
                        data: (round) => pieceOdd.when(
                          data: (odd) {
                            DataGridSourceBuilder largePieceDataSource =
                                getSourceBuilder(odd, round);
                            return Center(
                              child: TableCreationBuilder(
                                source: largePieceDataSource,
                                columnWidthMode: ColumnWidthMode.lastColumnFill,
                                colNames: columnData.getColHeadersList(),
                                onCellTap:
                                    (DataGridCellTapDetails details) async {
                                  // Assuming the "edit" column index is 2
                                  if (details.column.columnName ==
                                          columnData.edit.name &&
                                      details.rowColumnIndex.rowIndex != 0) {
                                    if (wdh.complete) {
                                      Popups.show(
                                          context, completeWarningPopup);
                                    } else {
                                      int pId = largePieceDataSource
                                          .dataGridRows[
                                              details.rowColumnIndex.rowIndex -
                                                  1]
                                          .getCells()[0]
                                          .value;
                                      if (largePieceDataSource.dataGridRows[
                                                  details.rowColumnIndex
                                                          .rowIndex -
                                                      1]
                                              .getCells()[2]
                                              .value ==
                                          "R") {
                                        db.woodyDebrisTablesDao
                                            .getWdRound(pId)
                                            .then((wdRound) =>
                                                changeWdPieceData(wdh.complete,
                                                    round: wdRound,
                                                    deleteFn: () => (db.delete(
                                                            db.woodyDebrisRound)
                                                          ..where((tbl) =>
                                                              tbl.id.equals(
                                                                  wdRound.id)))
                                                        .go()
                                                        .then((value) =>
                                                            context.pop())));
                                      } else {
                                        db.woodyDebrisTablesDao
                                            .getWdOddAccu(pId)
                                            .then((wdOdd) => changeWdPieceData(
                                                wdh.complete,
                                                odd: wdOdd,
                                                deleteFn: () => (db.delete(
                                                        db.woodyDebrisOdd)
                                                      ..where((tbl) => tbl.id
                                                          .equals(wdOdd.id)))
                                                    .go()
                                                    .then((value) =>
                                                        context.pop())));
                                      }
                                    }
                                  }
                                },
                              ),
                            );
                          },
                          error: (err, stack) => Text("Error: $err"),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        error: (err, stack) => Text("Error: $err"),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        error: (err, stack) => Text("Error: $err"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
