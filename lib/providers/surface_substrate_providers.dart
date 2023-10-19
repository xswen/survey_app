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
Future<SurfaceSubstrateHeaderData> ssh(SshRef ref, int sshId) async => ref
    .read(databaseProvider)
    .surfaceSubstrateTablesDao
    .getSsHeaderFromId(sshId);

@riverpod
Future<bool> sshParentComplete(SshParentCompleteRef ref, int ssId) async =>
    (await ref
            .read(databaseProvider)
            .surfaceSubstrateTablesDao
            .getSsSummary(ssId))
        .complete;
