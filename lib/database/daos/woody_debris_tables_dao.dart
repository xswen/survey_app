import 'dart:math';

import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/woody_debris_tables.dart';

part 'woody_debris_tables_dao.g.dart';

const List<Type> _tables = [
  WoodyDebrisSummary,
  WoodyDebrisHeader,
  WoodyDebrisSmall,
  WoodyDebrisOdd,
  WoodyDebrisRound
];

@DriftAccessor(tables: _tables)
class WoodyDebrisTablesDao extends DatabaseAccessor<Database>
    with _$WoodyDebrisTablesDaoMixin {
  WoodyDebrisTablesDao(Database db) : super(db);

  String accumulation = "AC";
  String odd = "OD";
  String round = "R";

  void clearTables() {
    //Woody Debris
    delete(woodyDebrisSummary).go();
    delete(woodyDebrisHeader).go();
    delete(woodyDebrisSmall).go();
    delete(woodyDebrisOdd).go();
    delete(woodyDebrisRound).go();
  }

//====================Woody Debris Summary====================
  Future<int> addWdSummary(WoodyDebrisSummaryCompanion entry) =>
      into(woodyDebrisSummary).insert(entry);
  Future<WoodyDebrisSummaryData> getWdSummary(int surveyId) =>
      (select(woodyDebrisSummary)
            ..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();
//====================Woody Debris Header====================
  Future<int> addWdHeader(WoodyDebrisHeaderCompanion entry) =>
      into(woodyDebrisHeader).insert(entry);
  Future<WoodyDebrisHeaderData> getWdHeaderFromId(int id) =>
      (select(woodyDebrisHeader)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
  Future<List<WoodyDebrisHeaderData>> getWdHeadersFromWdsId(int wdsId) async =>
      (select(woodyDebrisHeader)
            ..where((tbl) => tbl.wdId.equals(wdsId))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.transNum, mode: OrderingMode.asc)
            ]))
          .get();
  Future<WoodyDebrisHeaderData?> getWdHeaderFromTransNum(
          int wdId, int transNum) =>
      (select(woodyDebrisHeader)
            ..where(
                (tbl) => tbl.wdId.equals(wdId) & tbl.transNum.equals(transNum)))
          .getSingleOrNull();
//====================Woody Debris Small====================
  Future<int> addWdSmall(WoodyDebrisSmallCompanion entry) =>
      into(woodyDebrisSmall).insert(entry);
  Future<WoodyDebrisSmallData?> getWdSmall(int wdHeaderId) =>
      (select(woodyDebrisSmall)
            ..where((tbl) => tbl.wdHeaderId.equals(wdHeaderId)))
          .getSingleOrNull();
//====================Woody Debris Pieces====================
  Future<int> addWdPieceOddAccu(WoodyDebrisOddCompanion entry) =>
      into(woodyDebrisOdd).insert(entry);

  Future<int> addWdPieceRound(WoodyDebrisRoundCompanion entry) =>
      into(woodyDebrisRound).insert(entry);

  Future<WoodyDebrisRoundData> getWdRound(int id) =>
      (select(woodyDebrisRound)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<List<WoodyDebrisRoundData>> getWdRoundList(int headerId) =>
      (select(woodyDebrisRound)
            ..where((tbl) => tbl.wdHeaderId.equals(headerId))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.pieceNum, mode: OrderingMode.asc)
            ]))
          .get();

  Future<WoodyDebrisOddData> getWdOddAccu(int id) =>
      (select(woodyDebrisOdd)..where((tbl) => tbl.id.equals(id))).getSingle();

  //Get list of odd and accu pieces
  Future<List<WoodyDebrisOddData>> getWdOddList(int headerId) =>
      (select(woodyDebrisOdd)
            ..where((tbl) => (tbl.wdHeaderId.equals(headerId)))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.pieceNum, mode: OrderingMode.asc)
            ]))
          .get();

  Future<int> getLastWdPieceNum(int wdHeaderId) async {
    final queryOdd =
        (select(woodyDebrisOdd)..where((tbl) => tbl.wdHeaderId.equals(wdHeaderId)))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.pieceNum, mode: OrderingMode.desc)
          ])
          ..limit(1);
    final queryRound =
        (select(woodyDebrisRound)..where((tbl) => tbl.wdHeaderId.equals(wdHeaderId)))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.pieceNum, mode: OrderingMode.desc)
          ])
          ..limit(1);

    final int? largestOddNum =
        await queryOdd.map((p0) => p0.pieceNum).getSingleOrNull();
    final int? largestRoundNum =
        await queryRound.map((p0) => p0.pieceNum).getSingleOrNull();

    return max(largestRoundNum ?? 0, largestOddNum ?? 0);
  }
}
