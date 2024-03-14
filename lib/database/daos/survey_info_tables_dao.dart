import 'dart:collection';

import 'package:drift/drift.dart';

import '../../enums/enums.dart';
import '../database.dart';
import '../database_creation_files/survey_info_tables.dart';

part 'survey_info_tables_dao.g.dart';

const List<Type> _tables = [
  SurveyHeaders,
  SurveySummary,
  SurveyHeaderGroundPhoto,
  SurveyHeaderTree,
  SurveyHeaderEcological,
  SurveyHeaderSoil,
];

@DriftAccessor(tables: _tables)
class SurveyInfoTablesDao extends DatabaseAccessor<Database>
    with _$SurveyInfoTablesDaoMixin {
  SurveyInfoTablesDao(super.db);

  //===========================Deletion====================================
  void deleteTables() {
    delete(surveyHeaders).go();
  }

  void deleteSiteInfo(int surveyId) {
    (delete(surveyHeaders)..where((tbl) => tbl.id.equals(surveyId))).go();
  }

  Future<void> deleteSurvey(int surveyId) async {
    Database db = Database.instance;
    await db.woodyDebrisTablesDao.deleteSummaryWithSurveyId(surveyId);
    await db.surfaceSubstrateTablesDao.deleteSummaryWithSurveyId(surveyId);
    await db.ecologicalPlotTablesDao.deleteSummaryWithSurveyId(surveyId);
    await db.soilPitTablesDao.deleteSummaryWithSurveyId(surveyId);
    await deleteSurveySummaryBySurveyId(surveyId);

    deleteSiteInfo(surveyId);
  }

  //===========================Survey Header====================================
  Future<int> addSurvey(SurveyHeadersCompanion entry) =>
      into(surveyHeaders).insert(entry);

  Future<List<SurveyHeader>> get allSurveys => select(surveyHeaders).get();

  Future<List<SurveyHeader>> getSurveysFiltered(HashSet<SurveyStatus> filters) {
    List<bool> filtersList = [];
    if (filters.isEmpty) {
      filtersList = [true, false];
    } else {
      if (filters.contains(SurveyStatus.complete)) filtersList.add(true);
      if (filters.contains(SurveyStatus.inProgress)) filtersList.add(false);
    }
    return (select(surveyHeaders)
          ..where((tbl) => tbl.complete.isIn(filtersList)))
        .get();
  }

  Future<SurveyHeader> getSurvey(int id) {
    return (select(surveyHeaders)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<int?> checkSurveyExists(SurveyHeadersCompanion survey) async {
    SurveyHeader? exists = await (select(surveyHeaders)
          ..where((tbl) => (tbl.nfiPlot.equals(survey.nfiPlot.value) &
              tbl.measNum.equals(survey.measNum.value))))
        .getSingleOrNull();

    return exists?.id;
  }

  Future<int?> getSecondLargestMeasNum(int nfiPlotNum) async {
    List<SurveyHeader> surveys = await (select(surveyHeaders)
          ..where((tbl) => tbl.nfiPlot.equals(nfiPlotNum))
          ..orderBy([
            (u) => OrderingTerm(mode: OrderingMode.desc, expression: u.measNum)
          ]))
        .get();

    return surveys.length < 2 ? null : surveys[1].measNum;
  }

  //====================Survey Summary Management====================

  Future<SurveySummaryData> setAndReturnDefaultSummary(int surveyId) async {
    SurveySummaryCompanion entry = SurveySummaryCompanion(
        surveyId: Value(surveyId),
        complete: const Value(false),
        notAssessed: const Value(false));

    int summaryId = await into(surveySummary).insert(entry,
        onConflict: DoUpdate((old) => entry, target: [surveySummary.surveyId]));

    return await getSurveySummary(summaryId);
  }

  Future<int> addSurveySummary(SurveySummaryCompanion entry) =>
      into(surveySummary).insert(entry);

  Future<SurveySummaryData> getSurveySummary(int id) =>
      (select(surveySummary)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<SurveySummaryData> getSummaryFromSurveyId(int id) =>
      (select(surveySummary)..where((tbl) => tbl.surveyId.equals(id)))
          .getSingle();

  Future<void> updateSurveySummary(SurveySummaryCompanion entry) async {
    await (update(surveySummary)..where((tbl) => tbl.id.equals(entry.id.value)))
        .write(entry);
  }

  Future<void> deleteSurveySummaryBySurveyId(int surveyId) async {
    await (delete(surveyHeaderGroundPhoto)
          ..where((tbl) => tbl.surveyId.equals(surveyId)))
        .go();
    await (delete(surveyHeaderTree)
          ..where((tbl) => tbl.surveyId.equals(surveyId)))
        .go();
    await (delete(surveyHeaderEcological)
          ..where((tbl) => tbl.surveyId.equals(surveyId)))
        .go();
    await (delete(surveyHeaderSoil)
          ..where((tbl) => tbl.surveyId.equals(surveyId)))
        .go();
    await (delete(surveySummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
        .go();
  }

  Future<void> markNotAssessed(int surveyId, int? summaryId) async {
    if (summaryId != null) {
      await deleteSurveySummaryBySurveyId(summaryId);
    }
    await addSurveySummary(SurveySummaryCompanion(
        surveyId: Value(surveyId),
        notAssessed: const Value(true),
        complete: const Value(false)));
  }

//====================Survey Header Ground Photo Management====================

  Future<int> addGroundPhoto(SurveyHeaderGroundPhotoCompanion entry) =>
      into(surveyHeaderGroundPhoto).insert(entry);

  Future<SurveyHeaderGroundPhotoData> getGroundPhotosFromSurveyId(
      int surveyId) async {
    SurveyHeaderGroundPhotoData? gp = await (select(surveyHeaderGroundPhoto)
          ..where((tbl) => tbl.surveyId.equals(surveyId)))
        .getSingleOrNull();

    if (gp == null) {
      into(surveyHeaderGroundPhoto)
          .insert(SurveyHeaderGroundPhotoCompanion(surveyId: Value(surveyId)));
    }

    return gp ??
        await (select(surveyHeaderGroundPhoto)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingle();
  }

  Future<List<String>> getListGroundPlotPhoto(int surveyId) async {
    List<String> photoList = [];
    SurveyHeaderGroundPhotoData groundPhoto =
        await getGroundPhotosFromSurveyId(surveyId);

    if (groundPhoto.plotPin ?? false) photoList.add("Plot Pin (Center)");
    if (groundPhoto.transectOneFifteenUnder ?? false) {
      photoList.add("Transect 1 (0-15m)");
    }
    if (groundPhoto.transectOneFifteenOver ?? false) {
      photoList.add("Transect 1 (15-30m)");
    }
    if (groundPhoto.transectTwoFifteenUnder ?? false) {
      photoList.add("Transect 2 (0-15m)");
    }
    if (groundPhoto.transectTwoFifteenOver ?? false) {
      photoList.add("Transect 2 (15-30m)");
    }
    if (groundPhoto.horizontal ?? false) photoList.add("Horizontal");
    if (groundPhoto.canopy ?? false) photoList.add("Canopy");
    if (groundPhoto.soilProfile ?? false) photoList.add("Soil Profile");
    if (groundPhoto.otherOne ?? false) photoList.add("Other1 (describe)");
    if (groundPhoto.otherTwo ?? false) photoList.add("Other2 (describe)");
    if (groundPhoto.otherThree ?? false) photoList.add("Other3 (describe)");
    if (groundPhoto.otherFour ?? false) photoList.add("Other4 (describe)");

    return photoList;
  }

//
  Future<void> updateGroundPhoto(int surveyId, List<String> photos) async {
    int groundId = (await getGroundPhotosFromSurveyId(surveyId)).id;
    SurveyHeaderGroundPhotoCompanion gp = SurveyHeaderGroundPhotoCompanion(
        id: Value(groundId), surveyId: Value(surveyId));

    for (final photo in photos) {
      switch (photo) {
        case "Plot Pin (Center)":
          gp = gp.copyWith(plotPin: const Value(true));
          break;
        case "Transect 1 (0-15m)":
          gp = gp.copyWith(transectOneFifteenUnder: const Value(true));
          break;
        case "Transect 1 (15-30m)":
          gp = gp.copyWith(transectOneFifteenOver: const Value(true));
          break;
        case "Transect 2 (0-15m)":
          gp = gp.copyWith(transectTwoFifteenUnder: const Value(true));
          break;
        case "Transect 2 (15-30m)":
          gp = gp.copyWith(transectTwoFifteenOver: const Value(true));
          break;
        case "Horizontal":
          gp = gp.copyWith(horizontal: const Value(true));
          break;
        case "Canopy":
          gp = gp.copyWith(canopy: const Value(true));
          break;
        case "Soil Profile":
          gp = gp.copyWith(soilProfile: const Value(true));
          break;
        case "Other1 (describe)":
          gp = gp.copyWith(otherOne: const Value(true));
          break;
        case "Other2 (describe)":
          gp = gp.copyWith(otherTwo: const Value(true));
          break;
        case "Other3 (describe)":
          gp = gp.copyWith(otherThree: const Value(true));
          break;
        case "Other4 (describe)":
          gp = gp.copyWith(otherFour: const Value(true));
          break;
      }
    }

    await update(surveyHeaderGroundPhoto).replace(gp);
  }

//====================Survey Header Tree Management====================

  Future<int> addTree(SurveyHeaderTreeCompanion entry) =>
      into(surveyHeaderTree).insert(entry);

  Future<SurveyHeaderTreeData> getTreeDataFromSurveyId(int surveyId) async {
    SurveyHeaderTreeData? data = await (select(surveyHeaderTree)
          ..where((tbl) => tbl.surveyId.equals(surveyId)))
        .getSingleOrNull();
    if (data == null) {
      into(surveyHeaderTree)
          .insert(SurveyHeaderTreeCompanion(surveyId: Value(surveyId)));
    }
    return data ??
        await (select(surveyHeaderTree)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingle();
  }

  Future<void> updateTree(SurveyHeaderTreeCompanion entry) async {
    await (update(surveyHeaderTree)
          ..where((tbl) => tbl.id.equals(entry.id.value)))
        .write(entry);
  }

//====================Survey Header Ecological Management====================

  Future<int> addEcological(SurveyHeaderEcologicalCompanion entry) =>
      into(surveyHeaderEcological).insert(entry);

  Future<SurveyHeaderEcologicalData> getEcologicalDataFromSurveyId(
      int surveyId) async {
    SurveyHeaderEcologicalData? data = await (select(surveyHeaderEcological)
          ..where((tbl) => tbl.surveyId.equals(surveyId)))
        .getSingleOrNull();

    if (data == null) {
      into(surveyHeaderEcological)
          .insert(SurveyHeaderEcologicalCompanion(surveyId: Value(surveyId)));
    }
    return data ??
        await (select(surveyHeaderEcological)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingle();
  }

  Future<void> updateEcological(SurveyHeaderEcologicalCompanion entry) async {
    await (update(surveyHeaderEcological)
          ..where((tbl) => tbl.id.equals(entry.id.value)))
        .write(entry);
  }

//====================Survey Header Soil Management====================

  Future<int> addSoil(SurveyHeaderSoilCompanion entry) =>
      into(surveyHeaderSoil).insert(entry);

  Future<SurveyHeaderSoilData> getSoilDataFromSurveyId(int surveyId) async {
    SurveyHeaderSoilData? data = await (select(surveyHeaderSoil)
          ..where((tbl) => tbl.surveyId.equals(surveyId)))
        .getSingleOrNull();

    if (data == null) {
      into(surveyHeaderSoil)
          .insert(SurveyHeaderSoilCompanion(surveyId: Value(surveyId)));
    }
    return data ??
        await (select(surveyHeaderSoil)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingle();
  }

  Future<void> updateSoil(SurveyHeaderSoilCompanion entry) async {
    await (update(surveyHeaderSoil)
          ..where((tbl) => tbl.id.equals(entry.id.value)))
        .write(entry);
  }
}
