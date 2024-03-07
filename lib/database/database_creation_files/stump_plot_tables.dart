import 'package:drift/drift.dart';

import 'survey_info_tables.dart';

class StumpSummary extends Table {
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

class StumpList extends Table {
  IntColumn get stumpNum => integer()
      .customConstraint('CHECK(stump_num >= 1 AND stump_num <= 9999)')();
  TextColumn get origPlotArea => text().customConstraint(
      'CHECK(orig_plot_area IN (\'Y\', \'N\', \'X\', \'U\'))')();
  TextColumn get stumpGenus => text().withLength(min: 0, max: 4)();
  TextColumn get stumpSpecies => text().withLength(min: 0, max: 3)();
  TextColumn get stumpVariety => text().withLength(min: 0, max: 3)();
  RealColumn get stumpDib => real().customConstraint(
      'CHECK(stump_dib >= 4.0 AND stump_dib <= 999.9 OR stump_dib = -1)')();
  RealColumn get stumpDiameter => real().customConstraint(
      'CHECK(stump_diameter >= 4.0 AND stump_diameter <= 999.9 OR stump_diameter = -1)')();
  IntColumn get stumpDecay => integer()
      .customConstraint('CHECK(stump_decay >= -1 AND stump_decay <= 5)')();
  RealColumn get stumpLength => real().customConstraint(
      'CHECK(stump_length >= 0.01 AND stump_length <= 1.29 OR stump_length = -1)')();
}
