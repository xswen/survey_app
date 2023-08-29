import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/survey_info_tables.dart';

part 'survey_info_tables_dao.g.dart';

const List<Type> _tables = [
  //Survey Tables
  SurveyHeaders,
];

@DriftAccessor(tables: _tables)
class SurveyInfoTablesDao extends DatabaseAccessor<Database>
    with _$SurveyInfoTablesDaoMixin {
  SurveyInfoTablesDao(Database db) : super(db);

  void deleteTables() {
    delete(surveyHeaders).go();
  }

  void deleteSiteInfo(int surveyId) {
    (delete(surveyHeaders)..where((tbl) => tbl.id.equals(surveyId))).go();
  }

  void deleteSurvey(int surveyId) {}

  Future<int> addSurvey(SurveyHeadersCompanion entry) =>
      into(surveyHeaders).insert(entry);

  Future<List<SurveyHeader>> get allSurveys => select(surveyHeaders).get();
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
}
