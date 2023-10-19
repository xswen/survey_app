// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surface_substrate_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ssDataHash() => r'6368174e1e261e79db907003c2e889839459c12b';

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

/// See also [ssData].
@ProviderFor(ssData)
const ssDataProvider = SsDataFamily();

/// See also [ssData].
class SsDataFamily extends Family<AsyncValue<SurfaceSubstrateSummaryData>> {
  /// See also [ssData].
  const SsDataFamily();

  /// See also [ssData].
  SsDataProvider call(
    int surveyId,
  ) {
    return SsDataProvider(
      surveyId,
    );
  }

  @visibleForOverriding
  @override
  SsDataProvider getProviderOverride(
    covariant SsDataProvider provider,
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
  String? get name => r'ssDataProvider';
}

/// See also [ssData].
class SsDataProvider
    extends AutoDisposeFutureProvider<SurfaceSubstrateSummaryData> {
  /// See also [ssData].
  SsDataProvider(
    int surveyId,
  ) : this._internal(
          (ref) => ssData(
            ref as SsDataRef,
            surveyId,
          ),
          from: ssDataProvider,
          name: r'ssDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ssDataHash,
          dependencies: SsDataFamily._dependencies,
          allTransitiveDependencies: SsDataFamily._allTransitiveDependencies,
          surveyId: surveyId,
        );

  SsDataProvider._internal(
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
    FutureOr<SurfaceSubstrateSummaryData> Function(SsDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SsDataProvider._internal(
        (ref) => create(ref as SsDataRef),
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
  AutoDisposeFutureProviderElement<SurfaceSubstrateSummaryData>
      createElement() {
    return _SsDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SsDataProvider && other.surveyId == surveyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surveyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SsDataRef on AutoDisposeFutureProviderRef<SurfaceSubstrateSummaryData> {
  /// The parameter `surveyId` of this provider.
  int get surveyId;
}

class _SsDataProviderElement
    extends AutoDisposeFutureProviderElement<SurfaceSubstrateSummaryData>
    with SsDataRef {
  _SsDataProviderElement(super.provider);

  @override
  int get surveyId => (origin as SsDataProvider).surveyId;
}

String _$ssTransListHash() => r'9ece9a1cf4c17c3b59122aff2d344a613416f7f5';

/// See also [ssTransList].
@ProviderFor(ssTransList)
const ssTransListProvider = SsTransListFamily();

/// See also [ssTransList].
class SsTransListFamily
    extends Family<AsyncValue<List<SurfaceSubstrateHeaderData>>> {
  /// See also [ssTransList].
  const SsTransListFamily();

  /// See also [ssTransList].
  SsTransListProvider call(
    int ssId,
  ) {
    return SsTransListProvider(
      ssId,
    );
  }

  @visibleForOverriding
  @override
  SsTransListProvider getProviderOverride(
    covariant SsTransListProvider provider,
  ) {
    return call(
      provider.ssId,
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
  String? get name => r'ssTransListProvider';
}

/// See also [ssTransList].
class SsTransListProvider
    extends AutoDisposeFutureProvider<List<SurfaceSubstrateHeaderData>> {
  /// See also [ssTransList].
  SsTransListProvider(
    int ssId,
  ) : this._internal(
          (ref) => ssTransList(
            ref as SsTransListRef,
            ssId,
          ),
          from: ssTransListProvider,
          name: r'ssTransListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ssTransListHash,
          dependencies: SsTransListFamily._dependencies,
          allTransitiveDependencies:
              SsTransListFamily._allTransitiveDependencies,
          ssId: ssId,
        );

  SsTransListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ssId,
  }) : super.internal();

  final int ssId;

  @override
  Override overrideWith(
    FutureOr<List<SurfaceSubstrateHeaderData>> Function(SsTransListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SsTransListProvider._internal(
        (ref) => create(ref as SsTransListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ssId: ssId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SurfaceSubstrateHeaderData>>
      createElement() {
    return _SsTransListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SsTransListProvider && other.ssId == ssId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ssId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SsTransListRef
    on AutoDisposeFutureProviderRef<List<SurfaceSubstrateHeaderData>> {
  /// The parameter `ssId` of this provider.
  int get ssId;
}

class _SsTransListProviderElement
    extends AutoDisposeFutureProviderElement<List<SurfaceSubstrateHeaderData>>
    with SsTransListRef {
  _SsTransListProviderElement(super.provider);

  @override
  int get ssId => (origin as SsTransListProvider).ssId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter
