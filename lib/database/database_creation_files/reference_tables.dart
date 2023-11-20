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

//Soil Pit
class SoilPitClassification extends Table {
  TextColumn get code => text()();
  TextColumn get order => text()();
  TextColumn get greatGroup => text()();
  TextColumn get subGroup => text().nullable()();
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

class SoilPitCodeCompleted extends Table {
  TextColumn get code => text()();
  TextColumn get name => text()();
}

class SoilPitCodeField extends Table {
  TextColumn get code => text()();
  TextColumn get name => text()();
}

class SoilPitFeature extends Table {
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
