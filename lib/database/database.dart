import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' as d;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
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
  Jurisdictions, Plots, TreeGenus,
  EcpGenus, EcpVariety,
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
  EcpSpecies
];

const List<Type> _daos = [
  ReferenceTablesDao,
  SurveyInfoTablesDao,
  WoodyDebrisTablesDao,
  SurfaceSubstrateTablesDao,
  EcologicalPlotTablesDao,
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

          c.debugPrint("Init Values");
          await batch((b) {
            b.insertAll(jurisdictions, jurisdictionsList);
            b.insertAllOnConflictUpdate(treeGenus, treeList);
            b.insertAll(plots, nfiPlotList);

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

  void _initTest(Batch b) {
    b.replace(
        plots,
        const PlotsCompanion(
            nfiPlot: Value(916316), code: Value("PE"), lastMeasNum: Value(1)));
    _initSurveys(b);
    _initWoodyDebris(b);
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
            id: d.Value(1), wdId: d.Value(1), transNum: d.Value(1)));
    b.insertAll(woodyDebrisOdd, [
      const WoodyDebrisOddCompanion(
        wdHeaderId: d.Value(1),
        pieceNum: d.Value(1),
        accumOdd: d.Value("AC"),
        genus: d.Value("UNKN"),
        species: d.Value("UNK"),
        horLength: d.Value(55.5),
        verDepth: d.Value(55.5),
        decayClass: d.Value(-1),
      ),
      const WoodyDebrisOddCompanion(
        wdHeaderId: d.Value(1),
        pieceNum: d.Value(2),
        accumOdd: d.Value("AC"),
        genus: d.Value("ACER"),
        species: d.Value("UNK"),
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
          species: d.Value("UNK"),
          diameter: d.Value(55.5),
          tiltAngle: d.Value(44),
          decayClass: d.Value(-1),
        ));
  }

  Future<List<SurveyCard>> getCards(int surveyId) async {
    return [
      SurveyCard(
          SurveyCardCategories.woodyDebris,
          "Woody Debris",
          await (select(woodyDebrisSummary)
                ..where((tbl) => tbl.surveyId.equals(surveyId)))
              .getSingleOrNull()),
      SurveyCard(
          SurveyCardCategories.surfaceSubstrate,
          "Surface Substrate",
          await (select(surfaceSubstrateSummary)
                ..where((tbl) => tbl.surveyId.equals(surveyId)))
              .getSingleOrNull()),
    ];
  }
}
