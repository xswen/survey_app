import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'soil_pit_providers.g.dart';

@riverpod
Future<SoilPitSummaryData> soilSummaryData(
        SoilSummaryDataRef ref, int soilSummaryId) =>
    ref.read(databaseProvider).soilPitTablesDao.getSummary(soilSummaryId);

@riverpod
Future<List<SoilPitDepthData>> soilDepthList(
        SoilDepthListRef ref, int soilSummaryId) =>
    ref.read(databaseProvider).soilPitTablesDao.getDepthList(soilSummaryId);

@riverpod
Future<List<SoilPitFeatureData>> soilFeatureList(
        SoilFeatureListRef ref, int soilSummaryId) =>
    ref.read(databaseProvider).soilPitTablesDao.getFeatureList(soilSummaryId);
