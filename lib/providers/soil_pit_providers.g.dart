// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soil_pit_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$soilSummaryDataHash() => r'76d63d729d7abe64b85f95a85d1d232515886894';

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

/// See also [soilSummaryData].
@ProviderFor(soilSummaryData)
const soilSummaryDataProvider = SoilSummaryDataFamily();

/// See also [soilSummaryData].
class SoilSummaryDataFamily extends Family<AsyncValue<SoilPitSummaryData>> {
  /// See also [soilSummaryData].
  const SoilSummaryDataFamily();

  /// See also [soilSummaryData].
  SoilSummaryDataProvider call(
    int soilSummaryId,
  ) {
    return SoilSummaryDataProvider(
      soilSummaryId,
    );
  }

  @override
  SoilSummaryDataProvider getProviderOverride(
    covariant SoilSummaryDataProvider provider,
  ) {
    return call(
      provider.soilSummaryId,
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
  String? get name => r'soilSummaryDataProvider';
}

/// See also [soilSummaryData].
class SoilSummaryDataProvider
    extends AutoDisposeFutureProvider<SoilPitSummaryData> {
  /// See also [soilSummaryData].
  SoilSummaryDataProvider(
    int soilSummaryId,
  ) : this._internal(
          (ref) => soilSummaryData(
            ref as SoilSummaryDataRef,
            soilSummaryId,
          ),
          from: soilSummaryDataProvider,
          name: r'soilSummaryDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$soilSummaryDataHash,
          dependencies: SoilSummaryDataFamily._dependencies,
          allTransitiveDependencies:
              SoilSummaryDataFamily._allTransitiveDependencies,
          soilSummaryId: soilSummaryId,
        );

  SoilSummaryDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.soilSummaryId,
  }) : super.internal();

  final int soilSummaryId;

