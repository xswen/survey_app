import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/large_tree_plot_tables.dart';

part 'large_tree_plot_tables_dao.g.dart';

@DriftAccessor(tables: [
  LtpSummary,
  LtpTree,
  LtpTreeDamage,
  LtpTreeRemoved,
  LtpTreeAge,
  LtpTreeRenamed,
])
class LargeTreePlotTablesDao extends DatabaseAccessor<Database>
    with _$LargeTreePlotTablesDaoMixin {
  LargeTreePlotTablesDao(super.db);

  //====================Mark Not Assessed for Ltp Summary====================

  Future<void> markLtpNotAssessed(int surveyId, int? ltpSummaryId) async {
    if (ltpSummaryId != null) {
      await deleteLtpSummary(ltpSummaryId);
    }
    await addLtpSummary(LtpSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(DateTime.now()),
        notAssessed: const Value(true),
        complete: const Value(false)));
  }

  //====================Ltp Summary Management====================

  Future<int> addLtpSummary(LtpSummaryCompanion entry) =>
      into(ltpSummary).insert(entry);

  Future<LtpSummaryData> getLtpSummary(int id) =>
      (select(ltpSummary)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<LtpSummaryData> getLtpSummaryBySurveyId(int surveyId) =>
      (select(ltpSummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();

  Future<void> updateLtpSummary(int id, LtpSummaryCompanion entry) async {
    await (update(ltpSummary)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteLtpSummary(int ltpSummaryId) async {
    await (delete(ltpTree)
          ..where((tbl) => tbl.lptSummaryId.equals(ltpSummaryId)))
        .go();
    await (delete(ltpTreeDamage)
          ..where((tbl) => tbl.lptSummaryId.equals(ltpSummaryId)))
        .go();
    await (delete(ltpTreeRemoved)
          ..where((tbl) => tbl.lptSummaryId.equals(ltpSummaryId)))
        .go();
    await (delete(ltpTreeAge)
          ..where((tbl) => tbl.lptSummaryId.equals(ltpSummaryId)))
        .go();
    await (delete(ltpTreeRenamed)
          ..where((tbl) => tbl.lptSummaryId.equals(ltpSummaryId)))
        .go();
    // Finally, delete the LtpSummary itself
    await (delete(ltpSummary)..where((tbl) => tbl.id.equals(ltpSummaryId)))
        .go();
  }
//====================Ltp Tree Management====================

  Future<int> addLtpTree(LtpTreeCompanion entry) => into(ltpTree).insert(entry);

  Future<LtpTreeData> getLtpTree(int id) =>
      (select(ltpTree)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateLtpTree(int id, LtpTreeCompanion entry) async {
    await (update(ltpTree)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteLtpTree(int id) async {
    await (delete(ltpTree)..where((tbl) => tbl.id.equals(id))).go();
  }

//====================Ltp Tree Damage Management====================

  Future<int> addLtpTreeDamage(LtpTreeDamageCompanion entry) =>
      into(ltpTreeDamage).insert(entry);

  Future<LtpTreeDamageData> getLtpTreeDamage(int id) =>
      (select(ltpTreeDamage)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateLtpTreeDamage(int id, LtpTreeDamageCompanion entry) async {
    await (update(ltpTreeDamage)..where((tbl) => tbl.id.equals(id)))
        .write(entry);
  }

  Future<void> deleteLtpTreeDamage(int id) async {
    await (delete(ltpTreeDamage)..where((tbl) => tbl.id.equals(id))).go();
  }

//====================Ltp Tree Removed Management====================

  Future<int> addLtpTreeRemoved(LtpTreeRemovedCompanion entry) =>
      into(ltpTreeRemoved).insert(entry);

  Future<LtpTreeRemovedData> getLtpTreeRemoved(int id) =>
      (select(ltpTreeRemoved)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateLtpTreeRemoved(
      int id, LtpTreeRemovedCompanion entry) async {
    await (update(ltpTreeRemoved)..where((tbl) => tbl.id.equals(id)))
        .write(entry);
  }

  Future<void> deleteLtpTreeRemoved(int id) async {
    await (delete(ltpTreeRemoved)..where((tbl) => tbl.id.equals(id))).go();
  }

//====================Ltp Tree Age Management====================

  Future<int> addLtpTreeAge(LtpTreeAgeCompanion entry) =>
      into(ltpTreeAge).insert(entry);

  Future<LtpTreeAgeData> getLtpTreeAge(int id) =>
      (select(ltpTreeAge)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateLtpTreeAge(int id, LtpTreeAgeCompanion entry) async {
    await (update(ltpTreeAge)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteLtpTreeAge(int id) async {
    await (delete(ltpTreeAge)..where((tbl) => tbl.id.equals(id))).go();
  }

//====================Ltp Tree Renamed Management====================

  Future<int> addLtpTreeRenamed(LtpTreeRenamedCompanion entry) =>
      into(ltpTreeRenamed).insert(entry);

  Future<LtpTreeRenamedData> getLtpTreeRenamed(int id) =>
      (select(ltpTreeRenamed)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateLtpTreeRenamed(
      int id, LtpTreeRenamedCompanion entry) async {
    await (update(ltpTreeRenamed)..where((tbl) => tbl.id.equals(id)))
        .write(entry);
  }

  Future<void> deleteLtpTreeRenamed(int id) async {
    await (delete(ltpTreeRenamed)..where((tbl) => tbl.id.equals(id))).go();
  }
}
