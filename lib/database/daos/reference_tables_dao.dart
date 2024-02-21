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
  EcpPlotType,
  SoilPitClassification,
  SoilDrainageClass,
  SoilMoistureClass,
  SoilDeposition,
  SoilHumusForm,
  SoilPitCode,
  SoilPitFeatureClass,
  SoilHorizonDesignation,
  SoilColor,
  SoilTexture,
  StpType,
  StpOrigPlotArea,
  StpStatusField,
  StpHeight,
  StpStemCondition,
  ShrubPlotType,
  ShrubStatusField,
  ShrubBasalDiameter,
  StumpPlotType,
  StumpOrigPlotArea,
  LtpPlotType,
  LtpPlotSplit,
  LtpOrigPlotArea,
  LtpStatusField,
  LtpGenus,
  LtpCrownClassField,
  LtpBarkCondition,
  LtpCrownCondition,
  LtpStemCondition,
  LtpWoodCondition,
  LtpQuadrant,
  LtpTreeType,
  LtpSiteHeightSuitability,
  LtpSiteAgeSuitability,
  LtpProrate,
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

  Future<List<String>> getEcpPlotTypeNameList() {
    final query = selectOnly(ecpPlotType, distinct: true)
      ..addColumns([ecpPlotType.name])
      ..where(ecpPlotType.name.isNotNull());

    return query
        .map((row) => row.read(ecpPlotType.name) ?? "error on loading name")
        .get();
  }

  Future<String> getEcpPlotTypeName(String code) =>
      (select(ecpPlotType, distinct: true)
            ..where((tbl) => tbl.code.equals(code)))
          .map((row) => row.name)
          .getSingle();

  Future<String> getEcpPlotTypeCode(String name) =>
      (select(ecpPlotType, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

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

//====================Soil====================
  Future<List<String>> getSoilClassOrderList() {
    final query = selectOnly(soilPitClassification, distinct: true)
      ..addColumns([soilPitClassification.order])
      ..where(soilPitClassification.order.isNotNull());

    return query
        .map((p0) =>
            p0.read(soilPitClassification.order) ??
            "error on loading soil order")
        .get();
  }

  Future<List<String>> getSoilClassGreatGroupList(String order) async {
    if (order.isEmpty) return [];

    final query = selectOnly(soilPitClassification, distinct: true)
      ..addColumns([soilPitClassification.greatGroup])
      ..where(soilPitClassification.greatGroup.isNotNull() &
          soilPitClassification.order.equals(order));

    return query
        .map((p0) =>
            p0.read(soilPitClassification.greatGroup) ??
            "error on loading soil great group")
        .get();
  }

  Future<List<String>> getSoilClassSubGroupList(
      String order, String greatGroup) async {
    if (order.isEmpty || greatGroup.isEmpty) return [];

    final query = selectOnly(soilPitClassification, distinct: true)
      ..addColumns([soilPitClassification.subGroup])
      ..where(soilPitClassification.subGroup.isNotNull() &
          soilPitClassification.order.equals(order) &
          soilPitClassification.greatGroup.equals(greatGroup));

    return query
        .map((p0) =>
            p0.read(soilPitClassification.subGroup) ??
            "error on loading soil subgroup")
        .get();
  }

  Future<String> getSoilClassCode(
          String order, String greatGroup, String subGroup) =>
      (select(soilPitClassification)
            ..where((tbl) =>
                tbl.order.equals(order) &
                tbl.greatGroup.equals(greatGroup) &
                tbl.subGroup.equals(subGroup)))
          .map((p0) => p0.code)
          .getSingle();

  Future<List<String>> getSoilDrainageNameList() {
    final query = selectOnly(soilDrainageClass, distinct: true)
      ..addColumns([soilDrainageClass.name])
      ..where(soilDrainageClass.name.isNotNull());

    return query
        .map((p0) =>
            p0.read(soilDrainageClass.name) ?? "error on loading drainage name")
        .get();
  }

  Future<String> getSoilDrainageName(int code) {
    return (select(soilDrainageClass, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((p0) => p0.name)
        .getSingle();
  }

  Future<int> getSoilDrainageCode(String name) =>
      (select(soilDrainageClass, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((p0) => p0.code)
          .getSingle();

  Future<List<String>> getSoilMoistureNameList() {
    final query = selectOnly(soilMoistureClass, distinct: true)
      ..addColumns([soilMoistureClass.name])
      ..where(soilMoistureClass.name.isNotNull());

    return query
        .map((p0) =>
            p0.read(soilMoistureClass.name) ?? "error on loading moisture name")
        .get();
  }

  Future<String> getSoilMoistureName(int code) =>
      (select(soilMoistureClass, distinct: true)
            ..where((tbl) => tbl.code.equals(code)))
          .map((p0) => p0.name)
          .getSingle();

  Future<int> getSoilMoistureCode(String name) =>
      (select(soilMoistureClass, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((p0) => p0.code)
          .getSingle();

  Future<List<String>> getSoilDepositionNameList() {
    final query = selectOnly(soilDeposition, distinct: true)
      ..addColumns([soilDeposition.name])
      ..where(soilDeposition.name.isNotNull());

    return query
        .map((row) => row.read(soilDeposition.name) ?? "error on loading name")
        .get();
  }

  Future<String> getSoilDepositionName(String code) async {
    if (code.isEmpty) return "";

    return (select(soilDeposition, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getSoilDepositionCode(String name) =>
      (select(soilDeposition, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getSoilHumusFormNameList() {
    final query = selectOnly(soilHumusForm, distinct: true)
      ..addColumns([soilHumusForm.name])
      ..where(soilHumusForm.name.isNotNull());

    return query
        .map((row) => row.read(soilHumusForm.name) ?? "error on loading name")
        .get();
  }

  Future<String> getSoilHumusFormName(String code) async {
    if (code.isEmpty) return "";

    return (select(soilHumusForm, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getSoilHumusFormCode(String name) =>
      (select(soilHumusForm, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getSoilPitCodeNameList() {
    final query = selectOnly(soilPitCode, distinct: true)
      ..addColumns([soilPitCode.name])
      ..where(soilPitCode.name.isNotNull());

    return query
        .map((row) => row.read(soilPitCode.name) ?? "error on loading name")
        .get();
  }

  Future<String> getSoilPitCodeName(String code) async {
    if (code.isEmpty) return "";

    return (select(soilPitCode, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getSoilPitCodeCode(String name) =>
      (select(soilPitCode, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getSoilPitFeatureClassNameList() {
    final query = selectOnly(soilPitFeatureClass, distinct: true)
      ..addColumns([soilPitFeatureClass.name])
      ..where(soilPitFeatureClass.name.isNotNull());

    return query
        .map((row) =>
            row.read(soilPitFeatureClass.name) ?? "error on loading name")
        .get();
  }

  Future<String> getSoilPitFeatureClassName(String code) async {
    if (code.isEmpty) return "";

    return (select(soilPitFeatureClass, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getSoilPitFeatureClassCode(String name) =>
      (select(soilPitFeatureClass, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getSoilHorizonDesignationNameList() {
    final query = selectOnly(soilHorizonDesignation, distinct: true)
      ..addColumns([soilHorizonDesignation.name])
      ..where(soilHorizonDesignation.name.isNotNull());

    return query
        .map((row) =>
            row.read(soilHorizonDesignation.name) ?? "error on loading name")
        .get();
  }

  Future<String> getSoilHorizonDesignationName(String code) async {
    if (code.isEmpty) return "";

    return (select(soilHorizonDesignation, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getSoilHorizonDesignationCode(String name) =>
      (select(soilHorizonDesignation, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getSoilColorNameList() {
    final query = selectOnly(soilColor, distinct: true)
      ..addColumns([soilColor.name])
      ..where(soilColor.name.isNotNull());

    return query
        .map((row) => row.read(soilColor.name) ?? "error on loading name")
        .get();
  }

  Future<String> getSoilColorName(String code) async {
    if (code.isEmpty) return "";

    return (select(soilColor, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getSoilColorCode(String name) =>
      (select(soilColor, distinct: true)..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getSoilTextureNameList() {
    final query = selectOnly(soilTexture, distinct: true)
      ..addColumns([soilTexture.name])
      ..where(soilTexture.name.isNotNull());

    return query
        .map((row) => row.read(soilTexture.name) ?? "error on loading name")
        .get();
  }

  Future<String> getSoilTextureName(String code) async {
    if (code.isEmpty) return "";

    return (select(soilTexture, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getSoilTextureCode(String name) =>
      (select(soilTexture, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  //Small Tree Plot
  Future<List<String>> getStpTypeList() {
    final query = selectOnly(stpType, distinct: true)
      ..addColumns([stpType.name])
      ..where(stpType.name.isNotNull());

    return query
        .map((row) => row.read(stpType.name) ?? "error on loading name")
        .get();
  }

  Future<String> getStpTypeName(String code) async {
    if (code.isEmpty) return "";

    return (select(stpType, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getStpTypeCode(String name) =>
      (select(stpType, distinct: true)..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getStpOrigAreaList() {
    final query = selectOnly(stpOrigPlotArea, distinct: true)
      ..addColumns([stpOrigPlotArea.name])
      ..where(stpOrigPlotArea.name.isNotNull());

    return query
        .map((row) => row.read(stpOrigPlotArea.name) ?? "error on loading name")
        .get();
  }

  Future<String> getStpOrigAreaName(String code) async {
    if (code.isEmpty) return "";

    return (select(stpOrigPlotArea, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getStpOrigAreaCode(String name) =>
      (select(stpOrigPlotArea, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getStpStatusList() {
    final query = selectOnly(stpStatusField, distinct: true)
      ..addColumns([stpStatusField.name])
      ..where(stpStatusField.name.isNotNull());

    return query
        .map((row) => row.read(stpStatusField.name) ?? "error on loading name")
        .get();
  }

  Future<String> getStpStatusName(String code) async {
    if (code.isEmpty) return "";

    return (select(stpStatusField, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getStpStatusCode(String name) =>
      (select(stpStatusField, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getStpHeightList() {
    final query = selectOnly(stpHeight, distinct: true)
      ..addColumns([stpHeight.name])
      ..where(stpHeight.name.isNotNull());

    return query
        .map((row) => row.read(stpHeight.name) ?? "error on loading name")
        .get();
  }

  Future<String> getStpHeightName(String code) async {
    if (code.isEmpty) return "";

    return (select(stpHeight, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getStpHeightCode(String name) =>
      (select(stpHeight, distinct: true)..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getStpStemConditionList() {
    final query = selectOnly(stpStemCondition, distinct: true)
      ..addColumns([stpStemCondition.name])
      ..where(stpStemCondition.name.isNotNull());

    return query
        .map(
            (row) => row.read(stpStemCondition.name) ?? "error on loading name")
        .get();
  }

  Future<String> getStpStemConditionName(String code) async {
    if (code.isEmpty) return "";

    return (select(stpStemCondition, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getStpStemConditionCode(String name) =>
      (select(stpStemCondition, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getShrubPlotTypeList() {
    final query = selectOnly(shrubPlotType, distinct: true)
      ..addColumns([shrubPlotType.name])
      ..where(shrubPlotType.name.isNotNull());

    return query
        .map((row) => row.read(shrubPlotType.name) ?? "error on loading name")
        .get();
  }

  Future<String> getShrubPlotTypeName(String code) async {
    if (code.isEmpty) return "";

    return (select(shrubPlotType, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getShrubPlotTypeCode(String name) =>
      (select(shrubPlotType, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getShrubStatusList() {
    final query = selectOnly(shrubStatusField, distinct: true)
      ..addColumns([shrubStatusField.name])
      ..where(shrubStatusField.name.isNotNull());

    return query
        .map(
            (row) => row.read(shrubStatusField.name) ?? "error on loading name")
        .get();
  }

  Future<String> getShrubStatusName(String code) async {
    if (code.isEmpty) return "";

    return (select(shrubStatusField, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getShrubStatusCode(String name) =>
      (select(shrubStatusField, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getShrubBasalDiameterList() {
    final query = selectOnly(shrubBasalDiameter, distinct: true)
      ..addColumns([shrubBasalDiameter.name])
      ..where(shrubBasalDiameter.name.isNotNull());

    return query
        .map((row) =>
            row.read(shrubBasalDiameter.name) ?? "error on loading name")
        .get();
  }

  Future<String> getShrubBasalDiameterName(String code) async {
    if (code.isEmpty) return "";

    return (select(shrubBasalDiameter, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getShrubBasalDiameterCode(String name) =>
      (select(shrubBasalDiameter, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getStumpPlotTypeList() {
    final query = selectOnly(stumpPlotType, distinct: true)
      ..addColumns([stumpPlotType.name])
      ..where(stumpPlotType.name.isNotNull());

    return query
        .map((row) => row.read(stumpPlotType.name) ?? "error on loading name")
        .get();
  }

  Future<String> getStumpPlotTypeName(String code) async {
    if (code.isEmpty) return "";

    return (select(stumpPlotType, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getStumpPlotTypeCode(String name) =>
      (select(stumpPlotType, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getStumpOrigPlotAreaList() {
    final query = selectOnly(stumpOrigPlotArea, distinct: true)
      ..addColumns([stumpOrigPlotArea.name])
      ..where(stumpOrigPlotArea.name.isNotNull());

    return query
        .map((row) =>
            row.read(stumpOrigPlotArea.name) ?? "error on loading name")
        .get();
  }

  Future<String> getStumpOrigPlotAreaName(String code) async {
    if (code.isEmpty) return "";

    return (select(stumpOrigPlotArea, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getStumpOrigPlotAreaCode(String name) =>
      (select(stumpOrigPlotArea, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  //LTP
  Future<List<String>> getLtpPlotTypeList() {
    final query = selectOnly(ltpPlotType, distinct: true)
      ..addColumns([ltpPlotType.name])
      ..where(ltpPlotType.name.isNotNull());

    return query
        .map((row) => row.read(ltpPlotType.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpPlotTypeName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpPlotType, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpPlotTypeCode(String name) =>
      (select(ltpPlotType, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getLtpPlotSplitList() {
    final query = selectOnly(ltpPlotSplit, distinct: true)
      ..addColumns([ltpPlotSplit.name])
      ..where(ltpPlotSplit.name.isNotNull());

    return query
        .map((row) => row.read(ltpPlotSplit.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpPlotSplitName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpPlotSplit, distinct: true)
          ..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpPlotSplitCode(String name) =>
      (select(ltpPlotSplit, distinct: true)
            ..where((tbl) => tbl.name.equals(name)))
          .map((row) => row.code)
          .getSingle();

  Future<List<String>> getLtpOrigPlotAreaList() {
    final query = selectOnly(ltpOrigPlotArea, distinct: true)
      ..addColumns([ltpOrigPlotArea.name])
      ..where(ltpOrigPlotArea.name.isNotNull());

    return query
        .map((row) => row.read(ltpOrigPlotArea.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpOrigPlotAreaName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpOrigPlotArea)..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpOrigPlotAreaCode(String name) {
    return (select(ltpOrigPlotArea)..where((tbl) => tbl.name.equals(name)))
        .map((row) => row.code)
        .getSingle();
  }

  Future<List<String>> get ltpGenusLatinNames {
    final query = selectOnly(ltpGenus, distinct: true)
      ..addColumns([ltpGenus.genusLatinName]);
    return query.map((p0) => p0.read(ltpGenus.genusLatinName)!).get();
  }

  Future<String> getLtpGenusCodeFromName(String name) async {
    List<String> codes = await ((select(ltpGenus)
          ..where((tbl) => tbl.genusLatinName.equals(name)))
        .map((p0) => p0.genusCode)
        .get());
    return codes[0];
  }

  Future<String> getLtpGenusNameFromCode(String code) async {
    List<String> names = await ((select(ltpGenus)
          ..where((tbl) => tbl.genusCode.equals(code)))
        .map((p0) => p0.genusLatinName)
        .get());
    return names[0];
  }

  Future<List<String>> getLtpSpeciesNamesFromGenus(String genusCode) {
    final query = selectOnly(ltpGenus, distinct: true)
      ..addColumns([ltpGenus.speciesLatinName])
      ..where(ltpGenus.genusCode.equals(genusCode));

    return query
        .map((p0) =>
            p0.read(ltpGenus.speciesLatinName) ??
            "error on loading ltp species list")
        .get();
  }

  Future<bool> checkLtpNonNullSpeciesExists(String genusCode) async {
    List<String> speciesCodes = await ((select(ltpGenus)
          ..where((tbl) => tbl.genusCode.equals(genusCode)))
        .map((p0) => p0.speciesCode)
        .get());

    return speciesCodes.length == 1 && speciesCodes[0] == kSpeciesUnknownCode;
  }

  Future<String> getLtpSpeciesCode(String genusCode, String speciesName) =>
      (select(ltpGenus)
            ..where((tbl) =>
                tbl.genusCode.equals(genusCode) &
                tbl.speciesLatinName.equals(speciesName)))
          .map((p0) => p0.speciesCode)
          .getSingle();

  Future<String> getLtpSpeciesName(String genusCode, String speciesCode) =>
      (select(ltpGenus)
            ..where((tbl) =>
                tbl.genusCode.equals(genusCode) &
                tbl.speciesCode.equals(speciesCode)))
          .map((p0) => p0.speciesLatinName)
          .getSingle();

  Future<List<String>> getLtpVarietyNamesFromGenusSpecies(
      String genusCode, String speciesCode) {
    final query = selectOnly(ltpGenus, distinct: true)
      ..addColumns([ltpGenus.varietyLatinName])
      ..where(ltpGenus.varietyLatinName.isNotNull() &
          ltpGenus.genusCode.equals(genusCode) &
          ltpGenus.speciesCode.equals(speciesCode));

    return query
        .map((p0) =>
            p0.read(ltpGenus.varietyLatinName) ??
            "error on loading ltp variety list")
        .get();
  }

  Future<bool> checkLtpNonNullVarietyExists(
      String genusCode, String speciesCode) async {
    List<String> varietyCodes = await ((select(ltpGenus)
          ..where((tbl) =>
              tbl.genusCode.equals(genusCode) &
              tbl.speciesCode.equals(speciesCode)))
        .map((p0) => p0.varietyCode)
        .get());

    return varietyCodes.length == 1 && varietyCodes[0] == "NULL";
  }

  Future<String> getLtpVarietyCode(
          String genusCode, String speciesCode, String varietyName) =>
      (select(ltpGenus)
            ..where((tbl) =>
                tbl.genusCode.equals(genusCode) &
                tbl.speciesCode.equals(speciesCode) &
                tbl.varietyLatinName.equals(varietyName)))
          .map((p0) => p0.varietyCode)
          .getSingle();

  Future<String> getLtpVarietyName(
          String genusCode, String speciesCode, String varietyCode) =>
      (select(ltpGenus)
            ..where((tbl) =>
                tbl.genusCode.equals(genusCode) &
                tbl.speciesCode.equals(speciesCode) &
                tbl.varietyCode.equals(varietyCode)))
          .map((p0) => p0.varietyLatinName)
          .getSingle();

  Future<List<String>> getLtpStatusFieldList() {
    final query = selectOnly(ltpStatusField, distinct: true)
      ..addColumns([ltpStatusField.name])
      ..where(ltpStatusField.name.isNotNull());

    return query
        .map((row) => row.read(ltpStatusField.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpStatusFieldName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpStatusField)..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpStatusFieldCode(String name) {
    return (select(ltpStatusField)..where((tbl) => tbl.name.equals(name)))
        .map((row) => row.code)
        .getSingle();
  }

  Future<String> getLtpStatusFieldDescription(String code) {
    return (select(ltpStatusField)..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.description)
        .getSingle();
  }

  Future<List<String>> getLtpCrownClassFieldList() {
    final query = selectOnly(ltpCrownClassField, distinct: true)
      ..addColumns([ltpCrownClassField.name])
      ..where(ltpCrownClassField.name.isNotNull());
    return query
        .map((row) =>
            row.read(ltpCrownClassField.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpCrownClassFieldName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpCrownClassField)..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpCrownClassFieldCode(String name) {
    return (select(ltpCrownClassField)..where((tbl) => tbl.name.equals(name)))
        .map((row) => row.code)
        .getSingle();
  }

  Future<List<String>> getLtpBarkConditionList() {
    final query = selectOnly(ltpBarkCondition, distinct: true)
      ..addColumns([ltpBarkCondition.name])
      ..where(ltpBarkCondition.name.isNotNull());
    return query
        .map(
            (row) => row.read(ltpBarkCondition.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpBarkConditionName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpBarkCondition)..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpBarkConditionCode(String name) {
    return (select(ltpBarkCondition)..where((tbl) => tbl.name.equals(name)))
        .map((row) => row.code)
        .getSingle();
  }

  Future<List<String>> getLtpCrownConditionList() {
    final query = selectOnly(ltpCrownCondition, distinct: true)
      ..addColumns([ltpCrownCondition.name])
      ..where(ltpCrownCondition.name.isNotNull());
    return query
        .map((row) =>
            row.read(ltpCrownCondition.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpCrownConditionName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpCrownCondition)..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpCrownConditionCode(String name) {
    return (select(ltpCrownCondition)..where((tbl) => tbl.name.equals(name)))
        .map((row) => row.code)
        .getSingle();
  }

  Future<List<String>> getLtpStemConditionList() {
    final query = selectOnly(ltpStemCondition, distinct: true)
      ..addColumns([ltpStemCondition.name])
      ..where(ltpStemCondition.name.isNotNull());
    return query
        .map(
            (row) => row.read(ltpStemCondition.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpStemConditionName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpStemCondition)..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpStemConditionCode(String name) {
    return (select(ltpStemCondition)..where((tbl) => tbl.name.equals(name)))
        .map((row) => row.code)
        .getSingle();
  }

  Future<List<String>> getLtpWoodConditionList() {
    final query = selectOnly(ltpWoodCondition, distinct: true)
      ..addColumns([ltpWoodCondition.name])
      ..where(ltpWoodCondition.name.isNotNull());
    return query
        .map(
            (row) => row.read(ltpWoodCondition.name) ?? "error on loading name")
        .get();
  }

  Future<String> getLtpWoodConditionName(String code) async {
    if (code.isEmpty) return "";

    return (select(ltpWoodCondition)..where((tbl) => tbl.code.equals(code)))
        .map((row) => row.name)
        .getSingle();
  }

  Future<String> getLtpWoodConditionCode(String name) {
    return (select(ltpWoodCondition)..where((tbl) => tbl.name.equals(name)))
        .map((row) => row.code)
        .getSingle();
  }
}
