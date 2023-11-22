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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
