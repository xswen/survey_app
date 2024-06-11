// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ground_plot_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gpSummaryDataHash() => r'2813ac6a67c759ebc4fc15eb8c30d058ba623ccf';

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

/// See also [gpSummaryData].
@ProviderFor(gpSummaryData)
const gpSummaryDataProvider = GpSummaryDataFamily();

/// See also [gpSummaryData].
class GpSummaryDataFamily extends Family<AsyncValue<GpSummaryData>> {
  /// See also [gpSummaryData].
  const GpSummaryDataFamily();

  /// See also [gpSummaryData].
  GpSummaryDataProvider call(
    int gpSummaryId,
  ) {
    return GpSummaryDataProvider(
      gpSummaryId,
    );
  }

  @override
  GpSummaryDataProvider getProviderOverride(
    covariant GpSummaryDataProvider provider,
  ) {
    return call(
      provider.gpSummaryId,
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
  String? get name => r'gpSummaryDataProvider';
}

/// See also [gpSummaryData].
class GpSummaryDataProvider extends AutoDisposeFutureProvider<GpSummaryData> {
  /// See also [gpSummaryData].
  GpSummaryDataProvider(
    int gpSummaryId,
  ) : this._internal(
          (ref) => gpSummaryData(
            ref as GpSummaryDataRef,
            gpSummaryId,
          ),
          from: gpSummaryDataProvider,
          name: r'gpSummaryDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gpSummaryDataHash,
          dependencies: GpSummaryDataFamily._dependencies,
          allTransitiveDependencies:
              GpSummaryDataFamily._allTransitiveDependencies,
          gpSummaryId: gpSummaryId,
        );

  GpSummaryDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gpSummaryId,
  }) : super.internal();

  final int gpSummaryId;

  @override
  Override overrideWith(
    FutureOr<GpSummaryData> Function(GpSummaryDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GpSummaryDataProvider._internal(
        (ref) => create(ref as GpSummaryDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gpSummaryId: gpSummaryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GpSummaryData> createElement() {
    return _GpSummaryDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GpSummaryDataProvider && other.gpSummaryId == gpSummaryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gpSummaryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GpSummaryDataRef on AutoDisposeFutureProviderRef<GpSummaryData> {
  /// The parameter `gpSummaryId` of this provider.
  int get gpSummaryId;
}

class _GpSummaryDataProviderElement
    extends AutoDisposeFutureProviderElement<GpSummaryData>
    with GpSummaryDataRef {
  _GpSummaryDataProviderElement(super.provider);

  @override
  int get gpSummaryId => (origin as GpSummaryDataProvider).gpSummaryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
