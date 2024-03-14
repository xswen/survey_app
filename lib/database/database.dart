import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' as d;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:survey_app/database/daos/small_tree_plot_tables_dao.dart';
import 'package:survey_app/database/daos/soil_pit_tables_dao.dart';
import 'package:survey_app/database/database_creation_files/large_tree_plot_tables.dart';
import 'package:survey_app/database/database_creation_files/small_tree_plot_tables.dart';
import 'package:survey_app/database/database_creation_files/soil_pit_tables.dart';
import 'package:survey_app/database/database_creation_files/stump_plot_tables.dart';
import 'package:survey_app/enums/enums.dart';
import 'package:survey_app/wrappers/survey_card.dart';

import '../database/daos/reference_tables_dao.dart';
import '../database/daos/survey_info_tables_dao.dart';
import '../database/daos/woody_debris_tables_dao.dart';
import '../database/database_creation_files/reference_tables.dart';
import '../database/database_creation_files/survey_info_tables.dart';
import 'daos/ecological_plot_tables_dao.dart';
import 'daos/surface_substrate_tables_dao.dart';
import 'database_creation_files/ecological_plot_tables.dart';
import 'database_creation_files/metadata_tables.dart';
import 'database_creation_files/shrub_plot_tables.dart';
import 'database_creation_files/surface_substrate_tables.dart';
import 'database_creation_files/woody_debris_tables.dart';

part 'database.g.dart';

const List<Type> _tables = [
  //Reference Tables
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
  //Metadata Tables
  MetaComment,
  //Survey Tables
  SurveyHeaders,
  SurveySummary,
  SurveyHeaderGroundPhoto,
  SurveyHeaderTree,
  SurveyHeaderEcological,
  SurveyHeaderSoil,
  //Woody Debris Tables
  WoodyDebrisSummary,
  WoodyDebrisHeader,
  WoodyDebrisSmall,
  WoodyDebrisOdd,
  WoodyDebrisRound,
  //Surface Substrate Tables
  SurfaceSubstrateSummary,
  SurfaceSubstrateHeader,
  SurfaceSubstrateTally,
  //ECP Tables
  EcpSummary,
  EcpHeader,
  EcpSpecies,
  //Soil Tables
  SoilPitSummary,
  SoilSiteInfo,
  SoilPitFeature,
  SoilPitHorizonDescription,
  //LPT
  LtpSummary,
  LtpTree,
  LtpTreeDamage,
  LtpTreeRemoved,
  LtpTreeAge,
  LtpTreeRenamed,
  //STP
  StpSummary,
  StpSpecies,
  //Shrub
  ShrubSummary,
  ShrubListEntry,
  //Stump
  StumpSummary,
  StumpEntry,
];

const List<Type> _daos = [
  ReferenceTablesDao,
  SurveyInfoTablesDao,
  WoodyDebrisTablesDao,
  SurfaceSubstrateTablesDao,
  EcologicalPlotTablesDao,
  SoilPitTablesDao,
  SmallTreePlotTablesDao,
];

const String woodyDebrisPieceViewQuery =
    "SELECT COALESCE(odd.wd_header_id, round.wd_header_id) as wd_header_id,"
    "  COALESCE(odd.piece_num, round.piece_num) as piece_num"
    " FROM   woody_debris_odd as odd"
    " LEFT JOIN woody_debris_round as round"
    " ON odd.id = round.id"
    " UNION ALL"
    " SELECT COALESCE(odd.wd_header_id, round.wd_header_id) as wd_header_id,"
    "    COALESCE(odd.piece_num, round.piece_num) as piece_num"
    " FROM   woody_debris_round as round"
    " LEFT JOIN woody_debris_odd as odd"
    " ON round.id = odd.id"
    " WHERE  odd.id IS NULL ";

@DriftDatabase(tables: _tables, daos: _daos
    //views: [WoodyDebrisPiecesView],
    )
class Database extends _$Database {
  //Database(QueryExecutor e) : super(e);
  Database._() : super(_debugConnection());

  static final Database _instance = Database._();
  static Database get instance => _instance;

  @override
  int get schemaVersion => 1;

