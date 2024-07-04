// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

class Jurisdictions extends Table {
  TextColumn get code => text().withLength(min: 2, max: 2)();

  TextColumn get nameEn => text().unique()();

  TextColumn get nameFr => text().unique()();

  @override
  Set<Column> get primaryKey => {code};
}

class Plots extends Table {
  IntColumn get nfiPlot => integer()
      .check(nfiPlot.isBetweenValues(1, 1600000) |
          nfiPlot.isBetweenValues(2000000, 2399999))
      .references(Plots, #nfiPlot)();

  TextColumn get code =>
      text().withLength(min: 2, max: 2).references(Jurisdictions, #code)();

  IntColumn get lastMeasNum =>
      integer().check(lastMeasNum.isBetweenValues(0, 999)).nullable()();

  @override
  Set<Column> get primaryKey => {nfiPlot};
}

@DataClassName("TreeGenusData")
class TreeGenus extends Table {
  TextColumn get genusCode => text().withLength(min: 4, max: 4)();

  TextColumn get speciesCode => text().withLength(min: 3, max: 3)();

  TextColumn get genusLatinName => text()();

  TextColumn get speciesLatinName => text()();

  TextColumn get commonNameEn => text()();

  TextColumn get commonNameFr => text()();

  @override
  Set<Column> get primaryKey => {genusCode, speciesCode};
}

//Surface Substrate
class SubstrateType extends Table {
  TextColumn get typeCode => text().withLength(min: 2, max: 2)();

  TextColumn get nameEn => text()();

  TextColumn get nameFr => text()();

  BoolColumn get hasDepth => boolean()();

  @override
  Set<Column> get primaryKey => {typeCode};
}

class SsDepthLimit extends Table {
  IntColumn get code => integer().unique()();

  TextColumn get nameEn => text()();

  TextColumn get nameFr => text()();
}

//ECP
@DataClassName("EcpLayerData")
class EcpLayer extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

@DataClassName("EcpGenusData")
class EcpGenus extends Table {
  TextColumn get genus => text()();

  TextColumn get species => text()();

  TextColumn get variety => text()();
}

class EcpPlotType extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

//Soil Pit
class SoilPitClassification extends Table {
  TextColumn get code => text()();

  TextColumn get order => text()();

  TextColumn get greatGroup => text()();

  TextColumn get subGroup => text()();
}

@DataClassName("SoilDrainageClassData")
class SoilDrainageClass extends Table {
  IntColumn get code => integer()();

  TextColumn get name => text()();
}

@DataClassName("SoilMositureClassData")
class SoilMoistureClass extends Table {
  IntColumn get code => integer()();

  TextColumn get name => text()();
}

class SoilDeposition extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class SoilHumusForm extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class SoilPitCode extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

@DataClassName("SoilFeatureClassData")
class SoilPitFeatureClass extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class SoilHorizonDesignation extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class SoilColor extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class SoilTexture extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

//Small Tree Plot
class StpType extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class StpOrigPlotArea extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

//Must have field suffix so doesn't mess up auto generator
//Table names can't end in status
class StpStatusField extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();

  TextColumn get description => text()();
}

class StpHeight extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class StpStemCondition extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

//Shrub
class ShrubPlotType extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class ShrubBasalDiameter extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

//Must have field suffix so doesn't mess up auto generator
//Table names can't end in status
class ShrubStatusField extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

//Stump
class StumpPlotType extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class StumpOrigPlotArea extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

//LTP
@DataClassName("LtpGenusData")
class LtpGenus extends Table {
  TextColumn get genusLatinName => text()();

  TextColumn get speciesLatinName => text()();

  TextColumn get varietyLatinName => text()();

  TextColumn get genusCode => text()();

  TextColumn get speciesCode => text()();

  TextColumn get varietyCode => text()();
}

class LtpPlotType extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpPlotSplit extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpOrigPlotArea extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpStatusField extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();

  TextColumn get description => text()();
}

class LtpCrownClassField extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpBarkCondition extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpCrownCondition extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpStemCondition extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpWoodCondition extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpQuadrant extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpTreeType extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpSiteHeightSuitability extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpSiteAgeSuitability extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class LtpProrate extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpSiteInfoStandStructure extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();

  TextColumn get cover => text().nullable()();
}

class GpSiteInfoSuccessionStage extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpSiteInfoUtmZone extends Table {
  IntColumn get code => integer()();

  TextColumn get name => text()();
}

class GpSiteInfoVegType extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();

  TextColumn get cover => text()();

  TextColumn get base => text().nullable()();
}

class GpSiteInfoWetland extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpSiteInfoEcozone extends Table {
  IntColumn get code => integer()();

  TextColumn get name => text()();
}

class GpSiteInfoPlotCompletion extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpSiteInfoPlotIncompleteReason extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpSiteInfoDensity extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();

  TextColumn get base => text().nullable()();

  TextColumn get veg => text().nullable()();
}

class GpSiteInfoLandBase extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();

  TextColumn get completion => text().nullable()();
}

class GpSiteInfoLandCover extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();

  TextColumn get base => text().nullable()();
}

class GpSiteInfoLandPos extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpSiteInfoPostProcessing extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpDistAgent extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpDistMortalityBasis extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpOriginVegCover extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}

class GpOriginRegenType extends Table {
  TextColumn get code => text()();

  TextColumn get name => text()();
}
