import 'package:drift/drift.dart';

import 'survey_info_tables.dart';

class SurfaceSubstrateSummary extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();
  DateTimeColumn get measDate => dateTime()();
  IntColumn get numTransects =>
      integer().check(numTransects.isBetweenValues(1, 9)).nullable()();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();
}

class SurfaceSubstrateHeader extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ssId => integer().references(SurfaceSubstrateSummary, #id)();
  IntColumn get transNum => integer().check(transNum.isBetweenValues(1, 9))();
  RealColumn get nomTransLen =>
      real().check(nomTransLen.isBetweenValues(10.0, 150.0)).nullable()();
  IntColumn get transAzimuth =>
      integer().check(transAzimuth.isBetweenValues(0, 360)).nullable()();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();
}

class SurfaceSubstrateTally extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ssHeaderId =>
      integer().references(SurfaceSubstrateHeader, #id)();
  IntColumn get stationNum =>
      integer().check(stationNum.isBetweenValues(1, 99))();
  TextColumn get substrateType => text()();
  IntColumn get depth => integer().check(depth.isBetweenValues(0, 999))();
  IntColumn get depthLimit => integer()();
}
