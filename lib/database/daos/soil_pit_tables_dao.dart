import 'package:drift/drift.dart';

import '../database.dart';
import '../database_creation_files/soil_pit_tables.dart';

part 'soil_pit_tables_dao.g.dart';

@DriftAccessor(tables: [
  SoilSiteInfo,
  SoilPitDepth,
  SoilPitFeature,
  SoilPitHorizonDescription,
])
class SoilPitTablesDao extends DatabaseAccessor<Database>
    with _$SoilPitTablesDaoMixin {
  SoilPitTablesDao(super.db);

  //For testing purposes only
  void clearTables() {
    delete(soilSiteInfo).go();
    delete(soilPitDepth).go();
    delete(soilPitFeature).go();
    delete(soilPitHorizonDescription).go();
  }

  Future<SoilSiteInfoData> getSoilSiteInfo(int surveyId) =>
      (select(soilSiteInfo)..where((tbl) => tbl.surveyId.equals(surveyId)))
          .getSingle();
}
