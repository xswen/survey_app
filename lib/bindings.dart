import 'dart:io';

import 'package:drift/drift.dart' as d;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'database/database.dart';

class DbBinding implements Bindings {
  @override
  void dependencies() {
    final db = LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });

//    Get.lazyPut<Database>(() => Database(db));
    // Get.lazyPut<Database>(() => Database(NativeDatabase.memory()));
    Get.find<Database>().referenceTablesDao.clearTables();
    Get.find<Database>().woodyDebrisTablesDao.clearTables();
    Get.find<Database>().surfaceSubstrateTablesDao.clearTables();
    Get.find<Database>().ecologicalPlotTablesDao.clearTables();

    _initPlots();
    _initJurisdictions();
    _initTreeGenus();
    _initSurveys();
    _initWd();
  }

  void _initPlots() {
    List<PlotsCompanion> plots = [
      const PlotsCompanion(
          nfiPlot: d.Value(1), code: d.Value("ON"), lastMeasNum: d.Value(0)),
      const PlotsCompanion(nfiPlot: d.Value(2), code: d.Value("ON")),
      const PlotsCompanion(
          nfiPlot: d.Value(3), code: d.Value("AB"), lastMeasNum: d.Value(3)),
    ];

    for (int i = 0; i < plots.length; i++) {
      Get.find<Database>().referenceTablesDao.addPlot(plots[i]);
    }
  }

  void _initJurisdictions() {
    List<JurisdictionsCompanion> jurisdictions = [
      const JurisdictionsCompanion(
          code: d.Value("ON"),
          nameEn: d.Value("Ontario"),
          nameFr: d.Value("Ontario_Fr")),
      const JurisdictionsCompanion(
          code: d.Value("AB"),
          nameEn: d.Value("Alberta"),
          nameFr: d.Value("Alberta_Fr")),
    ];

    for (int i = 0; i < jurisdictions.length; i++) {
      Get.find<Database>().referenceTablesDao.addJurisdiction(jurisdictions[i]);
    }
  }

  void _initTreeGenus() {
    List<TreeGenusCompanion> trees = [
      const TreeGenusCompanion(
        genusCode: d.Value("UNKN"),
        speciesCode: d.Value("UNK"),
        genusLatinName: d.Value("Unknown"),
        speciesLatinName: d.Value("Unknown"),
        commonNameEn: d.Value("Unknown"),
        commonNameFr: d.Value("Unknown_fr"),
      ),
      const TreeGenusCompanion(
        genusCode: d.Value("ABIE"),
        speciesCode: d.Value("UNK"),
        genusLatinName: d.Value("Abies"),
        speciesLatinName: d.Value("Unknown"),
        commonNameEn: d.Value("Abies"),
        commonNameFr: d.Value("Abies_fr"),
      ),
      const TreeGenusCompanion(
        genusCode: d.Value("ABIE"),
        speciesCode: d.Value("AMA"),
        genusLatinName: d.Value("Abies"),
        speciesLatinName: d.Value("Amabilis"),
        commonNameEn: d.Value("AbieAmab"),
        commonNameFr: d.Value("AbieAmab_fr"),
      ),
      const TreeGenusCompanion(
        genusCode: d.Value("ABIE"),
        speciesCode: d.Value("BAL"),
        genusLatinName: d.Value("Abies"),
        speciesLatinName: d.Value("Balsamea"),
        commonNameEn: d.Value("AbieBals"),
        commonNameFr: d.Value("AbieBals_fr"),
      ),
      const TreeGenusCompanion(
        genusCode: d.Value("ACER"),
        speciesCode: d.Value("UNK"),
        genusLatinName: d.Value("Acer"),
        speciesLatinName: d.Value("Unknown"),
        commonNameEn: d.Value("Acer"),
        commonNameFr: d.Value("Acer_fr"),
      ),
      const TreeGenusCompanion(
        genusCode: d.Value("ACER"),
        speciesCode: d.Value("NIG"),
        genusLatinName: d.Value("Acer"),
        speciesLatinName: d.Value("Nigrum"),
        commonNameEn: d.Value("AcerNigrum"),
        commonNameFr: d.Value("AcerNigrum_fr"),
      ),
    ];

    for (int i = 0; i < trees.length; i++) {
      Get.find<Database>().referenceTablesDao.addTreeGenus(trees[i]);
    }
  }

  void _initSurveys() {
    List<SurveyHeadersCompanion> surveys = [
      SurveyHeadersCompanion(
          id: const d.Value(1),
          nfiPlot: const d.Value(1),
          measDate: d.Value(DateTime.now()),
          measNum: const d.Value(1),
          province: const d.Value("ON")),
      SurveyHeadersCompanion(
          nfiPlot: const d.Value(2),
          measDate: d.Value(DateTime.now()),
          measNum: const d.Value(0),
          province: const d.Value("ON")),
    ];

    for (int i = 0; i < surveys.length; i++) {
      Get.find<Database>().surveyInfoTablesDao.addSurvey(surveys[i]);
    }
  }

  void _initWd() {
    Get.find<Database>()
        .woodyDebrisTablesDao
        .addWdSummary(WoodyDebrisSummaryCompanion(
          id: const d.Value(1),
          surveyId: const d.Value(1),
          measDate: d.Value(DateTime.now()),
          numTransects: const d.Value(1),
        ));

    Get.find<Database>().woodyDebrisTablesDao.addWdHeader(
        const WoodyDebrisHeaderCompanion(
            id: d.Value(1), wdId: d.Value(1), transNum: d.Value(1)));

    Get.find<Database>()
        .woodyDebrisTablesDao
        .addWdPieceOddAccu(const WoodyDebrisOddCompanion(
          wdHeaderId: d.Value(1),
          pieceNum: d.Value(1),
          accumOdd: d.Value("AC"),
          genus: d.Value("UNKN"),
          species: d.Value("UNK"),
          horLength: d.Value(55.5),
          verDepth: d.Value(55.5),
          decayClass: d.Value(-1),
        ));
    Get.find<Database>()
        .woodyDebrisTablesDao
        .addWdPieceOddAccu(const WoodyDebrisOddCompanion(
          wdHeaderId: d.Value(1),
          pieceNum: d.Value(2),
          accumOdd: d.Value("AC"),
          genus: d.Value("ACER"),
          species: d.Value("UNK"),
          horLength: d.Value(55.5),
          verDepth: d.Value(55.5),
          decayClass: d.Value(-1),
        ));
    Get.find<Database>()
        .woodyDebrisTablesDao
        .addWdPieceRound(const WoodyDebrisRoundCompanion(
          wdHeaderId: d.Value(1),
          pieceNum: d.Value(3),
          genus: d.Value("ACER"),
          species: d.Value("UNK"),
          diameter: d.Value(55.5),
          tiltAngle: d.Value(44),
          decayClass: d.Value(-1),
        ));
  }
}
