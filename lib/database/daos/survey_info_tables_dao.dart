import 'dart:collection';

import 'package:drift/drift.dart';

import '../../enums/enums.dart';
import '../database.dart';
import '../database_creation_files/survey_info_tables.dart';

part 'survey_info_tables_dao.g.dart';

const List<Type> _tables = [
  //Survey Tables
  SurveyHeaders
];

@DriftAccessor(tables: _tables)
class SurveyInfoTablesDao extends DatabaseAccessor<Database>
    with _$SurveyInfoTablesDaoMixin {
  SurveyInfoTablesDao(super.db);

  void deleteTables() {
    delete(surveyHeaders).go();
  }

  void deleteSiteInfo(int surveyId) {
    (delete(surveyHeaders)..where((tbl) => tbl.id.equals(surveyId))).go();
  }

  void deleteSurvey(int surveyId) async {
    Database db = Database.instance;
    await db.woodyDebrisTablesDao.deleteSummaryWithSurveyId(surveyId);
    await db.surfaceSubstrateTablesDao.deleteSummaryWithSurveyId(surveyId);
    await db.ecologicalPlotTablesDao.deleteSummaryWithSurveyId(surveyId);
    await db.soilPitTablesDao.deleteSummaryWithSurveyId(surveyId);

    deleteSiteInfo(surveyId);
  }

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
}
