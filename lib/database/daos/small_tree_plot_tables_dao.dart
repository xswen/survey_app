import 'package:drift/drift.dart';
import 'package:survey_app/database/database_creation_files/small_tree_plot_tables.dart';

import '../database.dart';

part 'small_tree_plot_tables_dao.g.dart';

@DriftAccessor(tables: [
  StpSummary,
  StpSpecies,
])
class SmallTreePlotTablesDao extends DatabaseAccessor<Database>
    with _$SmallTreePlotTablesDaoMixin {
  SmallTreePlotTablesDao(super.db);

  //====================Stp Summary Management====================

  Future<int> addStpSummary(StpSummaryCompanion entry) =>
      into(stpSummary).insert(entry);

  Future<StpSummaryData> getStpSummary(int id) =>
      (select(stpSummary)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<StpSummaryData> getStpSummaryBySurveyId(int surveyId) =>
      (select(stpSummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();

  Future<void> updateStpSummary(int id, StpSummaryCompanion entry) async {
    await (update(stpSummary)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteStpSummary(int id) async {
    await deleteStpSpeciesByStpSummaryId(id);
    await (delete(stpSummary)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> markNotAssessed(int surveyId, int? stpSummaryId) async {
    if (stpSummaryId != null) {
      await deleteStpSummary(stpSummaryId);
    }

    await setAndReturnDefaultSummary(surveyId, DateTime.now(),
        notAssessed: true);
    // await addStpSummary(StpSummaryCompanion(
    //     surveyId: Value(surveyId),
    //     measDate: Value(DateTime.now()),
    //     notAssessed: const Value(true),
    //     complete: const Value(false)));
  }

  Future<StpSummaryData> setAndReturnDefaultSummary(
      int surveyId, DateTime measDate,
      {bool notAssessed = false}) async {
    StpSummaryCompanion entry = StpSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(measDate),
        plotType: const Value(""),
        complete: const Value(false),
        notAssessed: Value(notAssessed));

    int summaryId = await into(stpSummary).insert(entry,
        onConflict: DoUpdate((old) => entry, target: [stpSummary.surveyId]));

    return await getStpSummary(summaryId);
  }

//====================Stp Species Management====================

  Future<int> addStpSpecies(StpSpeciesCompanion entry) =>
      into(stpSpecies).insert(entry);

  Future<StpSpeciesData> getStpSpecies(int id) =>
      (select(stpSpecies)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateStpSpecies(int id, StpSpeciesCompanion entry) async {
    await (update(stpSpecies)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteStpSpecies(int id) async {
    await (delete(stpSpecies)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteStpSpeciesByStpSummaryId(int stpSummaryId) async {
    await (delete(stpSpecies)
          ..where((tbl) => tbl.stpSummaryId.equals(stpSummaryId)))
        .go();
  }
}
