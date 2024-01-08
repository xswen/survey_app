import 'package:drift/drift.dart';

import 'metadata_tables.dart';
import 'survey_info_tables.dart';

class EcpSummary extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();
  DateTimeColumn get measDate => dateTime()();
  //TODO: Double check these checks
  IntColumn get numEcps =>
      integer().check(numEcps.isBetweenValues(1, 9)).nullable()();
  BoolColumn get notAssessed => boolean().withDefault(const Constant(false))();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();
}

class EcpHeader extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ecpSummaryId => integer().references(EcpSummary, #id)();
  IntColumn get ecpNum => integer().nullable()();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();
  TextColumn get plotType => text().nullable()();
  //0.000025 to 1.0 or -1
  RealColumn get nomPlotSize => real().nullable()();
  RealColumn get measPlotSize =>
      real().check(measPlotSize.isBetweenValues(0.000025, 1.0)).nullable()();

  @override
  List<String> get customConstraints =>
      ['UNIQUE (ecp_summary_id, ecp_num, plot_type)'];
}

@DataClassName("EcpSpeciesData")
class EcpSpecies extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ecpHeaderId => integer().references(EcpHeader, #id)();
  IntColumn get speciesNum => integer()();

  TextColumn get layerId => text()();
  TextColumn get genus => text()();
  TextColumn get species => text()();
  TextColumn get variety => text().nullable()();
  RealColumn get speciesPct => real()();
  IntColumn get commentId =>
      integer().unique().references(MetaComment, #id).nullable()();
}
