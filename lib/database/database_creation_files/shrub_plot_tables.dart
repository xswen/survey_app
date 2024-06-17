// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'survey_info_tables.dart';

class ShrubSummary extends Table {
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

class ShrubListEntry extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get shrubSummaryId => integer().references(ShrubSummary, #id)();

  IntColumn get recordNum =>
      integer().check(recordNum.isBetweenValues(1, 9999))();

  TextColumn get shrubGenus => text().withLength(min: 0, max: 4)();

  TextColumn get shrubSpecies => text().withLength(min: 0, max: 3)();

  TextColumn get shrubVariety => text()();

  TextColumn get shrubStatus => text()();

  IntColumn get bdClass =>
      integer().check(bdClass.isBetweenValues(0, 10) | bdClass.equals(-1))();

  IntColumn get frequency =>
      integer().check(frequency.isBetweenValues(1, 999))();

  @override
  List<String> get customConstraints =>
      ['UNIQUE (shrub_summary_id, record_num)'];
}
