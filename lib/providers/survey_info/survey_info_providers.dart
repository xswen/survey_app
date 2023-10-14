import 'dart:collection';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../enums/enums.dart';
import '../../wrappers/survey_card.dart';
import '../providers.dart';

part 'survey_info_providers.g.dart';

@riverpod
class SurveyFilter extends _$SurveyFilter {
  @override
  HashSet<SurveyStatus> build() {
    return HashSet<SurveyStatus>();
  }

  void selectedAll(bool selected) => selected
      ? state = HashSet<SurveyStatus>()
      : state = HashSet<SurveyStatus>.of({
          SurveyStatus.complete,
          SurveyStatus.inProgress,
        });

  void selectedNotStarted(bool selected) => selected
      ? state = HashSet<SurveyStatus>.of({
          ...state,
          SurveyStatus.notStarted,
        })
      : state = HashSet<SurveyStatus>.of({
          for (final status in state)
            if (status != SurveyStatus.notStarted) status
        });

  void selectedInProgress(bool selected) => selected
      ? state = HashSet<SurveyStatus>.of({
          ...state,
          SurveyStatus.inProgress,
        })
      : state = HashSet<SurveyStatus>.of({
          for (final status in state)
            if (status != SurveyStatus.inProgress) status
        });

  void selectedComplete(bool selected) => selected
      ? state = HashSet<SurveyStatus>.of({
          ...state,
          SurveyStatus.complete,
        })
      : state = HashSet<SurveyStatus>.of({
          for (final status in state)
            if (status != SurveyStatus.complete) status
        });
}

@riverpod
class SurveyCardList extends _$SurveyCardList {
  @override
  Future<List<SurveyCard>> build() {
    return Future<List<SurveyCard>>.value([]);
  }

  Future<void> updateList(int surveyId) async {
    final filter = ref.watch(surveyFilterProvider);
    state = const AsyncValue.loading();
    state = AsyncValue.data(
        await ref.read(databaseProvider).getCards(surveyId, filters: filter));
  }
}
