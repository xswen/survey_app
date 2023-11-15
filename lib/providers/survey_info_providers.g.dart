// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_info_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateSurveyCardHash() => r'd693ec2eeb5b691b52c870ad08c2fd9ba886d7ad';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [updateSurveyCard].
@ProviderFor(updateSurveyCard)
const updateSurveyCardProvider = UpdateSurveyCardFamily();

/// See also [updateSurveyCard].
class UpdateSurveyCardFamily extends Family<AsyncValue<List<SurveyCard>>> {
  /// See also [updateSurveyCard].
  const UpdateSurveyCardFamily();

  /// See also [updateSurveyCard].
  UpdateSurveyCardProvider call(
    int surveyId,
  ) {
    return UpdateSurveyCardProvider(
      surveyId,
    );
  }

  @override
  UpdateSurveyCardProvider getProviderOverride(
    covariant UpdateSurveyCardProvider provider,
  ) {
    return call(
      provider.surveyId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateSurveyCardProvider';
}

/// See also [updateSurveyCard].
class UpdateSurveyCardProvider
    extends AutoDisposeFutureProvider<List<SurveyCard>> {
  /// See also [updateSurveyCard].
  UpdateSurveyCardProvider(
    int surveyId,
  ) : this._internal(
          (ref) => updateSurveyCard(
            ref as UpdateSurveyCardRef,
            surveyId,
          ),
          from: updateSurveyCardProvider,
          name: r'updateSurveyCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateSurveyCardHash,
          dependencies: UpdateSurveyCardFamily._dependencies,
          allTransitiveDependencies:
              UpdateSurveyCardFamily._allTransitiveDependencies,
          surveyId: surveyId,
        );

  UpdateSurveyCardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surveyId,
  }) : super.internal();

  final int surveyId;

  @override
  Override overrideWith(
    FutureOr<List<SurveyCard>> Function(UpdateSurveyCardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateSurveyCardProvider._internal(
        (ref) => create(ref as UpdateSurveyCardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surveyId: surveyId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SurveyCard>> createElement() {
    return _UpdateSurveyCardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateSurveyCardProvider && other.surveyId == surveyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surveyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateSurveyCardRef on AutoDisposeFutureProviderRef<List<SurveyCard>> {
  /// The parameter `surveyId` of this provider.
  int get surveyId;
}

class _UpdateSurveyCardProviderElement
    extends AutoDisposeFutureProviderElement<List<SurveyCard>>
    with UpdateSurveyCardRef {
  _UpdateSurveyCardProviderElement(super.provider);

  @override
  int get surveyId => (origin as UpdateSurveyCardProvider).surveyId;
}

String _$updateSurveyHash() => r'78a6395a44cc31011d39ff6c8726b6d06446d6ab';

/// See also [updateSurvey].
@ProviderFor(updateSurvey)
const updateSurveyProvider = UpdateSurveyFamily();

/// See also [updateSurvey].
class UpdateSurveyFamily extends Family<AsyncValue<SurveyHeader>> {
  /// See also [updateSurvey].
  const UpdateSurveyFamily();

  /// See also [updateSurvey].
  UpdateSurveyProvider call(
    int surveyId,
  ) {
    return UpdateSurveyProvider(
      surveyId,
    );
  }

  @override
  UpdateSurveyProvider getProviderOverride(
    covariant UpdateSurveyProvider provider,
  ) {
    return call(
      provider.surveyId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateSurveyProvider';
}

/// See also [updateSurvey].
class UpdateSurveyProvider extends AutoDisposeFutureProvider<SurveyHeader> {
  /// See also [updateSurvey].
  UpdateSurveyProvider(
    int surveyId,
  ) : this._internal(
          (ref) => updateSurvey(
            ref as UpdateSurveyRef,
            surveyId,
          ),
          from: updateSurveyProvider,
          name: r'updateSurveyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateSurveyHash,
          dependencies: UpdateSurveyFamily._dependencies,
          allTransitiveDependencies:
              UpdateSurveyFamily._allTransitiveDependencies,
          surveyId: surveyId,
        );

  UpdateSurveyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surveyId,
  }) : super.internal();

  final int surveyId;

  @override
  Override overrideWith(
    FutureOr<SurveyHeader> Function(UpdateSurveyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateSurveyProvider._internal(
        (ref) => create(ref as UpdateSurveyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surveyId: surveyId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SurveyHeader> createElement() {
    return _UpdateSurveyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateSurveyProvider && other.surveyId == surveyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surveyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateSurveyRef on AutoDisposeFutureProviderRef<SurveyHeader> {
  /// The parameter `surveyId` of this provider.
  int get surveyId;
}

class _UpdateSurveyProviderElement
    extends AutoDisposeFutureProviderElement<SurveyHeader>
    with UpdateSurveyRef {
  _UpdateSurveyProviderElement(super.provider);

  @override
  int get surveyId => (origin as UpdateSurveyProvider).surveyId;
}

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
String _$surveyCardFilterHash() => r'2b3b89d50fc6d4769b8e6f5a71d3385dc5409cab';

/// See also [SurveyCardFilter].
@ProviderFor(SurveyCardFilter)
final surveyCardFilterProvider = AutoDisposeNotifierProvider<SurveyCardFilter,
    HashSet<SurveyStatus>>.internal(
  SurveyCardFilter.new,
  name: r'surveyCardFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$surveyCardFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SurveyCardFilter = AutoDisposeNotifier<HashSet<SurveyStatus>>;
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
