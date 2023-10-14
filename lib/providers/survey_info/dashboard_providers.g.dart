// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateSurveyHeaderListHash() =>
    r'3439befcc616d560bb99bdb951d21e2377551560';

/// See also [updateSurveyHeaderList].
@ProviderFor(updateSurveyHeaderList)
final updateSurveyHeaderListProvider =
    AutoDisposeFutureProvider<List<SurveyHeader>>.internal(
  updateSurveyHeaderList,
  name: r'updateSurveyHeaderListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateSurveyHeaderListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpdateSurveyHeaderListRef
    = AutoDisposeFutureProviderRef<List<SurveyHeader>>;
String _$dashboardSurveyFilterHash() =>
    r'bb023e35922ba24032017aa99f6c10476452280f';

/// See also [DashboardSurveyFilter].
@ProviderFor(DashboardSurveyFilter)
final dashboardSurveyFilterProvider = AutoDisposeNotifierProvider<
    DashboardSurveyFilter, HashSet<SurveyStatus>>.internal(
  DashboardSurveyFilter.new,
  name: r'dashboardSurveyFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardSurveyFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DashboardSurveyFilter = AutoDisposeNotifier<HashSet<SurveyStatus>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter
