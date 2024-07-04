import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'ground_plot_providers.g.dart';

@riverpod
Future<GpSummaryData> gpSummaryData(GpSummaryDataRef ref, int gpSummaryId) =>
    ref.read(databaseProvider).siteInfoTablesDao.getSummary(gpSummaryId);

@riverpod
Future<List<GpDisturbanceData>> gpDistDataList(
        GpDistDataListRef ref, int summaryId) =>
    ref
        .read(databaseProvider)
        .siteInfoTablesDao
        .getGpDisturbanceList(summaryId);

@riverpod
Future<List<GpOriginData>> gpOriginList(GpOriginListRef ref, int summaryId) =>
    ref.read(databaseProvider).siteInfoTablesDao.getGpOriginList(summaryId);

@riverpod
Future<List<GpTreatmentData>> gpTreatmentList(
        GpTreatmentListRef ref, int summaryId) =>
    ref.read(databaseProvider).siteInfoTablesDao.getGpTreatmentList(summaryId);
