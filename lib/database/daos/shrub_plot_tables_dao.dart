import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/shrub_plot_tables.dart';

part 'shrub_plot_tables_dao.g.dart';

@DriftAccessor(tables: [
  ShrubSummary,
  ShrubListEntry,
])
class ShrubPlotTablesDao extends DatabaseAccessor<Database>
    with _$ShrubPlotTablesDaoMixin {
  ShrubPlotTablesDao(super.db);

  //====================Shrub Summary Management====================

  Future<int> addShrubSummary(ShrubSummaryCompanion entry) =>
      into(shrubSummary).insert(entry);

  Future<ShrubSummaryData> getShrubSummary(int id) =>
      (select(shrubSummary)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<ShrubSummaryData> getShrubSummaryBySurveyId(int surveyId) =>
      (select(shrubSummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();

  Future<void> updateShrubSummary(int id, ShrubSummaryCompanion entry) async {
    await (update(shrubSummary)..where((tbl) => tbl.id.equals(id)))
        .write(entry);
  }

  Future<void> deleteShrubSummary(int id) async {
    await deleteShrubListEntriesByShrubSummaryId(id);
    await (delete(shrubSummary)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> markNotAssessed(int surveyId, int? shrubSummaryId) async {
    if (shrubSummaryId != null) {
      await deleteShrubSummary(shrubSummaryId);
    }
    await setAndReturnDefaultSummary(surveyId, DateTime.now(),
        notAssessed: true);
  }

  Future<ShrubSummaryData> setAndReturnDefaultSummary(
      int surveyId, DateTime measDate,
      {bool notAssessed = false}) async {
    ShrubSummaryCompanion entry = ShrubSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(measDate),
        plotType: const Value(""),
        complete: const Value(false),
        notAssessed: Value(notAssessed));

    int summaryId = await into(shrubSummary).insert(entry,
        onConflict: DoUpdate((old) => entry, target: [shrubSummary.surveyId]));

    return await getShrubSummary(summaryId);
  }

//====================Shrub Lists (Single Entry) Management====================
  Future<List<ShrubListEntryData>> getShrubEntryList(int shrubId) =>
      (select(shrubListEntry)
            ..where((tbl) => tbl.shrubSummaryId.equals(shrubId)))
          .get();

  Future<int> addShrubListEntry(ShrubListEntryCompanion entry) =>
      into(shrubListEntry).insert(entry);

  Future<int> addOrUpdateShrubListEntry(ShrubListEntryCompanion entry) =>
      into(shrubListEntry).insertOnConflictUpdate(entry);

  Future<ShrubListEntryData> getShrubListEntry(int id) =>
      (select(shrubListEntry)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateShrubListEntry(
      int id, ShrubListEntryCompanion entry) async {
    await (update(shrubListEntry)..where((tbl) => tbl.id.equals(id)))
        .write(entry);
  }

  Future<void> deleteShrubListEntry(int id) async {
    await (delete(shrubListEntry)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteShrubListEntriesByShrubSummaryId(
      int shrubSummaryId) async {
    await (delete(shrubListEntry)
          ..where((tbl) => tbl.shrubSummaryId.equals(shrubSummaryId)))
        .go();
  }
}
