import 'package:drift/drift.dart';
import 'package:survey_app/database/database_creation_files/survey_info_tables.dart';

class GpSummary extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get surveyId => integer().unique().references(SurveyHeaders, #id)();

  DateTimeColumn get measDate => dateTime()();

  BoolColumn get notAssessed => boolean().withDefault(const Constant(false))();

  BoolColumn get complete => boolean().withDefault(const Constant(false))();
}

class GpSiteInfo extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get gpSummaryId => integer().references(GpSummary, #id)();

  TextColumn get plotCompletion =>
      text().withLength(min: 1, max: 1).named('plot_completion')();

  TextColumn get incompReason =>
      text().withLength(min: 0, max: 2).named('incomp_reason')();

  TextColumn get province =>
      text().withLength(min: 0, max: 2).named('province')();

  IntColumn get ecozone =>
      integer().named('ecozone').check(ecozone.isBetweenValues(1, 15))();

  TextColumn get provEcoType => text().nullable().named('prov_eco_type')();

  IntColumn get provEcoRef => integer()
      .named('prov_eco_ref')
      .check(provEcoRef.isBetweenValues(-1, 9999))();

  TextColumn get postProcessing =>
      text().named('post_processing').withLength(min: 1, max: 1)();

  IntColumn get utmN =>
      integer().named('utm_n').check(utmN.isBetweenValues(4614000, 9297000))();

  RealColumn get utmNAccuracy => real()
      .named('utm_n_accuracy')
      .check(utmNAccuracy.isBetweenValues(-1, 40.000))();

  IntColumn get utmE =>
      integer().named('utm_e').check(utmE.isBetweenValues(250000, 750000))();

  RealColumn get utmEAccuracy => real()
      .named('utm_e_accuracy')
      .check(utmEAccuracy.isBetweenValues(-1, 40.000))();

  IntColumn get utmZone =>
      integer().named('utm_zone').check(utmZone.isBetweenValues(7, 22))();

  IntColumn get slope =>
      integer().named('slope').check(slope.isBetweenValues(-1, 150))();

  IntColumn get aspect =>
      integer().named('aspect').check((aspect.isBetweenValues(-1, 999)))();

  IntColumn get elevation =>
      integer().named('elevation').check(elevation.isBetweenValues(-1, 5951))();

  TextColumn get landBase =>
      text().withLength(min: 1, max: 1).named('land_base')();

  TextColumn get landCover =>
      text().withLength(min: 1, max: 1).named('land_cover')();

  TextColumn get landPos =>
      text().withLength(min: 1, max: 1).named('land_pos')();

  TextColumn get vegType =>
      text().withLength(min: 0, max: 2).named('veg_type')();

  TextColumn get densityCl =>
      text().withLength(min: 0, max: 2).named('density_cl')();

  TextColumn get standStru =>
      text().withLength(min: 0, max: 4).named('stand_stru')();

  TextColumn get succStage =>
      text().withLength(min: 0, max: 2).named('succ_stage')();

  TextColumn get wetlandClass =>
      text().withLength(min: 1, max: 1).named('wetland_class')();

  TextColumn get userInfo => text().nullable().named('user_info')();

  TextColumn get gpsMake =>
      text().withLength(min: 1, max: 25).named('gps_make')();

  TextColumn get gpsModel =>
      text().withLength(min: 1, max: 25).named('gps_model')();

  IntColumn get gpsPoint =>
      integer().named('gps_point').check(elevation.isBetweenValues(-1, 999))();
}

class GpDisturbance extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get gpSummaryId => integer().references(GpSummary, #id)();

  TextColumn get distAgent => text().withLength(min: 1, max: 20)();

  IntColumn get distYr => integer().check(distYr.isBetweenValues(-9, 9999))();

  IntColumn get distPct => integer().check(distPct.isBetweenValues(-1, 100))();

  IntColumn get mortPct => integer().check(mortPct.isBetweenValues(-9, 100))();

  TextColumn get mortBasis => text().withLength(min: 1, max: 2)();

  TextColumn get agentType => text().nullable().withLength(min: 1, max: 200)();
}

class GpOrigin extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get gpSummaryId => integer().references(GpSummary, #id)();

  TextColumn get vegOrig => text().withLength(min: 1, max: 4)();

  TextColumn get regenType => text().withLength(min: 1, max: 3)();

  IntColumn get regenYr => integer().check(regenYr.isBetweenValues(-9, 9999))();
}

class GpTreatment extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get gpSummaryId => integer().references(GpSummary, #id)();

  TextColumn get treatType => text().withLength(min: 1, max: 2)();

  IntColumn get treatYr => integer().check(treatYr.isBetweenValues(-9, 9999))();

  IntColumn get treatPct =>
      integer().check(treatPct.isBetweenValues(-9, 100))();
}
