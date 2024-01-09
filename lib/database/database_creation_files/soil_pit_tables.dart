import 'package:drift/drift.dart';
import 'package:survey_app/database/database_creation_files/survey_info_tables.dart';

class SoilPitSummary extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();
  DateTimeColumn get measDate => dateTime()();
  BoolColumn get notAssessed => boolean().withDefault(const Constant(false))();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();
}

class SoilSiteInfo extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get soilPitSummaryId =>
      integer().unique().references(SoilPitSummary, #id)();
  TextColumn get soilClassOrder => text()();
  TextColumn get soilClassGreatGroup => text()();
  TextColumn get soilClassSubGroup => text()();
  TextColumn get soilClass => text().withLength(max: 9)();
  RealColumn get profileDepth =>
      real().check(profileDepth.isBetweenValues(-1, 250))();
  IntColumn get drainage => integer().check(drainage.isBetweenValues(-9, 7))();
  IntColumn get moisture => integer().check(moisture.isBetweenValues(-9, 3))();
  TextColumn get deposition => text().withLength(max: 2)();
  TextColumn get humusForm => text().withLength(max: 2)();
}

class SoilPitFeature extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get soilPitSummaryId => integer().references(SoilPitSummary, #id)();
  TextColumn get soilPitCode => text().withLength(max: 3)();
  TextColumn get soilFeature => text().withLength(max: 1)();
  IntColumn get depthFeature =>
      integer().check(depthFeature.isBetweenValues(-9, 200))();
}

class SoilPitHorizonDescription extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get soilPitSummaryId => integer().references(SoilPitSummary, #id)();
  TextColumn get soilPitCodeField => text().withLength(max: 3)();
  IntColumn get horizonNum =>
      integer().check(horizonNum.isBetweenValues(1, 99))();
  TextColumn get horizon => text().withLength(max: 6)();
  RealColumn get horizonUpper =>
      real().check(horizonUpper.isBetweenValues(-1, 200.0))();
  RealColumn get thickness =>
      real().check(thickness.isBetweenValues(-1, 300.0))();
  TextColumn get color => text().withLength(max: 1)();
  TextColumn get mineralType => text()();
  TextColumn get texture => text().withLength(max: 5)();
  IntColumn get cfGrav => integer().check(cfGrav.isBetweenValues(-9, 100))();
  IntColumn get cfCobb => integer().check(cfCobb.isBetweenValues(-9, 100))();
  IntColumn get cfStone => integer().check(cfStone.isBetweenValues(-9, 100))();
}
