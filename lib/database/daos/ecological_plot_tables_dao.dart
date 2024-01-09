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

  Future<void> markNotAssessed(int surveyId, int? ecpId) async {
    if (ecpId != null) {
      var tmp = await deleteEcpSummary(ecpId);
    }

    int tmp2 = await addSummary(EcpSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(DateTime.now()),
        notAssessed: const Value(true)));
  }

  //====================Deletion====================
  Future<void> deleteSummaryWithSurveyId(int id) async {
    EcpSummaryData? summary = await (select(ecpSummary)
          ..where((tbl) => tbl.surveyId.equals(id)))
        .getSingleOrNull();

    summary != null ? deleteEcpSummary(summary.id) : null;
  }

  Future<void> deleteEcpSummary(int id) async {
    final headers = await getHeaderWithEcpSummaryId(id);
    for (final header in headers) {
      deleteEcpHeader(header.id);
    }

    await (delete(ecpSummary)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteEcpHeader(int id) async {
    await (delete(ecpSpecies)..where((t) => t.ecpHeaderId.equals(id))).go();
    await (delete(ecpHeader)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteSpecies(int ecpSpeciesId) =>
      (delete(ecpSpecies)..where((t) => t.id.equals(ecpSpeciesId))).go();

  //====================ECP Summary====================
  Future<int> addSummary(EcpSummaryCompanion entry) =>
      into(ecpSummary).insert(entry);
  Future<EcpSummaryData> getSummary(int id) =>
      (select(ecpSummary)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<EcpSummaryData?> getSummaryWithSurveyId(int surveyId) =>
      (select(ecpSummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingleOrNull();

  Future<EcpSummaryData> setAndReturnDefaultSummary(
      int surveyId, DateTime measDate) async {
    EcpSummaryCompanion entry = EcpSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(measDate),
        complete: const Value(false),
        notAssessed: const Value(false));
    int summaryId = await into(ecpSummary).insert(entry,
        onConflict: DoUpdate((old) => entry, target: [ecpSummary.surveyId]));

    return await getSummary(summaryId);
  }

//====================ECP Header====================
  Future<int> addHeader(EcpHeaderCompanion entry) =>
      into(ecpHeader).insert(entry);

  Future<EcpHeaderData> getHeaderFromId(int id) =>
      (select(ecpHeader)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<bool> ecpPlotAvailable(int ecpSummaryId) async {
    List<EcpHeaderData> headers = await (select(ecpHeader)
          ..where((tbl) => tbl.ecpSummaryId.equals(ecpSummaryId)))
        .get();

    //3 plot types, allowed 16 plots per plot type
    return headers.length < 48;
  }

  Future<List<EcpHeaderData>> getHeaderWithEcpSummaryId(int ecpSId) async =>
      (select(ecpHeader)
            ..where((tbl) => tbl.ecpSummaryId.equals(ecpSId))
            ..orderBy([
              (t) =>
                  OrderingTerm(expression: t.plotType, mode: OrderingMode.asc),
              (t) => OrderingTerm(expression: t.ecpNum, mode: OrderingMode.asc),
            ]))
          .get();

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
