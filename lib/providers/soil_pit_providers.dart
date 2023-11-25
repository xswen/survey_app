import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'soil_pit_providers.g.dart';

@riverpod
Future<SoilPitSummaryData> soilSummaryData(
        SoilSummaryDataRef ref, int soilSummaryId) =>
    ref.read(databaseProvider).soilPitTablesDao.getSummary(soilSummaryId);

@riverpod
Future<List<SoilPitFeatureData>> soilFeatureList(
        SoilFeatureListRef ref, int soilSummaryId) =>
    ref.read(databaseProvider).soilPitTablesDao.getFeatureList(soilSummaryId);

@riverpod
Future<List<SoilPitHorizonDescriptionData>> soilHorizonList(
        SoilHorizonListRef ref, int soilSummaryId) =>
    ref.read(databaseProvider).soilPitTablesDao.getHorizonList(soilSummaryId);
