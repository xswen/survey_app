// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_info_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$surveyFilterHash() => r'9a79a083a49c637690e520dcc1586fdc5e4f77b9';

/// See also [SurveyFilter].
@ProviderFor(SurveyFilter)
final surveyFilterProvider =
    AutoDisposeNotifierProvider<SurveyFilter, HashSet<SurveyStatus>>.internal(
  SurveyFilter.new,
  name: r'surveyFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$surveyFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SurveyFilter = AutoDisposeNotifier<HashSet<SurveyStatus>>;
String _$surveyCardListHash() => r'bbf5c9b181511915a6b46f7b67bb1be88e87f778';

/// See also [SurveyCardList].
@ProviderFor(SurveyCardList)
final surveyCardListProvider =
    AutoDisposeAsyncNotifierProvider<SurveyCardList, List<SurveyCard>>.internal(
  SurveyCardList.new,
  name: r'surveyCardListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$surveyCardListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SurveyCardList = AutoDisposeAsyncNotifier<List<SurveyCard>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter
