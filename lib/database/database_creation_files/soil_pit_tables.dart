import 'package:drift/drift.dart';
import 'package:survey_app/database/database_creation_files/survey_info_tables.dart';

class SoilSiteInfo extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();
  DateTimeColumn get measDate => dateTime()();
  TextColumn get soilClass => text().withLength(max: 9)();
  IntColumn get profileDepth =>
      integer().check(profileDepth.isBetweenValues(-1, 250))();
  IntColumn get drainage => integer().check(drainage.isBetweenValues(-9, 7))();
  IntColumn get moisture => integer().check(moisture.isBetweenValues(-9, 3))();
  TextColumn get deposition => text().withLength(max: 2)();
  TextColumn get humusForm => text().withLength(max: 2)();
}
