import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'surface_substrate_providers.g.dart';

@riverpod
Future<SurfaceSubstrateSummaryData> ssData(SsDataRef ref, int surveyId) =>
    ref.read(databaseProvider).surfaceSubstrateTablesDao.getSsSummary(surveyId);

@riverpod
Future<List<SurfaceSubstrateHeaderData>> ssTransList(
        SsTransListRef ref, int ssId) =>
    ref
        .read(databaseProvider)
        .surfaceSubstrateTablesDao
        .getSSHeadersFromSsSId(ssId);

@riverpod
Future<List<SurfaceSubstrateTallyData>> ssTallyDataList(
        SsTallyDataListRef ref, sshId) =>
    ref.read(databaseProvider).surfaceSubstrateTablesDao.getSsTallyList(sshId);
