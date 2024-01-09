import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/surface_substrate_tables.dart';

part 'surface_substrate_tables_dao.g.dart';

const List<Type> _tables = [
  SurfaceSubstrateSummary,
  SurfaceSubstrateHeader,
  SurfaceSubstrateTally,
];

@DriftAccessor(tables: _tables)
class SurfaceSubstrateTablesDao extends DatabaseAccessor<Database>
    with _$SurfaceSubstrateTablesDaoMixin {
  SurfaceSubstrateTablesDao(super.db);

  void clearTables() {
    //Woody Debris
    delete(surfaceSubstrateSummary).go();
    delete(surfaceSubstrateHeader).go();
    delete(surfaceSubstrateTally).go();
  }

  Future<void> markNotAssessed(int surveyId, int? ssId) async {
    if (ssId != null) {
      var tmp = await deleteSurfaceSubstrateSummary(ssId);
    }

    int tmp2 = await addSsSummary(SurfaceSubstrateSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(DateTime.now()),
        notAssessed: const Value(true)));
  }

  //====================Deletion====================
  Future<void> deleteSurfaceSubstrateSummary(int summaryId) async {
    // First, delete related SurfaceSubstrateHeaders
    await deleteSurfaceSubstrateHeadersBySummaryId(summaryId);
    // Then, delete the summary
    await (delete(surfaceSubstrateSummary)
          ..where((tbl) => tbl.id.equals(summaryId)))
        .go();
  }

  Future<void> deleteSurfaceSubstrateHeadersBySummaryId(int summaryId) async {
    // Get all headers related to the summary
    final headers = await (select(surfaceSubstrateHeader)
          ..where((tbl) => tbl.ssId.equals(summaryId)))
        .get();

    // Delete related SurfaceSubstrateTally for each header
    for (final header in headers) {
      await deleteSurfaceSubstrateTallyByHeaderId(header.id);
    }

    // Delete the headers
    await (delete(surfaceSubstrateHeader)
          ..where((tbl) => tbl.ssId.equals(summaryId)))
        .go();
  }

  Future<void> deleteSurfaceSubstrateHeader(int id) async {
    await deleteSurfaceSubstrateTallyByHeaderId(id);
    await (delete(surfaceSubstrateHeader)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<void> deleteSurfaceSubstrateTallyByHeaderId(int headerId) async {
    await (delete(surfaceSubstrateTally)
          ..where((tbl) => tbl.ssHeaderId.equals(headerId)))
        .go();
  }

  //====================Surface Substrate Summary====================
  Future<int> addSsSummary(SurfaceSubstrateSummaryCompanion entry) =>
      into(surfaceSubstrateSummary).insert(entry);

  Future<SurfaceSubstrateSummaryData> getSsSummary(int surveyId) =>
      (select(surfaceSubstrateSummary)
            ..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();

  Future<SurfaceSubstrateSummaryData> setAndReturnDefaultSsSummary(
      int surveyId, DateTime measDate) async {
    SurfaceSubstrateSummaryCompanion entry = SurfaceSubstrateSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(measDate),
        complete: const Value(false),
        notAssessed: const Value(false));

    await into(surfaceSubstrateSummary).insert(entry,
        onConflict: DoUpdate((old) => entry,
            target: [surfaceSubstrateSummary.surveyId]));

    return getSsSummary(surveyId);
  }

  //====================Surface Substrate Header====================
  Future<int> addSsHeader(SurfaceSubstrateHeaderCompanion entry) =>
      into(surfaceSubstrateHeader).insert(entry);
  Future<SurfaceSubstrateHeaderData> getSsHeaderFromId(int id) =>
      (select(surfaceSubstrateHeader)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
  Future<List<SurfaceSubstrateHeaderData>> getSsHeaderWithSshId(
          int sshId) async =>
      (select(surfaceSubstrateHeader)
            ..where((tbl) => tbl.ssId.equals(sshId))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.transNum, mode: OrderingMode.asc)
            ]))
          .get();
  Future<List<SurfaceSubstrateHeaderData>> getSSHeadersFromSsSId(int ssSId) =>
      (select(surfaceSubstrateHeader)
            ..where((tbl) => tbl.ssId.equals(ssSId))
            ..orderBy([
              (t) => OrderingTerm(
                  expression: t.transNum,
                  mode: OrderingMode.asc,
                  nulls: NullsOrder.last)
            ]))
          .get();
  Future<SurfaceSubstrateHeaderData?> getSsHeaderFromTransNum(
          int sshId, int transNum) =>
      (select(surfaceSubstrateHeader)
            ..where((tbl) =>
                tbl.ssId.equals(sshId) & tbl.transNum.equals(transNum)))
          .getSingleOrNull();

  Future<List<int?>> getUsedTransNums(int ssSId) {
    final query = select(surfaceSubstrateHeader)
      ..where((tbl) => tbl.ssId.equals(ssSId));
    return query.map((row) => row.transNum).get();
  }

  //====================Surface Substrate Tally====================
  Future<int> addSsTally(SurfaceSubstrateTallyCompanion entry) =>
      into(surfaceSubstrateTally).insert(entry);
  Future<int> addOrUpdateSsTally(SurfaceSubstrateTallyCompanion entry) =>
      into(surfaceSubstrateTally).insertOnConflictUpdate(entry);
  Future<SurfaceSubstrateTallyData> getSsTallyFromId(int id) =>
      (select(surfaceSubstrateTally)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
  Future<SurfaceSubstrateTallyData?> getSsTallyFromSsSummaryId(
          int ssdId, int stationNum) =>
      (select(surfaceSubstrateTally)
            ..where((tbl) =>
                tbl.ssHeaderId.equals(ssdId) &
                tbl.stationNum.equals(stationNum)))
          .getSingleOrNull();
  Future<List<SurfaceSubstrateTallyData>> getSsTallyList(int ssHeaderId) =>
      (select(surfaceSubstrateTally)
            ..where((tbl) => tbl.ssHeaderId.equals(ssHeaderId))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.stationNum, mode: OrderingMode.asc)
            ]))
          .get();
  Future<int> getNextStationNum(int ssHeaderId) async {
    final query = select(surfaceSubstrateTally)
      ..where((tbl) => tbl.ssHeaderId.equals(ssHeaderId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.stationNum, mode: OrderingMode.asc)
      ]);

    List<SurfaceSubstrateTallyData> stations = await query.get();

    if (stations.isEmpty || stations[0].stationNum != 1) {
      return 1;
    }

    for (int i = 1; i < stations.length; i++) {
      if (stations[i].stationNum - stations[i - 1].stationNum > 1) {
        // Return the next integer of the previous number as it's the missing number
        return stations[i - 1].stationNum + 1;
      }
    }

    return stations.last.stationNum + 1;
  }

  List<String> getSsTallyColumnNames() {
    List<GeneratedColumn> cols = surfaceSubstrateTally.$columns;
    return List.generate(cols.length,
        (index) => cols[index].name.replaceAll(RegExp('_'), ' ').toUpperCase());
  }
}
