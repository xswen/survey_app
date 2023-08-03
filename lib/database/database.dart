import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

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
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) async {
        await m.createAll();
        final jsonData = await loadJsonData();
        await insertTreeGenuses(jsonData);
      }, beforeOpen: (m) async {
        referenceTablesDao.clearTables();
        woodyDebrisTablesDao.clearTables();
        surfaceSubstrateTablesDao.clearTables();
        ecologicalPlotTablesDao.clearTables();

        await batch((b) {
          b.insertAll(plots, [
            const PlotsCompanion(
                nfiPlot: Value(1), code: Value("ON"), lastMeasNum: Value(0)),
            const PlotsCompanion(nfiPlot: Value(2), code: Value("ON")),
            const PlotsCompanion(
                nfiPlot: Value(3), code: Value("AB"), lastMeasNum: Value(3)),
          ]);
          b.insertAll(jurisdictions, [
            const JurisdictionsCompanion(
                code: Value("ON"),
                nameEn: Value("Ontario"),
                nameFr: Value("Ontario_Fr")),
            const JurisdictionsCompanion(
                code: Value("AB"),
                nameEn: Value("Alberta"),
                nameFr: Value("Alberta_Fr")),
          ]);
        });
      });

  Future<List<TreeGenus>> loadJsonData() async {
    final jsonFile =
        await rootBundle.loadString('assets/db_reference_data/tree_list.json');
    final jsonData = json.decode(jsonFile) as List<dynamic>;
    //return jsonData.map((entry) => TreeGenus.fromJson(entry)).toList();
    return [];
  }

  Future<void> insertTreeGenuses(List<TreeGenus> treeGenuses) async {
    // await into(treeGenus)
    //     .insertAll(treeGenuses, mode: InsertMode.insertOrReplace);
  }
}
