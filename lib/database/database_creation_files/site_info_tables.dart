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

  IntColumn get ecozone => integer().named('ecozone')();

  TextColumn get provEcoType => text().nullable().named('prov_eco_type')();

  IntColumn get provEcoRef => integer().named('prov_eco_ref')();

  IntColumn get utmN => integer().named('utm_n')();

  IntColumn get utmE => integer().named('utm_e')();

  IntColumn get utmZone => integer().named('utm_zone')();

  IntColumn get slope => integer().named('slope')();

  IntColumn get aspect => integer().named('aspect')();

  IntColumn get elevation => integer().named('elevation')();

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

  @override
  List<String> get customConstraints => [
        'CHECK (((slope <= 2 AND aspect = 999) OR (slope > 2 AND (aspect >= -1 AND aspect <= 359))))',
        'CHECK (((aspect >= 0 AND aspect <= 359) OR aspect = 999 OR aspect = -1))',
        "CHECK (density_cl IN ('DE', 'OP', 'SP', 'CL', 'GL', 'SC', 'BR', 'RT', 'MS', 'LB', 'RS', 'ES', 'LS', 'RM', 'BE', 'LL', 'BU', 'RP', 'MU', 'CB', 'MO', 'GP', 'TS', 'RR', 'BP', 'AP', 'PM', 'SW', 'OT', 'U'))",
        "CHECK ((land_base = 'V' AND density_cl IN ('DE', 'OP', 'SP', 'CL')) OR land_base <> 'V')",
        "CHECK (((veg_type = 'SI' AND density_cl IN ('GL', 'SC')) OR (veg_type = 'RO' AND density_cl IN ('BR', 'RT', 'MS', 'LB')) OR (veg_type = 'EL' AND density_cl IN ('RS', 'ES', 'LS', 'RM', 'BE', 'LL', 'BU', 'RP', 'MU', 'CB', 'MO', 'GP', 'TS', 'RR', 'BP', 'AP', 'PM', 'OT')) OR veg_type NOT IN ('SI', 'RO', 'EL')))",
        'CHECK (ecozone > 0 AND ecozone <= 15)',
        'CHECK (((elevation >= 0 AND elevation <= 5951) OR elevation = -1))',
        "CHECK (incomp_reason IN ('AD', 'HZ', 'NF', 'SP', 'OT', 'NA', 'NR'))",
        "CHECK (((land_base = 'V' AND land_cover IN ('T', 'N')) OR (land_base = 'N' AND land_cover IN ('L', 'W')) OR land_base NOT IN ('V', 'N')))",
        "CHECK (land_base IN ('V', 'N', 'U'))",
        "CHECK (land_cover IN ('T', 'N', 'L', 'W', 'U'))",
        'CHECK (((prov_eco_ref >= 0 AND prov_eco_ref <= 9999) OR prov_eco_ref = -1))',
        'CHECK (((slope >= 0 AND slope <= 150) OR slope = -1))',
        "CHECK (stand_stru IN ('SNGL', 'MULT', 'COMP', 'NA', 'U'))",
        "CHECK (((land_cover = 'T' AND stand_stru <> 'NA') OR (land_cover <> 'T' AND stand_stru = 'NA')))",
        "CHECK (succ_stage IN ('ES', 'MS', 'LS', 'TS', 'OG', 'UR'))",
        "CHECK (wetland_class IN ('B', 'F', 'S', 'M', 'W', 'N', 'U'))",
        "CHECK (land_pos IN ('W', 'U', 'A', 'N'))"
      ];
}

class GpDisturbance extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get gpSummaryId => integer().references(GpSummary, #id)();

  TextColumn get distAgent => text().withLength(min: 1, max: 20)();

  IntColumn get distYr => integer()();

  IntColumn get distPct => integer()();

  IntColumn get mortPct => integer()();

  TextColumn get mortBasis => text().withLength(min: 1, max: 2)();

  TextColumn get agentType => text().nullable().withLength(min: 1, max: 200)();

  @override
  List<String> get customConstraints => [
        'CHECK (((dist_agent = "NONE" AND mort_basis = "NA") OR (dist_agent <> "NONE")))',
        'CHECK (((dist_agent = "NONE" AND mort_pct = 0) OR (dist_agent <> "NONE")))',
        'CHECK (((dist_agent = "NONE" AND dist_pct = 0) OR (dist_agent <> "NONE")))',
        "CHECK (dist_agent IN ('FIRE', 'WIND', 'SNOW', 'INSECT', 'DISEASE', 'ICE', 'OTHER', 'UNKNOWN', 'NONE') OR dist_agent LIKE 'OTHER%')",
        'CHECK (((dist_agent = "NONE" AND dist_yr = -9) OR (dist_agent <> "NONE")))',
        'CHECK (((dist_pct >= 0 AND dist_pct <= 100) OR dist_pct = -1))',
        "CHECK (mort_basis IN ('VL', 'BA', 'CA', 'ST', 'AR', 'NA', 'M'))",
        'CHECK (((mort_pct > 0 AND mort_basis <> "NA") OR ((mort_pct = 0 OR mort_pct = -9) AND mort_basis = "NA") OR (mort_pct = -1 AND mort_basis IN ("M", "NA"))))',
        'CHECK (((mort_pct >= 0 AND mort_pct <= 100) OR mort_pct = -1 OR mort_pct = -9))',
      ];
}

class GpOrigin extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get gpSummaryId => integer().references(GpSummary, #id)();

  TextColumn get vegOrig => text().withLength(min: 1, max: 4)();

  TextColumn get regenType => text().withLength(min: 1, max: 3)();

  IntColumn get regenYr => integer()();

  @override
  List<String> get customConstraints => [
        "CHECK (regen_type IN ('NAT', 'SUP', 'PLA', 'SOW', 'NA', 'UNK'))",
        'CHECK (((veg_orig = "NA" AND regen_type = "NA") OR veg_orig <> "NA"))',
        'CHECK (((veg_orig = "NA" AND regen_yr = -9) OR veg_orig <> "NA"))',
        "CHECK (veg_orig IN ('SUCC', 'HARV', 'DIST', 'AFOR', 'UNK', 'NA'))"
      ];
}

class GpTreatment extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get gpSummaryId => integer().references(GpSummary, #id)();

  TextColumn get treatType => text().withLength(min: 1, max: 2)();

  IntColumn get treatYr => integer()();

  IntColumn get treatPct => integer()();

  @override
  List<String> get customConstraints => [
        'CHECK (((treat_pct >= 0 AND treat_pct <= 100) OR treat_pct = -1 OR treat_pct = -9))',
        'CHECK (((treat_type = "NO" AND treat_pct IN (0, -9)) OR (treat_type <> "NO" AND treat_pct <> -9)))',
        "CHECK (treat_type IN ('CC', 'PC', 'DC', 'CL', 'JS', 'PR', 'PT', 'CT', 'FT', 'SP', 'PB', 'OT', 'HC', 'NO', 'NR'))",
        'CHECK (((treat_type = "NO" AND treat_yr = -9) OR (treat_type <> "NO" AND treat_yr <> -9)))',
      ];
}
