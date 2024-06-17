import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'ground_plot_providers.g.dart';

@riverpod
Future<GpSummaryData> gpSummaryData(GpSummaryDataRef ref, int gpSummaryId) =>
    ref.read(databaseProvider).siteInfoTablesDao.getSummary(gpSummaryId);

// @riverpod
// Future<List<SoilPitFeatureData>> soilFeatureList(
//     SoilFeatureListRef ref, int soilSummaryId) =>
//     ref.read(databaseProvider).soilPitTablesDao.getFeatureList(soilSummaryId);
//
// @riverpod
// Future<List<SoilPitHorizonDescriptionData>> soilHorizonList(
//     SoilHorizonListRef ref, int soilSummaryId) =>
//     ref.read(databaseProvider).soilPitTablesDao.getHorizonList(soilSummaryId);