  //Temporary database that resets every hot restart
  static _debugConnection() {
    return NativeDatabase.memory();
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }

  String companionValueToStr(value) => (value == null ||
          value == const d.Value.absent() ||
          value == const d.Value(null))
      ? ""
      : value.value.toString();

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          List<TreeGenusCompanion> treeList = await _getTreeGenuses();
          List<JurisdictionsCompanion> jurisdictionsList =
              await _getJurisdictions();
          List<PlotsCompanion> nfiPlotList = await _getNfiPlots();
          List<SubstrateTypeCompanion> substrateTypeList =
              await _getSubstrateTypes();
          List<SsDepthLimitCompanion> ssDepthLimitList =
              await _getSsDepthLimits();

          List<EcpLayerCompanion> ecpLayerList = await _getEcpLayers();
          List<EcpGenusCompanion> ecpGenusList = await _getEcpGenuses();
          List<EcpPlotTypeCompanion> ecpPlotTypeList = await _getEcpPlotTypes();

          List<SoilPitClassificationCompanion> soilPitClassificationList =
              await _getSoilPitClassifications();
          List<SoilDrainageClassCompanion> soilDrainageList =
              await _getSoilDrainageClass();
          List<SoilMoistureClassCompanion> soilMoistureList =
              await _getSoilMoistureClass();
          List<SoilDepositionCompanion> soilDepositionList =
              await _getSoilDeposition();
          List<SoilHumusFormCompanion> soilHumusFormList =
              await _getSoilHumusForm();
          List<SoilPitCodeCompanion> soilPitCodeFieldList =
              await _getSoilPitCodes();
          List<SoilPitFeatureClassCompanion> soilPitFeatureList =
              await _getSoilPitFeatures();
          List<SoilHorizonDesignationCompanion> soilHorizonDesignationList =
              await _getSoilHorizonDesignations();
          List<SoilColorCompanion> soilColorList = await _getSoilColors();
          List<SoilTextureCompanion> soilTextureList = await _getSoilTextures();

          List<StpTypeCompanion> stpTypeList = await _getStpCode();
          List<StpOrigPlotAreaCompanion> stpOrigAreaList =
              await _getStpOrigPlotArea();
          List<StpStatusFieldCompanion> stpStatusList = await _getStpStatus();
          List<StpHeightCompanion> stpHeightList = await _getStpHeight();
          List<StpStemConditionCompanion> stpStemConditionList =
              await _getStpStemCondition();

          List<ShrubBasalDiameterCompanion> shrubBasalDiameterList =
              await _getShrubBasalDiameter();
          List<ShrubPlotTypeCompanion> shrubPlotTypeList =
              await _getShrubPlotType();
          List<ShrubStatusFieldCompanion> shrubStatusList =
              await _getShrubStatusField();

          List<StumpPlotTypeCompanion> stumpPlotTypeList =
              await _getStumpPlotType();
          List<StumpOrigPlotAreaCompanion> stumpOrigPlotAreaList =
              await _getStumpOrigPlotArea();

          List<LtpPlotTypeCompanion> ltpPlotTypeList = await _getLtpPlotType();
          List<LtpPlotSplitCompanion> ltpPlotSplitList =
              await _getLtpPlotSplit();
          List<LtpGenusCompanion> ltpGenusList = await _getLtpGenus();
          List<LtpOrigPlotAreaCompanion> ltpOrigPlotList =
              await _getLtpOrigPlotArea();
          List<LtpStatusFieldCompanion> ltpStatusList = await _getLtpStatus();
          List<LtpCrownClassFieldCompanion> ltpCrownClassList =
              await _getLtpCrownClass();
          List<LtpBarkConditionCompanion> ltpBarkConditionList =
              await _getLtpBarkCondition();
          List<LtpCrownConditionCompanion> ltpCrownConditionList =
              await _getLtpCrownCondition();
          List<LtpStemConditionCompanion> ltpStemConditionList =
              await _getLtpStemCondition();
          List<LtpWoodConditionCompanion> ltpWoodConditionList =
              await _getLtpWoodCondition();
          List<LtpQuadrantCompanion> ltpQuadrantList = await _getLtpQuadrant();
          List<LtpTreeTypeCompanion> ltpTreeTypeList = await _getLtpTreeType();
          List<LtpSiteHeightSuitabilityCompanion> ltpSiteHeightSuitabilityList =
              await _getLtpSiteHeightSuitability();
          List<LtpSiteAgeSuitabilityCompanion> ltpSiteAgeSuitabilityList =
              await _getLtpSiteAgeSuitability();
          List<LtpProrateCompanion> ltpProrateList = await _getLtpProrate();

