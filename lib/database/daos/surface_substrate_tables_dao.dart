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
  SurfaceSubstrateTablesDao(Database db) : super(db);

  void clearTables() {
    //Woody Debris
    delete(surfaceSubstrateSummary).go();
    delete(surfaceSubstrateHeader).go();
    delete(surfaceSubstrateTally).go();
  }

  //====================Surface Substrate Summary====================
  Future<int> addSsSummary(SurfaceSubstrateSummaryCompanion entry) =>
      into(surfaceSubstrateSummary).insert(entry);
  Future<SurfaceSubstrateSummaryData?> getSsSummary(int surveyId) =>
      (select(surfaceSubstrateSummary)
            ..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingleOrNull();

  //====================Surface Substrate Header====================
  Future<int> addSsHeader(SurfaceSubstrateHeaderCompanion entry) =>
      into(surfaceSubstrateHeader).insert(entry);
  Future<SurfaceSubstrateHeaderData> getSsHeaderFromId(int id) =>
      (select(surfaceSubstrateHeader)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
  Future<List<SurfaceSubstrateHeaderData>> getSsHeaderWithSshId(
          int sshId) async =>
      (select(surfaceSubstrateHeader)
            ..where((tbl) => tbl.ssHeaderId.equals(sshId))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.transNum, mode: OrderingMode.asc)
            ]))
          .get();

  Future<SurfaceSubstrateHeaderData?> getSsHeaderFromTransNum(
          int sshId, int transNum) =>
      (select(surfaceSubstrateHeader)
            ..where((tbl) =>
                tbl.ssHeaderId.equals(sshId) & tbl.transNum.equals(transNum)))
          .getSingleOrNull();

  //====================Surface Substrate Tally====================
  Future<int> addSsTally(SurfaceSubstrateTallyCompanion entry) =>
      into(surfaceSubstrateTally).insert(entry);
  Future<int> addOrUpdateSsTally(SurfaceSubstrateTallyCompanion entry) =>
      into(surfaceSubstrateTally).insertOnConflictUpdate(entry);
  Future<SurfaceSubstrateTallyData> getSsTallyFromId(int id) =>
      (select(surfaceSubstrateTally)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
  Future<SurfaceSubstrateTallyData?> getSsTallyFromSsDataId(
          int ssdId, int stationNum) =>
      (select(surfaceSubstrateTally)
            ..where((tbl) =>
                tbl.ssDataId.equals(ssdId) & tbl.stationNum.equals(stationNum)))
          .getSingleOrNull();
  Future<List<SurfaceSubstrateTallyData>> getSsTallyList(int ssDataId) =>
      (select(surfaceSubstrateTally)
            ..where((tbl) => tbl.ssDataId.equals(ssDataId))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.stationNum, mode: OrderingMode.asc)
            ]))
          .get();
  Future<int> getNextStationNum(int ssDataId) async {
    final query = select(surfaceSubstrateTally)
      ..where((tbl) => tbl.ssDataId.equals(ssDataId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.stationNum, mode: OrderingMode.desc)
      ]);

    List<SurfaceSubstrateTallyData> stations = await query.get();

    return stations.isEmpty ? 1 : stations[0].stationNum + 1;
  }

  List<String> getSsTallyColumnNames() {
    List<GeneratedColumn> cols = surfaceSubstrateTally.$columns;
    return List.generate(cols.length,
        (index) => cols[index].name.replaceAll(RegExp('_'), ' ').toUpperCase());
  }
}