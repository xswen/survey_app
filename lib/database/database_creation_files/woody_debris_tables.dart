import 'package:drift/drift.dart';

import 'reference_tables.dart';
import 'survey_info_tables.dart';

class WoodyDebrisSummary extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();
  DateTimeColumn get measDate => dateTime()();
  IntColumn get numTransects =>
      integer().check(numTransects.isBetweenValues(1, 9)).nullable()();
  BoolColumn get complete =>
      boolean().nullable().withDefault(const Constant(false))();
}

class WoodyDebrisHeader extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wdId => integer().references(WoodyDebrisSummary, #id)();
  IntColumn get transNum =>
      integer().check(transNum.isBetweenValues(1, 9)).nullable()();
  RealColumn get nomTransLen =>
      real().check(nomTransLen.isBetweenValues(10.0, 150.0)).nullable()();
  IntColumn get transAzimuth =>
      integer().check(transAzimuth.isBetweenValues(0, 360)).nullable()();
  RealColumn get swdMeasLen => real()
      .check((swdMeasLen.isBetweenValues(0.0, 150.0) &
          swdMeasLen.isSmallerOrEqual(nomTransLen)))
      .nullable()();
  RealColumn get mcwdMeasLen => real()
      .check((mcwdMeasLen.isBetweenValues(0.0, 150.0) &
          mcwdMeasLen.isSmallerOrEqual(nomTransLen)))
      .nullable()();
  RealColumn get lcwdMeasLen => real()
      .check((lcwdMeasLen.isBetweenValues(0.0, 150.0) &
          lcwdMeasLen.isSmallerOrEqual(nomTransLen)))
      .nullable()();
  IntColumn get swdDecayClass =>
      integer().check(swdDecayClass.isBetweenValues(-1, 5)).nullable()();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();

  @override
  List<String> get customConstraints => ['UNIQUE (wd_id, trans_num)'];
}

class WoodyDebrisSmall extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wdHeaderId =>
      integer().unique().references(WoodyDebrisHeader, #id)();
  IntColumn get swdTallyS => integer().withDefault(const Constant(0))();
  IntColumn get swdTallyM => integer().withDefault(const Constant(0))();
  IntColumn get swdTallyL => integer().withDefault(const Constant(0))();
}

class WoodyDebrisOdd extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wdHeaderId => integer().references(WoodyDebrisHeader, #id)();
  IntColumn get pieceNum => integer()();
  TextColumn get accumOdd => text().withLength(min: 2, max: 2)();
  TextColumn get genus =>
      text().withLength(min: 4, max: 4).references(TreeGenus, #genusCode)();
  TextColumn get species =>
      text().withLength(min: 3, max: 3).references(TreeGenus, #speciesCode)();
  RealColumn get horLength => real()();
  RealColumn get verDepth => real()();
  IntColumn get decayClass =>
      integer().check(decayClass.isBetweenValues(-1, 5)).nullable()();
  @override
  List<String> get customConstraints => ['UNIQUE (wd_header_id, piece_num)'];
}

class WoodyDebrisRound extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wdHeaderId => integer().references(WoodyDebrisHeader, #id)();
  IntColumn get pieceNum => integer()();
  TextColumn get genus =>
      text().withLength(min: 4, max: 4).references(TreeGenus, #genusCode)();
  TextColumn get species =>
      text().withLength(min: 3, max: 3).references(TreeGenus, #speciesCode)();
  RealColumn get diameter => real()();
  IntColumn get tiltAngle =>
      integer().check(tiltAngle.isBetweenValues(-1, 90)).nullable()();
  IntColumn get decayClass =>
      integer().check(decayClass.isBetweenValues(-1, 5)).nullable()();
  @override
  List<String> get customConstraints => ['UNIQUE (wd_header_id, piece_num)'];
}
