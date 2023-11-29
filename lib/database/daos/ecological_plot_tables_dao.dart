import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/ecological_plot_tables.dart';

part 'ecological_plot_tables_dao.g.dart';

const List<Type> _tables = [
  EcpSummary,
  EcpHeader,
  EcpSpecies,
];

@DriftAccessor(tables: _tables)
class EcologicalPlotTablesDao extends DatabaseAccessor<Database>
    with _$EcologicalPlotTablesDaoMixin {
  EcologicalPlotTablesDao(super.db);

  void clearTables() {
    delete(ecpSummary).go();
    delete(ecpHeader).go();
    delete(ecpSpecies).go();
  }

  //====================ECP Summary====================
  Future<int> addSummary(EcpSummaryCompanion entry) =>
      into(ecpSummary).insert(entry);
  Future<EcpSummaryData> getSummary(int id) =>
      (select(ecpSummary)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<EcpSummaryData?> getSummaryWithSurveyId(int surveyId) =>
      (select(ecpSummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingleOrNull();
  Future<EcpSummaryData> addAndReturnDefaultSummary(
      int surveyId, DateTime measDate) async {
    int summaryId = await addSummary(EcpSummaryCompanion(
        surveyId: Value(surveyId), measDate: Value(measDate)));

    return await getSummary(summaryId);
  }

//====================ECP Header====================
  Future<int> addHeader(EcpHeaderCompanion entry) =>
      into(ecpHeader).insert(entry);
  Future<EcpHeaderData> getHeaderFromId(int id) =>
      (select(ecpHeader)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<List<EcpHeaderData>> getHeaderWithEcpSummryId(int ecpSId) async =>
      (select(ecpHeader)
            ..where((tbl) => tbl.ecpSummaryId.equals(ecpSId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.ecpNum, mode: OrderingMode.asc)
            ]))
          .get();

  Future<EcpHeaderData?> getEcpHeaderFromEcpNum(int ecpSId, int ecpNum) =>
      (select(ecpHeader)
            ..where((tbl) =>
                tbl.ecpSummaryId.equals(ecpSId) & tbl.ecpNum.equals(ecpNum)))
          .getSingleOrNull();

  Future<List<int>> getUsedPlotNums(int ecpSId, String plotType) async {
    if (plotType.isEmpty) {
      return [];
    }
    final query = select(ecpHeader)
      ..where((tbl) =>
          tbl.ecpSummaryId.equals(ecpSId) & tbl.plotType.equals(plotType));

    return query.map((row) => row.ecpNum ?? -1).get();
  }

  Future<List<int?>> getUsedTransNums(int ecpId) {
    final query = select(ecpHeader)
      ..where((tbl) => tbl.ecpSummaryId.equals(ecpId));
    return query.map((row) => row.ecpNum).get();
  }

//====================ECP Species====================
  Future<int> deleteSpecies(int ecpSpeciesId) =>
      (delete(ecpSpecies)..where((t) => t.id.equals(ecpSpeciesId))).go();
  Future<int> addSpecies(EcpSpeciesCompanion entry) =>
      into(ecpSpecies).insert(entry);
  Future<int> addOrUpdateSpecies(EcpSpeciesCompanion entry) =>
      into(ecpSpecies).insertOnConflictUpdate(entry);
  Future<EcpSpeciesData> getSpeciesFromId(int id) =>
      (select(ecpSpecies)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<EcpSpeciesData?> getSpeciesFromEcpHeaderId(
          int headerId, int speciesNum) =>
      (select(ecpSpecies)
            ..where((tbl) =>
                tbl.ecpHeaderId.equals(headerId) &
                tbl.speciesNum.equals(speciesNum)))
          .getSingleOrNull();
  Future<List<EcpSpeciesData>> getSpeciesList(int ecpHeaderId) =>
      (select(ecpSpecies)
            ..where((tbl) => tbl.ecpHeaderId.equals(ecpHeaderId))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.speciesNum, mode: OrderingMode.asc)
            ]))
          .get();
  Future<int> getNextSpeciesNum(int ecpHeaderId) async {
    final query = select(ecpSpecies)
      ..where((tbl) => tbl.ecpHeaderId.equals(ecpHeaderId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.speciesNum, mode: OrderingMode.desc)
      ]);

    List<EcpSpeciesData> species = await query.get();

    return species.isEmpty ? 1 : species[0].speciesNum + 1;
  }

  Future<List<String>?> getLayers(int ecpHeaderId) {
    final query = select(ecpSpecies, distinct: true)
      ..where((tbl) => tbl.ecpHeaderId.equals(ecpHeaderId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.layerId, mode: OrderingMode.desc)
      ]);

    return query.map((row) => row.layerId).get();
  }

  List<String> getSpeciesColumnNames() {
    List<GeneratedColumn> cols = ecpSpecies.$columns;
    return List.generate(cols.length,
        (index) => cols[index].name.replaceAll(RegExp('_'), ' ').toUpperCase());
  }
}
