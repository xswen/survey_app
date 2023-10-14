import 'dart:collection';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../database/database.dart';
import '../../enums/enums.dart';
import '../../wrappers/survey_card.dart';
import '../providers.dart';

part 'dashboard_providers.g.dart';

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
Future<List<SurveyHeader>> updateSurveyHeaderList(
    UpdateSurveyHeaderListRef ref) {
  final filter = ref.watch(dashboardSurveyFilterProvider);
  return ref
      .read(databaseProvider)
      .surveyInfoTablesDao
      .getSurveysFiltered(filter);
}
