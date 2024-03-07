import 'package:drift/drift.dart';

import 'survey_info_tables.dart';

class ShrubSummary extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();
  DateTimeColumn get measDate => dateTime()();
  TextColumn get plotType => text().withLength(min: 3, max: 3)();
  RealColumn get nomPlotSize =>
      real().check(nomPlotSize.isBetweenValues(-1, 0.04)).nullable()();
  RealColumn get measPlotSize =>
      real().check(measPlotSize.isBetweenValues(0.0005, 0.04)).nullable()();
  BoolColumn get notAssessed => boolean().withDefault(const Constant(false))();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();
}

class ShrubLists extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get shrubSummaryId =>
      integer().unique().references(ShrubSummary, #id)();
  //TODO: Handle case of deletion?
  IntColumn get recordNum => integer()
      .customConstraint('CHECK(record_num >= 1 AND record_num <= 9999)')();
  TextColumn get shrubGenus => text().withLength(min: 0, max: 4)();
  TextColumn get shrubSpecies => text().withLength(min: 0, max: 3)();
  TextColumn get shrubVariety => text().withLength(min: 0, max: 3)();
  TextColumn get shrubStatus =>
      text().customConstraint('CHECK(shrub_status IN (\'LV\', \'DS\'))')();
  IntColumn get bdClass => integer().customConstraint(
      'CHECK(bd_class >= 0 AND bd_class <= 10 OR bd_class = -1)')();
  IntColumn get frequency => integer()
      .customConstraint('CHECK(frequency >= 1 AND frequency <= 999)')();
}