  @override
  Override overrideWith(
    FutureOr<SoilPitSummaryData> Function(SoilSummaryDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SoilSummaryDataProvider._internal(
        (ref) => create(ref as SoilSummaryDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        soilSummaryId: soilSummaryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SoilPitSummaryData> createElement() {
    return _SoilSummaryDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SoilSummaryDataProvider &&
        other.soilSummaryId == soilSummaryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, soilSummaryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SoilSummaryDataRef on AutoDisposeFutureProviderRef<SoilPitSummaryData> {
  /// The parameter `soilSummaryId` of this provider.
  int get soilSummaryId;
}

class _SoilSummaryDataProviderElement
    extends AutoDisposeFutureProviderElement<SoilPitSummaryData>
    with SoilSummaryDataRef {
  _SoilSummaryDataProviderElement(super.provider);

  @override
  int get soilSummaryId => (origin as SoilSummaryDataProvider).soilSummaryId;
}

String _$soilDepthListHash() => r'853fcb832ea613e02a83c4ace9d040d5f9c60100';

/// See also [soilDepthList].
@ProviderFor(soilDepthList)
const soilDepthListProvider = SoilDepthListFamily();

/// See also [soilDepthList].
class SoilDepthListFamily extends Family<AsyncValue<List<SoilPitDepthData>>> {
  /// See also [soilDepthList].
  const SoilDepthListFamily();

  /// See also [soilDepthList].
  SoilDepthListProvider call(
    int soilSummaryId,
  ) {
    return SoilDepthListProvider(
      soilSummaryId,
    );
  }

  @override
  SoilDepthListProvider getProviderOverride(
    covariant SoilDepthListProvider provider,
  ) {
    return call(
      provider.soilSummaryId,
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
  String? get name => r'soilDepthListProvider';
}

/// See also [soilDepthList].
class SoilDepthListProvider
    extends AutoDisposeFutureProvider<List<SoilPitDepthData>> {
  /// See also [soilDepthList].
  SoilDepthListProvider(
    int soilSummaryId,
  ) : this._internal(
          (ref) => soilDepthList(
            ref as SoilDepthListRef,
            soilSummaryId,
          ),
          from: soilDepthListProvider,
          name: r'soilDepthListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$soilDepthListHash,
          dependencies: SoilDepthListFamily._dependencies,
          allTransitiveDependencies:
              SoilDepthListFamily._allTransitiveDependencies,
          soilSummaryId: soilSummaryId,
        );

  SoilDepthListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.soilSummaryId,
  }) : super.internal();

  final int soilSummaryId;

  @override
  Override overrideWith(
    FutureOr<List<SoilPitDepthData>> Function(SoilDepthListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SoilDepthListProvider._internal(
        (ref) => create(ref as SoilDepthListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        soilSummaryId: soilSummaryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SoilPitDepthData>> createElement() {
    return _SoilDepthListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SoilDepthListProvider &&
        other.soilSummaryId == soilSummaryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, soilSummaryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SoilDepthListRef on AutoDisposeFutureProviderRef<List<SoilPitDepthData>> {
  /// The parameter `soilSummaryId` of this provider.
  int get soilSummaryId;
}

class _SoilDepthListProviderElement
    extends AutoDisposeFutureProviderElement<List<SoilPitDepthData>>
    with SoilDepthListRef {
  _SoilDepthListProviderElement(super.provider);

  @override
  int get soilSummaryId => (origin as SoilDepthListProvider).soilSummaryId;
}

String _$soilFeatureListHash() => r'257d63549afed8cb89665e7de73a6f511d560b14';

/// See also [soilFeatureList].
@ProviderFor(soilFeatureList)
const soilFeatureListProvider = SoilFeatureListFamily();

/// See also [soilFeatureList].
class SoilFeatureListFamily
    extends Family<AsyncValue<List<SoilPitFeatureData>>> {
  /// See also [soilFeatureList].
  const SoilFeatureListFamily();

  /// See also [soilFeatureList].
  SoilFeatureListProvider call(
    int soilSummaryId,
  ) {
    return SoilFeatureListProvider(
      soilSummaryId,
    );
  }

  @override
  SoilFeatureListProvider getProviderOverride(
    covariant SoilFeatureListProvider provider,
  ) {
    return call(
      provider.soilSummaryId,
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
  String? get name => r'soilFeatureListProvider';
}

/// See also [soilFeatureList].
class SoilFeatureListProvider
    extends AutoDisposeFutureProvider<List<SoilPitFeatureData>> {
  /// See also [soilFeatureList].
  SoilFeatureListProvider(
    int soilSummaryId,
  ) : this._internal(
          (ref) => soilFeatureList(
            ref as SoilFeatureListRef,
            soilSummaryId,
          ),
          from: soilFeatureListProvider,
          name: r'soilFeatureListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$soilFeatureListHash,
          dependencies: SoilFeatureListFamily._dependencies,
          allTransitiveDependencies:
              SoilFeatureListFamily._allTransitiveDependencies,
          soilSummaryId: soilSummaryId,
        );

  SoilFeatureListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.soilSummaryId,
  }) : super.internal();

  final int soilSummaryId;

  @override
  Override overrideWith(
    FutureOr<List<SoilPitFeatureData>> Function(SoilFeatureListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SoilFeatureListProvider._internal(
        (ref) => create(ref as SoilFeatureListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        soilSummaryId: soilSummaryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SoilPitFeatureData>> createElement() {
    return _SoilFeatureListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SoilFeatureListProvider &&
        other.soilSummaryId == soilSummaryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, soilSummaryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SoilFeatureListRef
    on AutoDisposeFutureProviderRef<List<SoilPitFeatureData>> {
  /// The parameter `soilSummaryId` of this provider.
  int get soilSummaryId;
}

class _SoilFeatureListProviderElement
    extends AutoDisposeFutureProviderElement<List<SoilPitFeatureData>>
    with SoilFeatureListRef {
  _SoilFeatureListProviderElement(super.provider);

  @override
  int get soilSummaryId => (origin as SoilFeatureListProvider).soilSummaryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
