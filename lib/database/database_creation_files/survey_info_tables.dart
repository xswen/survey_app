// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'reference_tables.dart';

class SurveyHeaders extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get nfiPlot => integer()
      .check(nfiPlot.isBetweenValues(1, 1600000) |
          nfiPlot.isBetweenValues(2000000, 2399999))
      .references(Plots, #nfiPlot)();

  DateTimeColumn get measDate => dateTime()();

  IntColumn get measNum => integer()();

  TextColumn get province =>
      text().withLength(min: 2, max: 2).references(Jurisdictions, #code)();

  BoolColumn get complete => boolean().withDefault(const Constant(false))();

  @override
  List<String> get customConstraints =>
      ['UNIQUE (nfi_plot, meas_num, province)'];
}

class SurveySummary extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();

  BoolColumn get notAssessed => boolean().withDefault(const Constant(false))();

  BoolColumn get complete => boolean().withDefault(const Constant(false))();

  IntColumn get referenceTree => integer().nullable()();

  TextColumn get crewOne => text().nullable()();

  TextColumn get crewTwo => text().nullable()();

  TextColumn get crewThree => text().nullable()();

  IntColumn get numberPhotos =>
      integer().withDefault(const Constant(0)).nullable()();
}

class SurveyHeaderGroundPhoto extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();

  BoolColumn get plotPin => boolean().nullable()();

  BoolColumn get transectOneFifteenUnder => boolean().nullable()();

  BoolColumn get transectOneFifteenOver => boolean().nullable()();

  BoolColumn get transectTwoFifteenUnder => boolean().nullable()();

  BoolColumn get transectTwoFifteenOver => boolean().nullable()();

  BoolColumn get horizontal => boolean().nullable()();

  BoolColumn get canopy => boolean().nullable()();

  BoolColumn get soilProfile => boolean().nullable()();

  BoolColumn get otherOne => boolean().nullable()();

  BoolColumn get otherTwo => boolean().nullable()();

  BoolColumn get otherThree => boolean().nullable()();

  BoolColumn get otherFour => boolean().nullable()();
}

class SurveyHeaderTree extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();

  TextColumn get fieldResponsibility => text().nullable()();

  TextColumn get fieldCheckBy => text().nullable()();

  DateTimeColumn get fieldDate => dateTime().nullable()();

  TextColumn get officeCheckBy => text().nullable()();

  DateTimeColumn get officeDate => dateTime().nullable()();
}

class SurveyHeaderEcological extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();

  TextColumn get fieldResponsibility => text().nullable()();

  TextColumn get fieldCheckBy => text().nullable()();

  DateTimeColumn get fieldDate => dateTime().nullable()();

  TextColumn get officeCheckBy => text().nullable()();

  DateTimeColumn get officeDate => dateTime().nullable()();
}

class SurveyHeaderSoil extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();

  TextColumn get fieldResponsibility => text().nullable()();

  TextColumn get fieldCheckBy => text().nullable()();

  DateTimeColumn get fieldDate => dateTime().nullable()();

  TextColumn get officeCheckBy => text().nullable()();

  DateTimeColumn get officeDate => dateTime().nullable()();
}
