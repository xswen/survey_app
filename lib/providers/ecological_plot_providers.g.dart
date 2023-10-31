// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecological_plot_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ecpDataHash() => r'45026e32b930f885c42a7d9c2ed9f137b1247eda';

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

/// See also [ecpData].
@ProviderFor(ecpData)
const ecpDataProvider = EcpDataFamily();

/// See also [ecpData].
class EcpDataFamily extends Family<AsyncValue<EcpSummaryData>> {
  /// See also [ecpData].
  const EcpDataFamily();

  /// See also [ecpData].
  EcpDataProvider call(
    int ecpId,
  ) {
    return EcpDataProvider(
      ecpId,
    );
  }

  @visibleForOverriding
  @override
  EcpDataProvider getProviderOverride(
    covariant EcpDataProvider provider,
  ) {
    return call(
      provider.ecpId,
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
  String? get name => r'ecpDataProvider';
}

/// See also [ecpData].
class EcpDataProvider extends AutoDisposeFutureProvider<EcpSummaryData> {
  /// See also [ecpData].
  EcpDataProvider(
    int ecpId,
  ) : this._internal(
          (ref) => ecpData(
            ref as EcpDataRef,
            ecpId,
          ),
          from: ecpDataProvider,
          name: r'ecpDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ecpDataHash,
          dependencies: EcpDataFamily._dependencies,
          allTransitiveDependencies: EcpDataFamily._allTransitiveDependencies,
          ecpId: ecpId,
        );

  EcpDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ecpId,
  }) : super.internal();

  final int ecpId;

  @override
  Override overrideWith(
    FutureOr<EcpSummaryData> Function(EcpDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EcpDataProvider._internal(
        (ref) => create(ref as EcpDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ecpId: ecpId,
      ),
    );
  }

  @override
  (int,) get argument {
    return (ecpId,);
  }

  @override
  AutoDisposeFutureProviderElement<EcpSummaryData> createElement() {
    return _EcpDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EcpDataProvider && other.ecpId == ecpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ecpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EcpDataRef on AutoDisposeFutureProviderRef<EcpSummaryData> {
  /// The parameter `ecpId` of this provider.
  int get ecpId;
}

class _EcpDataProviderElement
    extends AutoDisposeFutureProviderElement<EcpSummaryData> with EcpDataRef {
  _EcpDataProviderElement(super.provider);

  @override
  int get ecpId => (origin as EcpDataProvider).ecpId;
}

String _$ecpTransListHash() => r'68fc3191577b5b14ae823f6a6a61d0aa58c2af9f';

/// See also [ecpTransList].
@ProviderFor(ecpTransList)
const ecpTransListProvider = EcpTransListFamily();

/// See also [ecpTransList].
class EcpTransListFamily extends Family<AsyncValue<List<EcpHeaderData>>> {
  /// See also [ecpTransList].
  const EcpTransListFamily();

  /// See also [ecpTransList].
  EcpTransListProvider call(
    int ecpId,
  ) {
    return EcpTransListProvider(
      ecpId,
    );
  }

  @visibleForOverriding
  @override
  EcpTransListProvider getProviderOverride(
    covariant EcpTransListProvider provider,
  ) {
    return call(
      provider.ecpId,
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
  String? get name => r'ecpTransListProvider';
}

/// See also [ecpTransList].
class EcpTransListProvider
    extends AutoDisposeFutureProvider<List<EcpHeaderData>> {
  /// See also [ecpTransList].
  EcpTransListProvider(
    int ecpId,
  ) : this._internal(
          (ref) => ecpTransList(
            ref as EcpTransListRef,
            ecpId,
          ),
          from: ecpTransListProvider,
          name: r'ecpTransListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ecpTransListHash,
          dependencies: EcpTransListFamily._dependencies,
          allTransitiveDependencies:
              EcpTransListFamily._allTransitiveDependencies,
          ecpId: ecpId,
        );

  EcpTransListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ecpId,
  }) : super.internal();

  final int ecpId;

  @override
  Override overrideWith(
    FutureOr<List<EcpHeaderData>> Function(EcpTransListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EcpTransListProvider._internal(
        (ref) => create(ref as EcpTransListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ecpId: ecpId,
      ),
    );
  }

  @override
  (int,) get argument {
    return (ecpId,);
  }

  @override
  AutoDisposeFutureProviderElement<List<EcpHeaderData>> createElement() {
    return _EcpTransListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EcpTransListProvider && other.ecpId == ecpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ecpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EcpTransListRef on AutoDisposeFutureProviderRef<List<EcpHeaderData>> {
  /// The parameter `ecpId` of this provider.
  int get ecpId;
}

class _EcpTransListProviderElement
    extends AutoDisposeFutureProviderElement<List<EcpHeaderData>>
    with EcpTransListRef {
  _EcpTransListProviderElement(super.provider);

  @override
  int get ecpId => (origin as EcpTransListProvider).ecpId;
}

String _$ecpSpeciesListHash() => r'7bf51329dead009079089508f4a1e5f340761432';

/// See also [ecpSpeciesList].
@ProviderFor(ecpSpeciesList)
const ecpSpeciesListProvider = EcpSpeciesListFamily();

/// See also [ecpSpeciesList].
class EcpSpeciesListFamily extends Family<AsyncValue<List<EcpSpeciesData>>> {
  /// See also [ecpSpeciesList].
  const EcpSpeciesListFamily();

  /// See also [ecpSpeciesList].
  EcpSpeciesListProvider call(
    int ecpHId,
  ) {
    return EcpSpeciesListProvider(
      ecpHId,
    );
  }

  @visibleForOverriding
  @override
  EcpSpeciesListProvider getProviderOverride(
    covariant EcpSpeciesListProvider provider,
  ) {
    return call(
      provider.ecpHId,
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
  String? get name => r'ecpSpeciesListProvider';
}

/// See also [ecpSpeciesList].
class EcpSpeciesListProvider
    extends AutoDisposeFutureProvider<List<EcpSpeciesData>> {
  /// See also [ecpSpeciesList].
  EcpSpeciesListProvider(
    int ecpHId,
  ) : this._internal(
          (ref) => ecpSpeciesList(
            ref as EcpSpeciesListRef,
            ecpHId,
          ),
          from: ecpSpeciesListProvider,
          name: r'ecpSpeciesListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ecpSpeciesListHash,
          dependencies: EcpSpeciesListFamily._dependencies,
          allTransitiveDependencies:
              EcpSpeciesListFamily._allTransitiveDependencies,
          ecpHId: ecpHId,
        );

  EcpSpeciesListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ecpHId,
  }) : super.internal();

  final int ecpHId;

  @override
  Override overrideWith(
    FutureOr<List<EcpSpeciesData>> Function(EcpSpeciesListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EcpSpeciesListProvider._internal(
        (ref) => create(ref as EcpSpeciesListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ecpHId: ecpHId,
      ),
    );
  }

  @override
  (int,) get argument {
    return (ecpHId,);
  }

  @override
  AutoDisposeFutureProviderElement<List<EcpSpeciesData>> createElement() {
    return _EcpSpeciesListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EcpSpeciesListProvider && other.ecpHId == ecpHId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ecpHId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EcpSpeciesListRef on AutoDisposeFutureProviderRef<List<EcpSpeciesData>> {
  /// The parameter `ecpHId` of this provider.
  int get ecpHId;
}

class _EcpSpeciesListProviderElement
    extends AutoDisposeFutureProviderElement<List<EcpSpeciesData>>
    with EcpSpeciesListRef {
  _EcpSpeciesListProviderElement(super.provider);

  @override
  int get ecpHId => (origin as EcpSpeciesListProvider).ecpHId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
