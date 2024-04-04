// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'small_tree_plot_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stpSpeciesListHash() => r'025b6c4bd4da00ad2e196d830eb7cd9d12efcaf2';

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

/// See also [stpSpeciesList].
@ProviderFor(stpSpeciesList)
const stpSpeciesListProvider = StpSpeciesListFamily();

/// See also [stpSpeciesList].
class StpSpeciesListFamily extends Family<AsyncValue<List<StpSpeciesData>>> {
  /// See also [stpSpeciesList].
  const StpSpeciesListFamily();

  /// See also [stpSpeciesList].
  StpSpeciesListProvider call(
    int stpId,
  ) {
    return StpSpeciesListProvider(
      stpId,
    );
  }

  @override
  StpSpeciesListProvider getProviderOverride(
    covariant StpSpeciesListProvider provider,
  ) {
    return call(
      provider.stpId,
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
  String? get name => r'stpSpeciesListProvider';
}

/// See also [stpSpeciesList].
class StpSpeciesListProvider
    extends AutoDisposeFutureProvider<List<StpSpeciesData>> {
  /// See also [stpSpeciesList].
  StpSpeciesListProvider(
    int stpId,
  ) : this._internal(
          (ref) => stpSpeciesList(
            ref as StpSpeciesListRef,
            stpId,
          ),
          from: stpSpeciesListProvider,
          name: r'stpSpeciesListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stpSpeciesListHash,
          dependencies: StpSpeciesListFamily._dependencies,
          allTransitiveDependencies:
              StpSpeciesListFamily._allTransitiveDependencies,
          stpId: stpId,
        );

  StpSpeciesListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stpId,
  }) : super.internal();

  final int stpId;

  @override
  Override overrideWith(
    FutureOr<List<StpSpeciesData>> Function(StpSpeciesListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StpSpeciesListProvider._internal(
        (ref) => create(ref as StpSpeciesListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stpId: stpId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<StpSpeciesData>> createElement() {
    return _StpSpeciesListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StpSpeciesListProvider && other.stpId == stpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StpSpeciesListRef on AutoDisposeFutureProviderRef<List<StpSpeciesData>> {
  /// The parameter `stpId` of this provider.
  int get stpId;
}

class _StpSpeciesListProviderElement
    extends AutoDisposeFutureProviderElement<List<StpSpeciesData>>
    with StpSpeciesListRef {
  _StpSpeciesListProviderElement(super.provider);

  @override
  int get stpId => (origin as StpSpeciesListProvider).stpId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
