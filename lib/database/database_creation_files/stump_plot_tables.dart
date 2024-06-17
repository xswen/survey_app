// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'survey_info_tables.dart';

class StumpSummary extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();

  DateTimeColumn get measDate => dateTime()();

  TextColumn get plotType => text().withLength(min: 0, max: 3)();

  RealColumn get nomPlotSize =>
      real().check(nomPlotSize.isBetweenValues(-1, 0.04)).nullable()();

  RealColumn get measPlotSize =>
      real().check(measPlotSize.isBetweenValues(0.0005, 0.04)).nullable()();

  BoolColumn get notAssessed => boolean().withDefault(const Constant(false))();

  BoolColumn get complete => boolean().withDefault(const Constant(false))();
}

class StumpEntry extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get stumpSummaryId =>
      integer().unique().references(StumpSummary, #id)();

  IntColumn get stumpNum =>
      integer().check(stumpNum.isBetweenValues(1, 9999))();

  TextColumn get origPlotArea => text()();

  TextColumn get stumpGenus => text().withLength(min: 0, max: 4)();

  TextColumn get stumpSpecies => text().withLength(min: 0, max: 3)();

  TextColumn get stumpVariety => text()();

  RealColumn get stumpDib => real()
      .check(stumpDib.isBetweenValues(4.0, 999.9) | stumpDib.equals(-1.0))();

  RealColumn get stumpDiameter => real().check(
      stumpDiameter.isBetweenValues(4.0, 999.9) | stumpDiameter.equals(-1.0))();

  IntColumn get stumpDecay =>
      integer().check(stumpDecay.isBetweenValues(-1, 5))();

  RealColumn get stumpLength => real().check(
      stumpLength.isBetweenValues(0.01, 1.29) | stumpLength.equals(-1.0))();
}
