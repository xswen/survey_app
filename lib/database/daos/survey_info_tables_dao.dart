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

  Future<void> markNotAssessed(int surveyId) async {
    var tmp = await deleteSurveyHeaderInfo(surveyId);

    int tmp2 = await addSummary(SurveySummaryCompanion(
        surveyId: Value(surveyId), notAssessed: const Value(true)));
  }

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
    await deleteSurveyHeaderInfo(surveyId);

    deleteSiteInfo(surveyId);
  }

  Future<void> deleteSurveyHeaderInfo(int surveyId) async {
    await (delete(surveySummary)..where((tbl) => tbl.surveyId.equals(surveyId)))
        .go();
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

  //===========================Survey Summary=====================================
  Future<int> addSummary(SurveySummaryCompanion entry) =>
      into(surveySummary).insert(entry);

  Future<SurveySummaryData> getSummary(int id) =>
      (select(surveySummary)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<SurveySummaryData> setAndReturnDefaultSummary(int surveyId) async {
    SurveySummaryCompanion entry = SurveySummaryCompanion(
        surveyId: Value(surveyId),
        complete: const Value(false),
        notAssessed: const Value(false));

    int summaryId = await into(surveySummary).insert(entry,
        onConflict: DoUpdate((old) => entry, target: [surveySummary.surveyId]));

    return await getSummary(summaryId);
  }

//===========================Ground Photos=====================================
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

    if (groundPhoto.plotPin) photoList.add("Plot Pin (Center)");
    if (groundPhoto.transectOneFifteenUnder) {
      photoList.add("Transect 1 (0-15m)");
    }
    if (groundPhoto.transectOneFifteenOver) {
      photoList.add("Transect 1 (15-30m)");
    }
    if (groundPhoto.transectTwoFifteenUnder) {
      photoList.add("Transect 2 (0-15m)");
    }
    if (groundPhoto.transectTwoFifteenOver) {
      photoList.add("Transect 2 (15-30m)");
    }
    if (groundPhoto.horizontal) photoList.add("Horizontal");
    if (groundPhoto.canopy) photoList.add("Canopy");
    if (groundPhoto.soilProfile) photoList.add("Soil Profile");
    if (groundPhoto.otherOne) photoList.add("Other1 (describe)");
    if (groundPhoto.otherTwo) photoList.add("Other2 (describe)");
    if (groundPhoto.otherThree) photoList.add("Other3 (describe)");
    if (groundPhoto.otherFour) photoList.add("Other4 (describe)");

    return photoList;
  }

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
}
