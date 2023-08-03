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

@DataClassName("EcpGenusData")
class EcpGenus extends Table {
  TextColumn get genusCode => text().withLength(min: 4, max: 4)();
  TextColumn get speciesCode => text().withLength(min: 3, max: 3)();
  TextColumn get genusLatinName => text()();
  TextColumn get speciesLatinName => text()();
  TextColumn get commonNameEn => text()();
  TextColumn get commonNameFr => text()();

  @override
  Set<Column> get primaryKey => {genusCode, speciesCode};
}

class EcpVariety extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get genusCode => text().withLength(min: 4, max: 4)();
  TextColumn get speciesCode => text().withLength(min: 3, max: 3)();
  TextColumn get varietyCode => text().withLength(min: 3, max: 3)();
  TextColumn get varietyLatinName => text()();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (genus_code, species_code) REFERENCES ecp_genus (genus_code, species_code)'
      ];
}
