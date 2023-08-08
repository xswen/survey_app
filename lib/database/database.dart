import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' as d;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
  Database() : super(_debugConnection());

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
          List<TreeGenusCompanion> trees = await insertTreeGenuses();

          // referenceTablesDao.clearTables();
          // woodyDebrisTablesDao.clearTables();
          // surfaceSubstrateTablesDao.clearTables();
          // ecologicalPlotTablesDao.clearTables();

          c.debugPrint("Init Values");
          await batch((b) {
            b.insertAll(plots, [
              const PlotsCompanion(
                  nfiPlot: d.Value(1),
                  code: d.Value("ON"),
                  lastMeasNum: d.Value(0)),
              const PlotsCompanion(nfiPlot: d.Value(2), code: d.Value("ON")),
              const PlotsCompanion(
                  nfiPlot: d.Value(3),
                  code: d.Value("AB"),
                  lastMeasNum: d.Value(3)),
            ]);
            b.insertAll(jurisdictions, [
              const JurisdictionsCompanion(
                  code: d.Value("ON"),
                  nameEn: d.Value("Ontario"),
                  nameFr: d.Value("Ontario_Fr")),
              const JurisdictionsCompanion(
                  code: d.Value("AB"),
                  nameEn: d.Value("Alberta"),
                  nameFr: d.Value("Alberta_Fr")),
            ]);
            b.insertAllOnConflictUpdate(treeGenus, trees);
          });
        },
        beforeOpen: (m) async {},
      );

  Future<List<dynamic>> loadJsonData(String path) async {
    final jsonFile = await rootBundle.loadString(path);
    final List<dynamic> jsonData = json.decode(jsonFile) as List<dynamic>;
    return jsonData;
    //return jsonData.map((entry) => TreeGenus.fromJson(entry)).toList();
  }

  Future<List<TreeGenusCompanion>> insertTreeGenuses() async {
    List<dynamic> jsonData =
        await loadJsonData('assets/db_reference_data/tree_list.json');
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
}
