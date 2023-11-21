import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'soil_pit_providers.g.dart';

@riverpod
Future<SoilPitSummaryData> soilSiteInfoData(
        SoilSiteInfoDataRef ref, int surveyId) =>
    ref.read(databaseProvider).soilPitTablesDao.getSoilPitSummary(surveyId);
