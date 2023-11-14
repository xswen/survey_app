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

@DataClassName("EcpGenusData")
class EcpGenus extends Table {
  TextColumn get genus => text()();
  TextColumn get species => text()();
  TextColumn get variety => text()();
}
