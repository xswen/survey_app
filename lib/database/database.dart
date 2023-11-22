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
import 'package:survey_app/database/daos/soil_pit_tables_dao.dart';
import 'package:survey_app/database/database_creation_files/soil_pit_tables.dart';
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
  SoilPitClassification,
  SoilDrainageClass,
  SoilMoistureClass,
  SoilDeposition,
  SoilHumusForm,
  SoilPitCodeCompiled,
  SoilPitCodeField,
  SoilPitFeatureClass,
  SoilHorizonDesignation,
  SoilColor,
  SoilTexture,

  //Metadata Tables
  MetaComment,
  //Survey Tables
  SurveyHeaders,
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
  SoilPitDepth,
  SoilPitFeature,
  SoilPitHorizonDescription,
];

const List<Type> _daos = [
  ReferenceTablesDao,
  SurveyInfoTablesDao,
  WoodyDebrisTablesDao,
  SurfaceSubstrateTablesDao,
  EcologicalPlotTablesDao,
  SoilPitTablesDao,
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
          List<SoilPitCodeCompiledCompanion> soilPitCodeList =
              await _getSoilPitCodeCompiled();
          List<SoilPitCodeFieldCompanion> soilPitCodeFieldList =
              await _getSoilPitCodeFields();
          List<SoilPitFeatureClassCompanion> soilPitFeatureList =
              await _getSoilPitFeatures();
          List<SoilHorizonDesignationCompanion> soilHorizonDesignationList =
              await _getSoilHorizonDesignations();
          List<SoilColorCompanion> soilColorList = await _getSoilColors();
          List<SoilTextureCompanion> soilTextureList = await _getSoilTextures();

          c.debugPrint("Init Values");
          await batch((b) {
            b.insertAll(jurisdictions, jurisdictionsList);
            b.insertAllOnConflictUpdate(treeGenus, treeList);
            b.insertAll(plots, nfiPlotList);
            b.insertAll(substrateType, substrateTypeList);
            b.insertAll(ssDepthLimit, ssDepthLimitList);

            b.insertAll(ecpLayer, ecpLayerList);
            b.insertAll(ecpGenus, ecpGenusList);

            //  b.insertAll(soilPitClassification, soilPitClassificationList);
            b.insertAll(soilPitClassification, soilPitClassificationList);
            b.insertAll(soilDrainageClass, soilDrainageList);
            b.insertAll(soilMoistureClass, soilMoistureList);
            b.insertAll(soilDeposition, soilDepositionList);
            b.insertAll(soilHumusForm, soilHumusFormList);
            b.insertAll(soilPitCodeCompiled, soilPitCodeList);
            b.insertAll(soilPitCodeField, soilPitCodeFieldList);
            b.insertAll(soilPitFeatureClass, soilPitFeatureList);
            b.insertAll(soilHorizonDesignation, soilHorizonDesignationList);
            b.insertAll(soilColor, soilColorList);
            b.insertAll(soilTexture, soilTextureList);

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

  Future<List<SoilPitCodeCompiledCompanion>> _getSoilPitCodeCompiled() async {
    List<dynamic> jsonData = await _loadJsonData(
        'assets/db_reference_data/sp_pit_code_completed.json');

    return jsonData.map((dynamic item) {
      return SoilPitCodeCompiledCompanion(
        code: Value(item["code"]),
        name: Value(item["name"]),
      );
    }).toList();
  }

  Future<List<SoilPitCodeFieldCompanion>> _getSoilPitCodeFields() async {
    List<dynamic> jsonData =
        await _loadJsonData('assets/db_reference_data/sp_pit_code_field.json');

    return jsonData.map((dynamic item) {
      return SoilPitCodeFieldCompanion(
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
    //_initEcp(b);
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
          ecpNum: d.Value(1),
        ));
  }

  Future<List<SurveyCard>> getCards(int surveyId,
      {HashSet<SurveyStatus>? filters}) async {
    bool checkFilter(dynamic cardData) {
      //No filter
      if (filters == null || filters.isEmpty) {
        return true;
      }

      //Check if notStarted cards are valid
      if (cardData == null) {
        return filters.contains(SurveyStatus.notStarted);
      }

      if (filters.contains(SurveyStatus.inProgress) &&
          cardData!.complete == false) {
        return true;
      }

      if (filters.contains(SurveyStatus.complete) &&
          cardData!.complete == true) {
        return true;
      }

      return false;
    }

    var operations = [
      {
        "category": SurveyCardCategories.woodyDebris,
        "name": "Woody Debris",
        "surveyCardData": await (select(woodyDebrisSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        "category": SurveyCardCategories.surfaceSubstrate,
        "name": "Surface Substrate",
        "surveyCardData": await (select(surfaceSubstrateSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        "category": SurveyCardCategories.ecologicalPlot,
        "name": "Ecological Plot",
        "surveyCardData": await (select(ecpSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
      {
        "category": SurveyCardCategories.soilPit,
        "name": "Soil Pit",
        "surveyCardData": await (select(soilPitSummary)
              ..where((tbl) => tbl.surveyId.equals(surveyId)))
            .getSingleOrNull()
      },
    ];

    List<SurveyCard> cards = [];
    for (var op in operations) {
      checkFilter(op["surveyCardData"])
          ? cards.add(SurveyCard(op["category"] as SurveyCardCategories,
              op["name"] as String, op["surveyCardData"] as dynamic))
          : null;
    }

    return cards;
  }

  String companionValueToStr(value) => (value == null ||
          value == const d.Value.absent() ||
          value == const d.Value(null))
      ? ""
      : value.value.toString();
}
