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
  WoodyDebrisTablesDao(super.db);

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

  Future<void> markNotAssessed(int surveyId, int? wdId) async {
    if (wdId != null) {
      var tmp = await deleteWoodyDebrisSummary(wdId);
    }

    int tmp2 = await addWdSummary(WoodyDebrisSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(DateTime.now()),
        notAssessed: const Value(true)));
  }

  //==================Deletion===============================
  Future<void> deleteWoodyDebrisSummary(int id) async {
    List<WoodyDebrisHeaderData> wdHList = await getWdHeadersFromWdSId(id);

    for (WoodyDebrisHeaderData wdH in wdHList) {
      var tmp = await deleteWoodyDebrisTransect(wdH.id);
    }

    var tmp = await (delete(woodyDebrisSummary)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<void> deleteWoodyDebrisTransect(int wdHeaderId) async {
    var tmp = await deleteAllPiecesOddByHeader(wdHeaderId);
    tmp = await deleteAllPiecesRoundByHeader(wdHeaderId);
    tmp = await deleteWdSmallByHeader(wdHeaderId);
    tmp = await (delete(woodyDebrisHeader)
          ..where((tbl) => tbl.id.equals(wdHeaderId)))
        .go();
  }

  Future<int> deleteWdSmallByHeader(int wdHeaderId) => (delete(woodyDebrisSmall)
        ..where((tbl) => tbl.wdHeaderId.equals(wdHeaderId)))
      .go();
  Future<int> deleteAllPiecesRoundByHeader(int wdHeaderId) =>
      (delete(woodyDebrisRound)
            ..where((tbl) => tbl.wdHeaderId.equals(wdHeaderId)))
          .go();
  Future<int> deleteAllPiecesOddByHeader(int wdHeaderId) =>
      (delete(woodyDebrisOdd)
            ..where((tbl) => tbl.wdHeaderId.equals(wdHeaderId)))
          .go();

//====================Woody Debris Summary====================
  Future<int> addWdSummary(WoodyDebrisSummaryCompanion entry) =>
      into(woodyDebrisSummary).insert(entry);

  Future<WoodyDebrisSummaryData> getWdSummary(int wdId) =>
      (select(woodyDebrisSummary)..where((tbl) => tbl.id.equals(wdId)))
          .getSingle();

  Future<WoodyDebrisSummaryData> getWdSummaryFromSurveyId(int surveyId) =>
      (select(woodyDebrisSummary)
            ..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();

  Future<WoodyDebrisSummaryData> setAndReturnDefaultWdSummary(
      int surveyId, DateTime measDate) async {
    WoodyDebrisSummaryCompanion entry = WoodyDebrisSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(measDate),
        complete: const Value(false),
        notAssessed: const Value(false));

    await into(woodyDebrisSummary).insert(entry,
        onConflict:
            DoUpdate((old) => entry, target: [woodyDebrisSummary.surveyId]));

    return getWdSummaryFromSurveyId(surveyId);
  }

  Future<void> updateNumTransects(int wdSId) async {
    List<WoodyDebrisHeaderData> wdhList = await getWdHeadersFromWdSId(wdSId);
    int numTransects = wdhList.length;
    (update(woodyDebrisSummary)..where((tbl) => tbl.id.equals(wdSId)))
        .write(WoodyDebrisSummaryCompanion(numTransects: Value(numTransects)));
  }

//====================Woody Debris Header====================
  Future<int> addWdHeader(WoodyDebrisHeaderCompanion entry) =>
      into(woodyDebrisHeader).insert(entry);

  Future<int> addOrUpdateWdHeader(WoodyDebrisHeaderCompanion entry) =>
      into(woodyDebrisHeader).insertOnConflictUpdate(entry);

  Future<WoodyDebrisHeaderData> updateWdHeaderTransNum(
      int wdhId, int transNum) async {
    var tmp = await ((update(woodyDebrisHeader)
          ..where((tbl) => tbl.id.equals(wdhId)))
        .write(WoodyDebrisHeaderCompanion(
            id: Value(wdhId), transNum: Value(transNum))));
    return getWdHeader(wdhId);
  }

  Future<WoodyDebrisHeaderData> getWdHeader(int wdhId) =>
      (select(woodyDebrisHeader)..where((tbl) => tbl.id.equals(wdhId)))
          .getSingle();

  Future<List<WoodyDebrisHeaderData>> getWdHeadersFromWdSId(int wdSId) =>
      (select(woodyDebrisHeader)
            ..where((tbl) => tbl.wdId.equals(wdSId))
            ..orderBy([
              (t) => OrderingTerm(
                  expression: t.transNum,
                  mode: OrderingMode.asc,
                  nulls: NullsOrder.last)
            ]))
          .get();

  Future<List<int?>> getUsedTransNums(int wdsId) {
    final query = select(woodyDebrisHeader)
      ..where((tbl) => tbl.wdId.equals(wdsId));
    return query.map((row) => row.transNum).get();
  }

  Future<WoodyDebrisHeaderData?> getWdHeaderFromTransNum(
          int wdId, int transNum) =>
      (select(woodyDebrisHeader)
            ..where(
                (tbl) => tbl.wdId.equals(wdId) & tbl.transNum.equals(transNum)))
          .getSingleOrNull();

//====================Woody Debris Small====================
  Future<int?> getOrCreateWdSmallId(int wdhId) async {
    WoodyDebrisSmallData? wdSm = await (db.select(db.woodyDebrisSmall)
          ..where((tbl) => tbl.wdHeaderId.equals(wdhId)))
        .getSingleOrNull();

    wdSm ??
        db.woodyDebrisTablesDao
            .addWdSmall(WoodyDebrisSmallCompanion(wdHeaderId: Value(wdhId)));

    return (await db.woodyDebrisTablesDao.getWdSmall(wdhId))?.id;
  }

  Future<int> addWdSmall(WoodyDebrisSmallCompanion entry) =>
      into(woodyDebrisSmall).insert(entry);
  Future<WoodyDebrisSmallData?> getWdSmall(int wdHeaderId) =>
      (select(woodyDebrisSmall)
            ..where((tbl) => tbl.wdHeaderId.equals(wdHeaderId)))
          .getSingleOrNull();
//====================Woody Debris Pieces====================
  Future<int> addOrUpdateWdPieceOddAccu(WoodyDebrisOddCompanion entry) =>
      into(woodyDebrisOdd).insertOnConflictUpdate(entry);

  Future<int> addOrUpdateWdPieceRound(WoodyDebrisRoundCompanion entry) =>
      into(woodyDebrisRound).insertOnConflictUpdate(entry);

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

  Future<bool> wdPieceExists(int headerId) async =>
      (await getWdRoundList(headerId)).isNotEmpty ||
      (await getWdOddList(headerId)).isNotEmpty;

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