          c.debugPrint("Init Values");
          await batch((b) {
            b.insertAll(jurisdictions, jurisdictionsList);
            b.insertAllOnConflictUpdate(treeGenus, treeList);
            b.insertAll(plots, nfiPlotList);
            b.insertAll(substrateType, substrateTypeList);
            b.insertAll(ssDepthLimit, ssDepthLimitList);

            b.insertAll(ecpLayer, ecpLayerList);
            b.insertAll(ecpGenus, ecpGenusList);
            b.insertAll(ecpPlotType, ecpPlotTypeList);

            b.insertAll(soilPitClassification, soilPitClassificationList);
            b.insertAll(soilDrainageClass, soilDrainageList);
            b.insertAll(soilMoistureClass, soilMoistureList);
            b.insertAll(soilDeposition, soilDepositionList);
            b.insertAll(soilHumusForm, soilHumusFormList);
            b.insertAll(soilPitCode, soilPitCodeFieldList);
            b.insertAll(soilPitFeatureClass, soilPitFeatureList);
            b.insertAll(soilHorizonDesignation, soilHorizonDesignationList);
            b.insertAll(soilColor, soilColorList);
            b.insertAll(soilTexture, soilTextureList);

            b.insertAll(stpType, stpTypeList);
            b.insertAll(stpOrigPlotArea, stpOrigAreaList);
            b.insertAll(stpStatusField, stpStatusList);
            b.insertAll(stpHeight, stpHeightList);
            b.insertAll(stpStemCondition, stpStemConditionList);

            b.insertAll(shrubBasalDiameter, shrubBasalDiameterList);
            b.insertAll(shrubPlotType, shrubPlotTypeList);
            b.insertAll(shrubStatusField, shrubStatusList);

            b.insertAll(stumpPlotType, stumpPlotTypeList);
            b.insertAll(stumpOrigPlotArea, stumpOrigPlotAreaList);

            b.insertAll(ltpPlotType, ltpPlotTypeList);
            b.insertAll(ltpPlotSplit, ltpPlotSplitList);
            b.insertAll(ltpGenus, ltpGenusList);
            b.insertAll(ltpOrigPlotArea, ltpOrigPlotList);
            b.insertAll(ltpStatusField, ltpStatusList);
            b.insertAll(ltpCrownClassField, ltpCrownClassList);
            b.insertAll(ltpBarkCondition, ltpBarkConditionList);
            b.insertAll(ltpCrownCondition, ltpCrownConditionList);
            b.insertAll(ltpStemCondition, ltpStemConditionList);
            b.insertAll(ltpWoodCondition, ltpWoodConditionList);
            b.insertAll(ltpQuadrant, ltpQuadrantList);
            b.insertAll(ltpTreeType, ltpTreeTypeList);
            b.insertAll(ltpSiteHeightSuitability, ltpSiteHeightSuitabilityList);
            b.insertAll(ltpSiteAgeSuitability, ltpSiteAgeSuitabilityList);
            b.insertAll(ltpProrate, ltpProrateList);

            _initTest(b);
          });
        },
        beforeOpen: (m) async {},
      );

  Future<List<dynamic>> _loadJsonData(String path) async {
    final jsonFile = await rootBundle.loadString(path);
    final List<dynamic> jsonData = json.decode(jsonFile) as List<dynamic>;
    return jsonData;
    //return jsonData.map((entry) => TreeGenus.fromJson(entry)).toList();
  }

  Future<List<JurisdictionsCompanion>> _getJurisdictions() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/jurisdiction_list.json');
    return jsonData.map((dynamic item) {
      return JurisdictionsCompanion(
        code: Value(item['code']),
        nameEn: Value(item['nameEn']),
        nameFr: Value(item['nameFr']),
      );
    }).toList();
  }

  Future<List<TreeGenusCompanion>> _getTreeGenuses() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/tree_list.json');
    return jsonData.map((dynamic item) {
      return TreeGenusCompanion(
        genusCode: Value(item['genusCode'] ?? ""),
        speciesCode: Value(item['speciesCode'] ?? ""),
        genusLatinName: Value(item['genusLatinName'] ?? ""),
        speciesLatinName: Value(item['speciesLatinName'] ?? ""),
        commonNameEn: Value(item['commonNameEn'] ?? ""),
        commonNameFr: Value(item['commonNameFr'] ?? ""),
      );
    }).toList();
  }

  Future<List<PlotsCompanion>> _getNfiPlots() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/gp_plots_list.json');
    return jsonData.map((dynamic item) {
      return PlotsCompanion(
          code: Value(item["code"]),
          nfiPlot: Value(item["nfiPlot"]),
          lastMeasNum: item["lastMeasNum"] == null
              ? Value(item["lastMeasNum"])
              : const Value.absent());
    }).toList();
  }

  Future<List<SubstrateTypeCompanion>> _getSubstrateTypes() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/substrate_type_list.json');
    return jsonData.map((dynamic item) {
      return SubstrateTypeCompanion(
          typeCode: Value(item["typeCode"]),
          nameEn: Value(item["nameEn"]),
          nameFr: Value(item["nameFr"]),
          hasDepth: Value(item["hasDepth"]));
    }).toList();
  }

  Future<List<SsDepthLimitCompanion>> _getSsDepthLimits() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ss_depth_limit_list.json');
    return jsonData.map((dynamic item) {
      return SsDepthLimitCompanion(
          code: Value(item["code"]),
          nameEn: Value(item["nameEn"]),
          nameFr: Value(item["nameFr"]));
    }).toList();
  }

  Future<List<EcpLayerCompanion>> _getEcpLayers() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/ecp_layer_list.json');

    // Map the JSON data to a list of `SpeciesDataCompanion` objects
    return jsonData.map((dynamic item) {
      return EcpLayerCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<EcpGenusCompanion>> _getEcpGenuses() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/ecp_species_list.json');

    // Map the JSON data to a list of `SpeciesDataCompanion` objects
    return jsonData.map((dynamic item) {
      return EcpGenusCompanion(
        genus: Value(item["genus"]),
        species: Value(item["species"]),
        variety: Value(item["variety"]),
      );
    }).toList();
  }

  Future<List<EcpPlotTypeCompanion>> _getEcpPlotTypes() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/ecp_plot_type.json');

    return jsonData.map((dynamic item) {
      return EcpPlotTypeCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilDrainageClassCompanion>> _getSoilDrainageClass() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/sp_drainage_class_list.json');

    return jsonData.map((dynamic item) {
      return SoilDrainageClassCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilMoistureClassCompanion>> _getSoilMoistureClass() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/sp_moisture_class_list.json');

    return jsonData.map((dynamic item) {
      return SoilMoistureClassCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilDepositionCompanion>> _getSoilDeposition() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/sp_deposition_list.json');

    return jsonData.map((dynamic item) {
      return SoilDepositionCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilHumusFormCompanion>> _getSoilHumusForm() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/sp_soil_humus_form_list.json');

    return jsonData.map((dynamic item) {
      return SoilHumusFormCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilPitCodeCompanion>> _getSoilPitCodes() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/sp_pit_code_field.json');

    return jsonData.map((dynamic item) {
      return SoilPitCodeCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilPitClassificationCompanion>>
      _getSoilPitClassifications() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/sp_classification_codes.json');

    return jsonData.map((dynamic item) {
      return SoilPitClassificationCompanion(
        code: Value(item["code"]),
        order: Value(item["order"]),
        greatGroup: Value(item["greatGroup"]),
        subGroup: Value(item["subGroup"]),
      );
    }).toList();
  }

  Future<List<SoilPitFeatureClassCompanion>> _getSoilPitFeatures() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/sp_feature.json');

    return jsonData.map((dynamic item) {
      return SoilPitFeatureClassCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilHorizonDesignationCompanion>>
      _getSoilHorizonDesignations() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/sp_horizon_designation.json');

    return jsonData.map((dynamic item) {
      return SoilHorizonDesignationCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilColorCompanion>> _getSoilColors() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/sp_color_list.json');

    return jsonData.map((dynamic item) {
      return SoilColorCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilTextureCompanion>> _getSoilTextures() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/sp_texture_list.json');

    return jsonData.map((dynamic item) {
      return SoilTextureCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<StpTypeCompanion>> _getStpCode() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/stp_plot_type_list.json');

    return jsonData.map((dynamic item) {
      return StpTypeCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<StpOrigPlotAreaCompanion>> _getStpOrigPlotArea() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/stp_orig_plot_area_list.json');

    return jsonData.map((dynamic item) {
      return StpOrigPlotAreaCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<StpStatusFieldCompanion>> _getStpStatus() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/stp_plot_status_list.json');

    return jsonData.map((dynamic item) {
      return StpStatusFieldCompanion(
          code: Value(item["code"]),
          name: Value(item["name"]),
          description: Value(item["description"]));
    }).toList();
  }

  Future<List<StpHeightCompanion>> _getStpHeight() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/stp_height_list.json');

    return jsonData.map((dynamic item) {
      return StpHeightCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<StpStemConditionCompanion>> _getStpStemCondition() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/stp_stem_condition_list.json');

    return jsonData.map((dynamic item) {
      return StpStemConditionCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<ShrubPlotTypeCompanion>> _getShrubPlotType() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/shrub_plot_type_list.json');

    return jsonData.map((dynamic item) {
      return ShrubPlotTypeCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<ShrubBasalDiameterCompanion>> _getShrubBasalDiameter() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/shrub_basal_diameter_list.json');

    return jsonData.map((dynamic item) {
      return ShrubBasalDiameterCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<ShrubStatusFieldCompanion>> _getShrubStatusField() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/shrub_status_list.json');

    return jsonData.map((dynamic item) {
      return ShrubStatusFieldCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<StumpPlotTypeCompanion>> _getStumpPlotType() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/stump_plot_type_list.json');

    return jsonData.map((dynamic item) {
      return StumpPlotTypeCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<StumpOrigPlotAreaCompanion>> _getStumpOrigPlotArea() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/stump_orig_plot_area_list.json');

    return jsonData.map((dynamic item) {
      return StumpOrigPlotAreaCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  //LTP
  Future<List<LtpPlotTypeCompanion>> _getLtpPlotType() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/ltp_plot_type_list.json');

    return jsonData.map((dynamic item) {
      return LtpPlotTypeCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<LtpPlotSplitCompanion>> _getLtpPlotSplit() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_plot_split_list.json');

    return jsonData.map((dynamic item) {
      return LtpPlotSplitCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<LtpGenusCompanion>> _getLtpGenus() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/ltp_tree_list.json');

    return jsonData.map((dynamic item) {
      return LtpGenusCompanion(
        genusLatinName: Value(item["genusLatinName"]),
        speciesLatinName: Value(item["speciesLatinName"]),
        varietyLatinName: Value(item["varietyLatinName"]),
        genusCode: Value(item["genusCode"]),
        speciesCode: Value(item["speciesCode"]),
        varietyCode: Value(item["varietyCode"]),
      );
    }).toList();
  }

  Future<List<LtpOrigPlotAreaCompanion>> _getLtpOrigPlotArea() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_orig_plot_area_list.json');

    return jsonData.map((dynamic item) {
      return LtpOrigPlotAreaCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<LtpStatusFieldCompanion>> _getLtpStatus() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_tree_status_list.json');

    return jsonData.map((dynamic item) {
      return LtpStatusFieldCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
        description: Value(item["description"]),
      );
    }).toList();
  }

  Future<List<LtpCrownClassFieldCompanion>> _getLtpCrownClass() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_crown_class_list.json');
    return jsonData.map((dynamic item) {
      return LtpCrownClassFieldCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<LtpBarkConditionCompanion>> _getLtpBarkCondition() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_bark_condition_list.json');
    return jsonData.map((dynamic item) {
      return LtpBarkConditionCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<LtpCrownConditionCompanion>> _getLtpCrownCondition() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_crown_condition_list.json');
    return jsonData.map((dynamic item) {
      return LtpCrownConditionCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<LtpStemConditionCompanion>> _getLtpStemCondition() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_stem_condition_list.json');
    return jsonData.map((dynamic item) {
      return LtpStemConditionCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<LtpWoodConditionCompanion>> _getLtpWoodCondition() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_wood_condition_list.json');
    return jsonData.map((dynamic item) {
      return LtpWoodConditionCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<LtpQuadrantCompanion>> _getLtpQuadrant() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/ltp_quadrant_list.json');
    return jsonData
        .map((dynamic item) => LtpQuadrantCompanion(
              code: Value(item["code"]),
              name: Value(item["name"]),
            ))
        .toList();
  }

  Future<List<LtpTreeTypeCompanion>> _getLtpTreeType() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/ltp_tree_type_list.json');
    return jsonData
        .map((dynamic item) => LtpTreeTypeCompanion(
              code: Value(item["code"]),
              name: Value(item["name"]),
            ))
        .toList();
  }

  Future<List<LtpSiteHeightSuitabilityCompanion>>
      _getLtpSiteHeightSuitability() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_site_height_suitability_list.json');
    return jsonData
        .map((dynamic item) => LtpSiteHeightSuitabilityCompanion(
              code: Value(item["code"]),
              name: Value(item["name"]),
            ))
        .toList();
  }

  Future<List<LtpSiteAgeSuitabilityCompanion>>
      _getLtpSiteAgeSuitability() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/ltp_site_age_suitability_list.json');
    return jsonData
        .map((dynamic item) => LtpSiteAgeSuitabilityCompanion(
              code: Value(item["code"]),
              name: Value(item["name"]),
            ))
        .toList();
  }

  Future<List<LtpProrateCompanion>> _getLtpProrate() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/ltp_prorate_list.json');
    return jsonData
        .map((dynamic item) => LtpProrateCompanion(
              code: Value(item["code"]),
              name: Value(item["name"]),
            ))
        .toList();
  }

  void _initTest(Batch b) {
    b.replace(
        plots,
        const PlotsCompanion(
            nfiPlot: Value(916316), code: Value("PE"), lastMeasNum: Value(1)));
    b.replace(
        plots,
        const PlotsCompanion(
            nfiPlot: Value(1121871), code: Value("AB"), lastMeasNum: Value(2)));
    _initSurveys(b);
    _initWoodyDebris(b);
    _initEcp(b);
  }

  void _initSurveys(Batch b) {
    b.insertAll(surveyHeaders, [
      SurveyHeadersCompanion(
          id: const d.Value(1),
          nfiPlot: const d.Value(916316),
          measDate: d.Value(DateTime.now()),
          measNum: const d.Value(1),
          province: const d.Value("PE")),
      SurveyHeadersCompanion(
          id: const d.Value(2),
          nfiPlot: const d.Value(1121871),
          measDate: d.Value(DateTime.now()),
          measNum: const d.Value(2),
          province: const d.Value("AB")),
    ]);
  }

  void _initWoodyDebris(Batch b) {
    b.insert(
        woodyDebrisSummary,
        WoodyDebrisSummaryCompanion(
          id: const d.Value(1),
          surveyId: const d.Value(1),
          measDate: d.Value(DateTime.now()),
          numTransects: const d.Value(1),
        ));
    b.insert(
        woodyDebrisHeader,
        const WoodyDebrisHeaderCompanion(
            id: d.Value(1),
            wdId: d.Value(1),
            transNum: d.Value(1),
            nomTransLen: d.Value(150),
            transAzimuth: d.Value(33),
            swdMeasLen: d.Value(2),
            mcwdMeasLen: d.Value(22),
            lcwdMeasLen: d.Value(33)));
    b.insertAll(woodyDebrisOdd, [
      const WoodyDebrisOddCompanion(
        wdHeaderId: d.Value(1),
        pieceNum: d.Value(1),
        accumOdd: d.Value("AC"),
        genus: d.Value("UNKN"),
        species: d.Value("SPP"),
        horLength: d.Value(55.5),
        verDepth: d.Value(55.5),
        decayClass: d.Value(-1),
      ),
      const WoodyDebrisOddCompanion(
        wdHeaderId: d.Value(1),
        pieceNum: d.Value(2),
        accumOdd: d.Value("AC"),
        genus: d.Value("ACER"),
        species: d.Value("SPP"),
        horLength: d.Value(55.5),
        verDepth: d.Value(55.5),
        decayClass: d.Value(-1),
      )
    ]);
    b.insert(
        woodyDebrisRound,
        const WoodyDebrisRoundCompanion(
          wdHeaderId: d.Value(1),
          pieceNum: d.Value(3),
          genus: d.Value("ACER"),
          species: d.Value("SPP"),
          diameter: d.Value(55.5),
          tiltAngle: d.Value(44),
          decayClass: d.Value(-1),
        ));
  }

  void _initEcp(Batch b) {
    b.insert(
        ecpSummary,
        EcpSummaryCompanion(
          id: const d.Value(1),
          surveyId: const d.Value(1),
          measDate: d.Value(DateTime.now()),
          numEcps: const d.Value(1),
        ));
    b.insert(
        ecpHeader,
        const EcpHeaderCompanion(
          id: d.Value(1),
          ecpSummaryId: d.Value(1),
          plotType: d.Value("ES"),
          ecpNum: d.Value(1),
        ));
  }

  Future<List<SurveyCard>> getCards(int surveyId,
      {HashSet<SurveyStatus>? filters}) async {
    bool checkFilter(dynamic cardData) {
      /*
      * - Not Started: Occurs when `data == null`. In all other cases, `data != null`.
      * - Complete: True only if `data!.complete == true`.
      * - Not Assessed: True only if `notAssessed == true`.
      * - In Progress: True only if `data!.complete == false` AND `notAssessed == false`.
       */

      if (filters == null || filters.isEmpty) {
        return true;
      }

      //Check if notStarted cards are valid
      if (cardData == null) {
        return filters.contains(SurveyStatus.notStarted);
      }

      if (filters.contains(SurveyStatus.inProgress) &&
          (cardData!.complete == false && cardData!.notAssessed == false)) {
        return true;
      }

      if (filters.contains(SurveyStatus.complete) &&
          cardData!.complete == true) {
        return true;
      }

      if (filters.contains(SurveyStatus.notAssessed) &&
          cardData!.notAssessed == true) {
        return true;
      }

      return false;
    }

    const String category = "category";
    const String name = "name";
    const String surveyCardData = "surveyCardData";

    var operations = [
      {
        category: SurveyCardCategories.surveyHeader,
        name: "Survey Header",
        surveyCardData: await (select(surveySummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        category: SurveyCardCategories.groundPlot,
        name: "Ground Plot Info",
        surveyCardData: null
      },
      {
        category: SurveyCardCategories.woodyDebris,
        name: "Woody Debris",
        surveyCardData: await (select(woodyDebrisSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        category: SurveyCardCategories.surfaceSubstrate,
        name: "Surface Substrate",
        surveyCardData: await (select(surfaceSubstrateSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        category: SurveyCardCategories.ecologicalPlot,
        name: "Ecological Plot",
        surveyCardData: await (select(ecpSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        category: SurveyCardCategories.soilPit,
        name: "Soil Pit",
        surveyCardData: await (select(soilPitSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        category: SurveyCardCategories.smallTreePlot,
        name: "Small Tree Plot",
        surveyCardData: await (select(stpSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        category: SurveyCardCategories.shrubPlot,
        name: "Shrub Plot",
        surveyCardData: await (select(shrubSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        category: SurveyCardCategories.stumpPlot,
        name: "Stump Plot",
        surveyCardData: await (select(stumpSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        category: SurveyCardCategories.largeTreePlot,
        name: "Large Tree Plot",
        surveyCardData: await (select(ltpSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
    ];

    List<SurveyCard> cards = [];
    for (var op in operations) {
      checkFilter(op[surveyCardData])
          ? cards.add(SurveyCard(op[category] as SurveyCardCategories,
              op[name] as String, op[surveyCardData] as dynamic))
          : null;
    }

    return cards;
  }
}
