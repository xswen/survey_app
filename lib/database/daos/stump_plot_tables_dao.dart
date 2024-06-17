import 'package:drift/drift.dart';
import 'package:survey_app/database/database_creation_files/stump_plot_tables.dart';

import '../database.dart';

part 'stump_plot_tables_dao.g.dart';

@DriftAccessor(tables: [
  StumpSummary,
  StumpEntry,
])
class StumpPlotTablesDao extends DatabaseAccessor<Database>
    with _$StumpPlotTablesDaoMixin {
  StumpPlotTablesDao(super.db);

  //====================Stump Summary Management====================

  Future<int> addStumpSummary(StumpSummaryCompanion entry) =>
      into(stumpSummary).insert(entry);

  Future<StumpSummaryData> getStumpSummary(int id) =>
      (select(stumpSummary)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<StumpSummaryData> getStumpSummaryBySurveyId(int surveyId) =>
      (select(stumpSummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();

  Future<void> updateStumpSummary(int id, StumpSummaryCompanion entry) async {
    await (update(stumpSummary)..where((tbl) => tbl.id.equals(id)))
        .write(entry);
  }

  Future<void> deleteStumpSummary(int id) async {
    await deleteStumpEntriesByStumpSummaryId(id);
    await (delete(stumpSummary)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> markNotAssessed(int surveyId, int? stumpSummaryId) async {
    if (stumpSummaryId != null) {
      await deleteStumpSummary(stumpSummaryId);
    }
    await setAndReturnDefaultSummary(surveyId, DateTime.now(),
        notAssessed: true);
  }

  Future<StumpSummaryData> setAndReturnDefaultSummary(
      int surveyId, DateTime measDate,
      {bool notAssessed = false}) async {
    StumpSummaryCompanion entry = StumpSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(measDate),
        plotType: const Value(""),
        complete: const Value(false),
        notAssessed: Value(notAssessed));

    int summaryId = await into(stumpSummary).insert(entry,
        onConflict: DoUpdate((old) => entry, target: [stumpSummary.surveyId]));

    return await getStumpSummary(summaryId);
  }

//====================Stump Entry Management====================

  Future<int> addStumpEntry(StumpEntryCompanion entry) =>
      into(stumpEntry).insert(entry);
  Future<int> addOrUpdateStumpEntry(StumpEntryCompanion entry) =>
      into(stumpEntry).insertOnConflictUpdate(entry);

  Future<StumpEntryData> getStumpEntry(int id) =>
      (select(stumpEntry)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<List<StumpEntryData>> getStumpEntryList(int stumpId) =>
      (select(stumpEntry)..where((tbl) => tbl.stumpSummaryId.equals(stumpId)))
          .get();

  Future<void> updateStumpEntry(int id, StumpEntryCompanion entry) async {
    await (update(stumpEntry)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteStumpEntry(int id) async {
    await (delete(stumpEntry)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteStumpEntriesByStumpSummaryId(int stumpSummaryId) async {
    await (delete(stumpEntry)
          ..where((tbl) => tbl.stumpSummaryId.equals(stumpSummaryId)))
        .go();
  }
}
