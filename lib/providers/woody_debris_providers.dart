import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import 'providers.dart';

part 'woody_debris_providers.g.dart';

@riverpod
Future<WoodyDebrisSummaryData> wdData(WdDataRef ref, int surveyId) => ref
    .read(databaseProvider)
    .woodyDebrisTablesDao
    .getWdSummaryFromSurveyId(surveyId);

@riverpod
Future<List<WoodyDebrisHeaderData>> wdTransList(WdTransListRef ref, int wdId) =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdHeadersFromWdSId(wdId);

@riverpod
Future<WoodyDebrisHeaderData> wdh(WdhRef ref, int wdhId) async =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdHeader(wdhId);

@riverpod
Future<bool> wdhParentComplete(WdhParentCompleteRef ref, int wdId) async =>
    (await ref.read(databaseProvider).woodyDebrisTablesDao.getWdSummary(wdId))
        .complete!;

@riverpod
Future<bool> wdhSmallParentComplete(
        WdhSmallParentCompleteRef ref, int wdhId) async =>
    (await ref.read(databaseProvider).woodyDebrisTablesDao.getWdHeader(wdhId))
        .complete;

@riverpod
Future<List<WoodyDebrisOddData>> wdPieceOdd(WdPieceOddRef ref, int wdhId) =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdOddList(wdhId);

@riverpod
Future<List<WoodyDebrisRoundData>> wdPieceRound(
        WdPieceRoundRef ref, int wdhId) =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdRoundList(wdhId);

@riverpod
Future<WoodyDebrisSmallData?> wdSmall(WdSmallRef ref, int wdhId) =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdSmall(wdhId);
