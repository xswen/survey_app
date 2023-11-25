import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/reference_tables.dart';
import '../database_creation_files/soil_pit_tables.dart';

part 'soil_pit_tables_dao.g.dart';

@DriftAccessor(tables: [
  SoilPitCode,
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

    return await getSummary(summaryId);
  }

//====================Soil Site Info====================
  Future<SoilSiteInfoData?> getSiteInfoFromSummaryId(int summaryId) async {
    SoilSiteInfoData? data = await (select(soilSiteInfo)
          ..where((tbl) => tbl.soilPitSummaryId.equals(summaryId)))
        .getSingleOrNull();
    return data;
  }

  Future<int> addOrUpdateSiteInfo(SoilSiteInfoCompanion entry) =>
      into(soilSiteInfo).insertOnConflictUpdate(entry);

//====================Soil Feature====================
  Future<int> addOrUpdateFeature(SoilPitFeatureCompanion entry) =>
      into(soilPitFeature).insertOnConflictUpdate(entry);

  Future<List<SoilPitFeatureData>> getFeatureList(int summaryId) =>
      (select(soilPitFeature)
            ..where((tbl) => tbl.soilPitSummaryId.equals(summaryId)))
          .get();

  Future<SoilPitFeatureData> getFeature(int featureId) =>
      (select(soilPitFeature)..where((tbl) => tbl.id.equals(featureId)))
          .getSingle();

  Future<List<String>> getFeatureUsedPlotCodeNameList(int summaryId) async {
    List<String> codes = await (select(soilPitFeature)
          ..where((tbl) => tbl.soilPitSummaryId.equals(summaryId)))
        .map((p0) => p0.soilPitCodeField)
        .get();

    List<String> results = [];
    for (String code in codes) {
      String codeName = await (select(soilPitCode, distinct: true)
            ..where((tbl) => tbl.code.equals(code)))
          .map((row) => row.name)
          .getSingle();
      results.add(codeName);
    }

    return results;
  }

  //====================Soil Horizon====================
  Future<int> addOrUpdateHorizon(SoilPitHorizonDescriptionCompanion entry) =>
      into(soilPitHorizonDescription).insertOnConflictUpdate(entry);

  Future<List<SoilPitHorizonDescriptionData>> getHorizonList(int summaryId) =>
      (select(soilPitHorizonDescription)
            ..where((tbl) => tbl.soilPitSummaryId.equals(summaryId)))
          .get();

  Future<SoilPitHorizonDescriptionData> getHorizon(int horizonId) =>
      (select(soilPitHorizonDescription)
            ..where((tbl) => tbl.id.equals(horizonId)))
          .getSingle();

  // Future<List<String>> getHorizonUsedPlotCodeNameList(int summaryId) async {
  //   List<String> codes = await (select(soilPitHorizonDescription)
  //         ..where((tbl) => tbl.soilPitSummaryId.equals(summaryId)))
  //       .map((p0) => p0.soilPitCodeField)
  //       .get();
  //
  //   List<String> results = [];
  //   for (String code in codes) {
  //     String codeName = await (select(soilPitCodeField, distinct: true)
  //           ..where((tbl) => tbl.code.equals(code)))
  //         .map((row) => row.name)
  //         .getSingle();
  //     results.add(codeName);
  //   }
  //
  //   return results;
  // }

  Future<bool> checkHorizonNumAvailable(
      int summaryId, String pitCode, int horNum) async {
    SoilPitHorizonDescriptionData? exists =
        await (select(soilPitHorizonDescription)
              ..where((tbl) =>
                  tbl.soilPitSummaryId.equals(summaryId) &
                  tbl.soilPitCodeField.equals(pitCode) &
                  tbl.horizonNum.equals(horNum)))
            .getSingleOrNull();

    return exists == null;
  }
}
