import 'package:drift/drift.dart';

import 'survey_info_tables.dart';

class LptSummary extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();
  DateTimeColumn get measDate => dateTime()();
}

class LptTrees extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lptSummaryId => integer().references(LptSummary, #id)();
  IntColumn get sector => integer().check(sector.isBetweenValues(-1, 8))();
  IntColumn get treeNum => integer().check(treeNum.isBetweenValues(1, 9999))();
  TextColumn get origPlotArea => text().withLength(min: 0, max: 1)();
  TextColumn get lgTreeGenus => text().withLength(min: 0, max: 4)();
  TextColumn get lgTreeSpecies => text().withLength(min: 0, max: 3)();
  TextColumn get lgTreeVariety => text().withLength(min: 0, max: 3)();
  TextColumn get lgTreeStatus => text().withLength(min: 0, max: 2)();
  RealColumn get dbh => real().check(dbh.isBetweenValues(-1, 999.9))();
  TextColumn get measEstDbh => text().withLength(min: 0, max: 1)();
  RealColumn get height => real().check(height.isBetweenValues(-1, 99.9))();
  TextColumn get measEstHeight => text().withLength(min: 0, max: 1)();
  TextColumn get crownClass => text().withLength(min: 0, max: 1)();
  RealColumn get crownBase =>
      real().check(crownBase.isBetweenValues(-9, 99.9))();
  RealColumn get crownTop => real().check(crownTop.isBetweenValues(-9, 99.9))();
  TextColumn get stemCond => text().withLength(min: 0, max: 1)();
  IntColumn get crownCond =>
      integer().check(crownCond.isBetweenValues(-1, 6))();
  IntColumn get barkRet => integer().check(barkRet.isBetweenValues(-1, 7))();
  IntColumn get woodCond => integer().check(woodCond.isBetweenValues(-1, 8))();
  IntColumn get azimuth => integer().check(azimuth.isBetweenValues(-1, 360))();
  RealColumn get distance =>
      real().check(distance.isBetweenValues(-1, 99.99))();

  @override
  List<String> get customConstraints => ['UNIQUE (lpt_summary_id, tree_num)'];
}
