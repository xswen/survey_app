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
Future<bool> wdhParentComplete(WdhParentCompleteRef ref, int wdId) async =>
    (await ref.read(databaseProvider).woodyDebrisTablesDao.getWdSummary(wdId))
        .complete;

@riverpod
Future<WoodyDebrisHeaderData> wdh(WdhRef ref, int wdhId) async =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdHeader(wdhId);
