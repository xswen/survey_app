import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:survey_app/constants/constant_values.dart';

import '../database.dart';
import '../database_creation_files/reference_tables.dart';

part 'reference_tables_dao.g.dart';

@DriftAccessor(tables: [
  Jurisdictions,
  Plots,
  TreeGenus,
  SubstrateType,
  SsDepthLimit,
  EcpGenus,
  EcpLayer,
  SoilDrainageClass,
  SoilMoistureClass,
  SoilDeposition,
  SoilHumusForm,
  SoilPitCodeCompleted,
  SoilPitCodeField,
  SoilPitFeatureClass,
  SoilHorizonDesignation,
  SoilColor,
  SoilTexture,
])
class ReferenceTablesDao extends DatabaseAccessor<Database>
    with _$ReferenceTablesDaoMixin {
  ReferenceTablesDao(super.db);

  //For testing purposes only
  void clearTables() {
    delete(jurisdictions).go();
    delete(plots).go();
    delete(treeGenus).go();
    delete(ecpGenus).go();
  }

  //====================Jurisdictions====================
  //--------------------get--------------------
  Future<String> getJurisdictionCode(Locale locale, String name) async {
    Jurisdiction data;
    locale == kLocaleEn
        ? data = await (select(jurisdictions)
              ..where((tbl) => tbl.nameEn.equals(name)))
            .getSingle()
        : data = await (select(jurisdictions)
              ..where((tbl) => tbl.nameFr.equals(name)))
            .getSingle();

    return data.code;
  }

  Future<String> getJurisdictionName(String code, Locale locale) async {
    Jurisdiction jurisdiction = await (select(jurisdictions)
          ..where((tbl) => tbl.code.equals(code)))
        .getSingle();
    String name;

    locale == kLocaleEn
        ? name = jurisdiction.nameEn
        : name = jurisdiction.nameFr;

    return name;
  }

  Future<List<Jurisdiction>> get allJurisdictions =>
      select(jurisdictions).get();

  //Full replace
  Future<void> updateJurisdiction(JurisdictionsCompanion entry) async =>
      update(jurisdictions).replace(entry);

  Future<List<String>> getJurisdictionNames(Locale locale) {
    return locale == kLocaleEn
        ? select(jurisdictions).map((row) => row.nameEn).get()
        : select(jurisdictions).map((row) => row.nameFr).get();
  }

  //--------------------add--------------------
  Future<int> addJurisdiction(JurisdictionsCompanion entry) =>
      into(jurisdictions).insert(entry);

  Future<int> addOrUpdateJurisdiction(JurisdictionsCompanion entry) =>
      into(jurisdictions).insertOnConflictUpdate(entry);

//====================Plots====================
  //--------------------get--------------------
  Future<List<Plot>> get allPlots => select(plots).get();

  Future<void> updatePlot(PlotsCompanion entry) async =>
      update(plots).replace(entry);

  Future<Plot> getPlot(int plotNum) =>
      (select(plots)..where((tbl) => tbl.nfiPlot.equals(plotNum))).getSingle();

  Future<List<int>> getPlotNums(String code) =>
      (select(plots)..where((tbl) => tbl.code.equals(code)))
          .map((p0) => p0.nfiPlot)
          .get();

  Future<int> getLastMeasNum(int plotNum) async {
    Plot plot = await (select(plots)
          ..where((tbl) => tbl.nfiPlot.equals(plotNum)))
        .getSingle();
    return plot.lastMeasNum ?? -1;
  }

  //--------------------add--------------------
  Future<int> addPlot(PlotsCompanion entry) => into(plots).insert(entry);

  Future<int> addOrUpdatePlot(PlotsCompanion entry) =>
      into(plots).insertOnConflictUpdate(entry);

  Future<int> addTreeGenus(TreeGenusCompanion entry) =>
      into(treeGenus).insert(entry);

//====================TreeGenus====================
//--------------------get--------------------
  Future<List<String>> get genusLatinNames {
    final query = selectOnly(treeGenus, distinct: true)
      ..addColumns([treeGenus.genusLatinName]);
    return query.map((p0) => p0.read(treeGenus.genusLatinName)!).get();
  }

  Future<String> getGenusCodeFromName(String name) async {
    List<String> codes = await ((select(treeGenus)
          ..where((tbl) => tbl.genusLatinName.equals(name)))
        .map((p0) => p0.genusCode)
        .get());
    return codes[0];
  }

  Future<String> getGenusNameFromCode(String code) async {
    List<String> names = await ((select(treeGenus)
          ..where((tbl) => tbl.genusCode.equals(code)))
        .map((p0) => p0.genusLatinName)
        .get());
    return names[0];
  }

  Future<List<String>> getSpeciesNamesFromGenus(String genusCode) =>
      (select(treeGenus)..where((tbl) => tbl.genusCode.equals(genusCode)))
          .map((p0) => p0.speciesLatinName)
          .get();

  Future<bool> checkGenusUnknown(String genusCode) async {
    List<String> speciesCodes = await ((select(treeGenus)
          ..where((tbl) => tbl.genusCode.equals(genusCode)))
        .map((p0) => p0.speciesCode)
        .get());

    return speciesCodes.length == 1 && speciesCodes[0] == kSpeciesUnknownCode;
  }

  Future<String> getSpeciesCode(String genusCode, String speciesName) =>
      (select(treeGenus)
            ..where((tbl) =>
                tbl.genusCode.equals(genusCode) &
                tbl.speciesLatinName.equals(speciesName)))
          .map((p0) => p0.speciesCode)
          .getSingle();

  Future<String> getSpeciesName(String genusCode, String speciesCode) =>
      (select(treeGenus)
            ..where((tbl) =>
                tbl.genusCode.equals(genusCode) &
                tbl.speciesCode.equals(speciesCode)))
          .map((p0) => p0.speciesLatinName)
          .getSingle();
  //====================Surface Substrate====================
  Future<String> getSubstrateTypeNameFromCode(String code) =>
      (select(substrateType)..where((tbl) => tbl.typeCode.equals(code)))
          .map((p0) => p0.nameEn)
          .getSingle();

  Future<List<String>> get substrateTypeNames {
    final query = selectOnly(substrateType, distinct: true)
      ..addColumns([substrateType.nameEn]);
    return query.map((p0) => p0.read(substrateType.nameEn)!).get();
  }

  Future<SubstrateTypeData> getSubstrateTypeDataFromName(String name) =>
      ((select(substrateType)..where((tbl) => tbl.nameEn.equals(name)))
          .getSingle());

  Future<String> getSubstrateDepthLimitNameFromCode(int code) =>
      (select(ssDepthLimit)..where((tbl) => tbl.code.equals(code)))
          .map((p0) => p0.nameEn)
          .getSingle();
  Future<List<String>> get ssDepthList {
    final query = selectOnly(ssDepthLimit, distinct: true)
      ..addColumns([ssDepthLimit.nameEn]);
    return query.map((p0) => p0.read(ssDepthLimit.nameEn)!).get();
  }

  Future<int> getSubstrateDepthLimitCodeFromName(String name) async {
    List<int> codes = await ((select(ssDepthLimit)
          ..where((tbl) => tbl.nameEn.equals(name)))
        .map((p0) => p0.code)
        .get());
    return codes[0];
  }

  //====================EcpLayers====================
  Future<String> getEcpLayerName(String code) =>
      ((select(ecpLayer)..where((tbl) => tbl.code.equals(code)))
          .map((p0) => p0.name)
          .getSingle());

  Future<String> getEcpLayerCode(String name) =>
      ((select(ecpLayer)..where((tbl) => tbl.name.equals(name)))
          .map((p0) => p0.code)
          .getSingle());

  Future<List<String>> get ecpLayerNameList =>
      (select(ecpLayer).map((p0) => p0.name)).get();

  //====================EcpTreeGenus====================
//--------------------get--------------------
  Future<List<String>> get ecpGenusList {
    final query = selectOnly(ecpGenus, distinct: true)
      ..addColumns([ecpGenus.genus])
      ..where(ecpGenus.genus.isNotNull());

    return query
        .map((p0) =>
            p0.read(ecpGenus.genus) ?? "error on loading ecp genus list")
        .get();
  }

  Future<List<String>> getEcpSpeciesList(String genus) {
    final query = selectOnly(ecpGenus, distinct: true)
      ..addColumns([ecpGenus.species])
      ..where(ecpGenus.species.isNotNull() & ecpGenus.genus.equals(genus));

    return query
        .map((p0) =>
            p0.read(ecpGenus.species) ?? "error on loading ecp species list")
        .get();
  }

  Future<List<String>> getEcpVarietyList(String genus, String species) {
    final query = selectOnly(ecpGenus, distinct: true)
      ..addColumns([ecpGenus.variety])
      ..where(ecpGenus.variety.isNotNull() &
          ecpGenus.genus.equals(genus) &
          ecpGenus.species.equals(species));

    return query
        .map((p0) =>
            p0.read(ecpGenus.variety) ?? "error on loading ecp variety list")
        .get();
  }
}
