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
    await addStumpSummary(StumpSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(DateTime.now()),
        notAssessed: const Value(true),
        complete: const Value(false)));
  }

  Future<StumpSummaryData> setAndReturnDefaultStumpSummary(
      int surveyId, DateTime measDate) async {
    StumpSummaryCompanion entry = StumpSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(measDate),
        complete: const Value(false),
        notAssessed: const Value(false));

    int summaryId = await into(stumpSummary).insert(entry,
        onConflict: DoUpdate((old) => entry, target: [stumpSummary.surveyId]));

    return await getStumpSummary(summaryId);
  }

//====================Stump Entry Management====================

  Future<int> addStumpEntry(StumpEntryCompanion entry) =>
      into(stumpEntry).insert(entry);

  Future<StumpEntryData> getStumpEntry(int id) =>
      (select(stumpEntry)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateStumpEntry(int id, StumpEntryCompanion entry) async {
    await (update(stumpEntry)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteStumpEntry(int id) async {
    await (delete(stumpEntry)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteStumpEntriesByStumpSummaryId(int stumpSummaryId) async {
    await (delete(stumpEntry)
          ..where((tbl) => tbl.shrubSummaryId.equals(stumpSummaryId)))
        .go();
  }
}
