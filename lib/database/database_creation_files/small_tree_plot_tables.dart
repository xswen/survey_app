import 'package:drift/drift.dart';

import 'survey_info_tables.dart';

class StpSummary extends Table {
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

@DataClassName("StpSpeciesData")
class StpSpecies extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stpSummaryId => integer().references(StpSummary, #id)();
  IntColumn get treeNum => integer()();
  TextColumn get origPlotArea => text().withLength(min: 1, max: 1)();
  TextColumn get genus => text().withLength(min: 4, max: 4)();
  TextColumn get species => text().withLength(min: 3, max: 3)();
  TextColumn get variety => text().withLength(min: 3, max: 3)();
  TextColumn get status => text().withLength(min: 2, max: 2)();
  RealColumn get dbh => real().check(dbh.isBetweenValues(-1, 8.9))();
  RealColumn get height => real().check(height.isBetweenValues(-1, 20))();
  TextColumn get measHeight => text().withLength(min: 1, max: 1)();
  TextColumn get stemCondition => text().withLength(min: 1, max: 1)();
}
