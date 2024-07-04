import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/site_info_tables.dart';

part 'site_info_tables_dao.g.dart';

@DriftAccessor(tables: [
  GpSummary,
  GpSiteInfo,
  GpDisturbance,
  GpOrigin,
  GpTreatment,
])
class SiteInfoTablesDao extends DatabaseAccessor<Database>
    with _$SiteInfoTablesDaoMixin {
  SiteInfoTablesDao(super.db);

  Future<int> addGpSummary(GpSummaryCompanion entry) =>
      into(gpSummary).insert(entry);

  Future<GpSummaryData> getSummary(int id) =>
      (select(gpSummary)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<GpSummaryData> getGpSummaryBySurveyId(int surveyId) =>
      (select(gpSummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();

  Future<void> updateGpSummary(int id, GpSummaryCompanion entry) async {
    await (update(gpSummary)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteGpSummary(int id) async {
    await deleteAllGpDisturbance(id);
    await deleteAllGpOrigin(id);
    await deleteAllGpTreatment(id);
    await deleteGpSiteInfo(id);
    await (delete(gpSiteInfo)..where((tbl) => tbl.gpSummaryId.equals(id))).go();
  }

  Future<void> markNotAssessed(int surveyId, int? gpSummaryId) async {
    if (gpSummaryId != null) {
      await deleteGpSummary(gpSummaryId);
    }

    await setAndReturnDefaultSummary(surveyId, DateTime.now(),
        notAssessed: true);
  }

  Future<GpSummaryData> setAndReturnDefaultSummary(
      int surveyId, DateTime measDate,
      {bool notAssessed = false}) async {
    GpSummaryCompanion entry = GpSummaryCompanion(
        surveyId: Value(surveyId),
        measDate: Value(measDate),
        complete: const Value(false),
        notAssessed: Value(notAssessed));

    await into(gpSummary).insert(entry,
        onConflict: DoUpdate((old) => entry, target: [gpSummary.surveyId]));

    return getGpSummaryBySurveyId(surveyId);
  }

  //====================Gp Site Info Management====================

  Future<int> addOrUpdateGpSiteInfo(GpSiteInfoCompanion entry) =>
      into(gpSiteInfo).insertOnConflictUpdate(entry);

  Future<GpSiteInfoData?> getGpSiteInfoFromSummaryId(int id) =>
      (select(gpSiteInfo)..where((tbl) => tbl.gpSummaryId.equals(id)))
          .getSingleOrNull();

  Future<GpSiteInfoData> getGpSiteInfo(int id) =>
      (select(gpSiteInfo)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateGpSiteInfo(int id, GpSiteInfoCompanion entry) async {
    await (update(gpSiteInfo)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteGpSiteInfo(int id) async {
    await (delete(gpSiteInfo)..where((tbl) => tbl.id.equals(id))).go();
  }

//====================Gp Disturbance Management====================

  Future<int> addGpDisturbance(GpDisturbanceCompanion entry) =>
      into(gpDisturbance).insert(entry);

  Future<int> addorUpdateGpDisturbance(GpDisturbanceCompanion entry) =>
      into(gpDisturbance).insertOnConflictUpdate(entry);

  Future<GpDisturbanceData> getGpDisturbance(int id) =>
      (select(gpDisturbance)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateGpDisturbance(int id, GpDisturbanceCompanion entry) async {
    await (update(gpDisturbance)..where((tbl) => tbl.id.equals(id)))
        .write(entry);
  }

  Future<void> deleteGpDisturbance(int id) async {
    await (delete(gpDisturbance)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<GpDisturbanceData>> getGpDisturbanceList(int gpSummaryId) =>
      (select(gpDisturbance)
            ..where((tbl) => tbl.gpSummaryId.equals(gpSummaryId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc)
            ]))
          .get();

  Future<void> deleteAllGpDisturbance(int gpSummaryId) async {
    await (delete(gpDisturbance)
          ..where((tbl) => tbl.gpSummaryId.equals(gpSummaryId)))
        .go();
  }

//====================Gp Origin Management====================

  Future<int> addGpOrigin(GpOriginCompanion entry) =>
      into(gpOrigin).insert(entry);

  Future<GpOriginData> getGpOrigin(int id) =>
      (select(gpOrigin)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateGpOrigin(int id, GpOriginCompanion entry) async {
    await (update(gpOrigin)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteGpOrigin(int id) async {
    await (delete(gpOrigin)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<GpOriginData>> getGpOriginList(int gpSummaryId) =>
      (select(gpOrigin)
            ..where((tbl) => tbl.gpSummaryId.equals(gpSummaryId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc)
            ]))
          .get();

  Future<void> deleteAllGpOrigin(int gpSummaryId) async {
    await (delete(gpOrigin)
          ..where((tbl) => tbl.gpSummaryId.equals(gpSummaryId)))
        .go();
  }

//====================Gp Treatment Management====================

  Future<int> addGpTreatment(GpTreatmentCompanion entry) =>
      into(gpTreatment).insert(entry);

  Future<GpTreatmentData> getGpTreatment(int id) =>
      (select(gpTreatment)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<void> updateGpTreatment(int id, GpTreatmentCompanion entry) async {
    await (update(gpTreatment)..where((tbl) => tbl.id.equals(id))).write(entry);
  }

  Future<void> deleteGpTreatment(int id) async {
    await (delete(gpTreatment)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<GpTreatmentData>> getGpTreatmentList(int gpSummaryId) =>
      (select(gpTreatment)
            ..where((tbl) => tbl.gpSummaryId.equals(gpSummaryId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc)
            ]))
          .get();

  Future<void> deleteAllGpTreatment(int gpSummaryId) async {
    await (delete(gpTreatment)
          ..where((tbl) => tbl.gpSummaryId.equals(gpSummaryId)))
        .go();
  }
}
