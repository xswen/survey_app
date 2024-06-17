import 'package:drift/drift.dart';

import 'survey_info_tables.dart';

class LtpSummary extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();

  DateTimeColumn get measDate => dateTime()();

  TextColumn get plotType => text().withLength(min: 3, max: 3).nullable()();

  RealColumn get nomPlotSize =>
      real().check(nomPlotSize.isBetweenValues(-1, 0.1)).nullable()();

  RealColumn get measPlotSize =>
      real().check(measPlotSize.isBetweenValues(0.0075, 0.1)).nullable()();

  BoolColumn get notAssessed => boolean().withDefault(const Constant(false))();

  BoolColumn get complete => boolean().withDefault(const Constant(false))();
}

class LtpTree extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get lptSummaryId => integer().references(LtpSummary, #id)();

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

  IntColumn get renumbered =>
      integer().check(renumbered.isBetweenValues(-1, 360))();

  @override
  List<String> get customConstraints => ['UNIQUE (lpt_summary_id, tree_num)'];
}

class LtpTreeDamage extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get lptSummaryId => integer().references(LtpSummary, #id)();

  IntColumn get treeNum => integer().check(treeNum.isBetweenValues(1, 9999))();

  TextColumn get damageAgent => text().withLength(min: 2, max: 2)();

  TextColumn get damageLocation => text().withLength(min: 2, max: 2)();

  IntColumn get severityPct => integer().withDefault(const Constant(-7))();

  TextColumn get severity => text().withLength(min: 1, max: 1)();

  @override
  List<String> get customConstraints => ['UNIQUE (lpt_summary_id, tree_num)'];
}

class LtpTreeRemoved extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get lptSummaryId => integer().references(LtpSummary, #id)();

  IntColumn get treeNum => integer().check(treeNum.isBetweenValues(1, 9999))();

  TextColumn get reason => text().withLength(min: 1, max: 1)();

  @override
  List<String> get customConstraints => ['UNIQUE (lpt_summary_id, tree_num)'];
}

class LtpTreeAge extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get lptSummaryId => integer().references(LtpSummary, #id)();

  TextColumn get quadrant => text().withLength(min: 2, max: 2)();

  IntColumn get treeNum => integer().check(treeNum.isBetweenValues(1, 9999))();

  TextColumn get siteType => text().withLength(min: 2, max: 2)();

  RealColumn get boreDOB => real().check(boreDOB.isBetweenValues(-1, 999.9))();

  RealColumn get boreHt => real().check(boreHt.isBetweenValues(-1, 9.9))();

  TextColumn get suitHt => text().withLength(min: 1, max: 1)();

  TextColumn get suitAge => text().withLength(min: 1, max: 1)();

  IntColumn get fieldAge =>
      integer().check(fieldAge.isBetweenValues(-8, 9999))();

  TextColumn get proCode => text().withLength(min: 3, max: 3)();

  @override
  List<String> get customConstraints => ['UNIQUE (lpt_summary_id, tree_num)'];
}

class LtpTreeRenamed extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get lptSummaryId => integer().references(LtpSummary, #id)();

  IntColumn get treeNum => integer().check(treeNum.isBetweenValues(1, 9999))();

  IntColumn get treeNumPrev =>
      integer().check(treeNumPrev.isBetweenValues(1, 9999))();

  @override
  List<String> get customConstraints => ['UNIQUE (lpt_summary_id, tree_num)'];
}
