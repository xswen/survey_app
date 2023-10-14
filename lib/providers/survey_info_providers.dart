import 'dart:collection';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import '../enums/enums.dart';
import '../wrappers/survey_card.dart';
import 'providers.dart';

part 'survey_info_providers.g.dart';

@riverpod
class SurveyCardFilter extends _$SurveyCardFilter {
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
class DashboardSurveyFilter extends _$DashboardSurveyFilter {
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
Future<List<SurveyCard>> updateSurveyCard(
    UpdateSurveyCardRef ref, int surveyId) {
  final filter = ref.watch(surveyCardFilterProvider);
  return ref.read(databaseProvider).getCards(surveyId, filters: filter);
}

@riverpod
Future<SurveyHeader> updateSurvey(UpdateSurveyRef ref, int surveyId) =>
    ref.watch(databaseProvider).surveyInfoTablesDao.getSurvey(surveyId);

@riverpod
Future<List<SurveyHeader>> updateSurveyHeaderList(
    UpdateSurveyHeaderListRef ref) {
  final filter = ref.watch(dashboardSurveyFilterProvider);
  return ref
      .read(databaseProvider)
      .surveyInfoTablesDao
      .getSurveysFiltered(filter);
}
