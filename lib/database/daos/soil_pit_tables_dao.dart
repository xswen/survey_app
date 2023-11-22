import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/soil_pit_tables.dart';

part 'soil_pit_tables_dao.g.dart';

@DriftAccessor(tables: [
  SoilPitSummary,
  SoilSiteInfo,
  SoilPitDepth,
  SoilPitFeature,
  SoilPitHorizonDescription,
])
class SoilPitTablesDao extends DatabaseAccessor<Database>
    with _$SoilPitTablesDaoMixin {
  SoilPitTablesDao(super.db);

  //For testing purposes only
  void clearTables() {
    delete(soilSiteInfo).go();
    delete(soilPitDepth).go();
    delete(soilPitFeature).go();
    delete(soilPitHorizonDescription).go();
  }

  //====================Soil Summary====================
  Future<int> addSummary(SoilPitSummaryCompanion entry) =>
      into(soilPitSummary).insert(entry);
  Future<SoilPitSummaryData> getSummary(int id) =>
      (select(soilPitSummary)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<SoilPitSummaryData> getSummaryWithSurveyId(int surveyId) =>
      (select(soilPitSummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();
  Future<SoilPitSummaryData> addAndReturnDefaultSummary(
      int surveyId, DateTime measDate) async {
    int summaryId = await addSummary(SoilPitSummaryCompanion(
        surveyId: Value(surveyId), measDate: Value(measDate)));

    return await getSummaryWithSurveyId(summaryId);
  }

//====================Soil Site Summary====================
  Future<SoilSiteInfoData?> getSiteInfoFromSummaryId(int summaryId) async {
    SoilSiteInfoData? data = await (select(soilSiteInfo)
          ..where((tbl) => tbl.soilPitSummaryId.equals(summaryId)))
        .getSingleOrNull();
    return data;
  }

  Future<int> addOrUpdateSiteInfo(SoilSiteInfoCompanion entry) =>
      into(soilSiteInfo).insertOnConflictUpdate(entry);
}
