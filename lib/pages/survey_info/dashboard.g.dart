// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateSurveyHeaderListHash() =>
    r'e07ff95a970f893fb5afd029d9c9a809ab931832';

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
String _$filterHash() => r'a26a2db2ff062e626ee0e0039aa034242b137302';

/// See also [Filter].
@ProviderFor(Filter)
final filterProvider =
    AutoDisposeNotifierProvider<Filter, HashSet<SurveyStatus>>.internal(
  Filter.new,
  name: r'filterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$filterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Filter = AutoDisposeNotifier<HashSet<SurveyStatus>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
