// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soil_pit_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$soilSiteInfoDataHash() => r'f544e40886905174ae0adf82480517439f8829f0';

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

/// See also [soilSiteInfoData].
@ProviderFor(soilSiteInfoData)
const soilSiteInfoDataProvider = SoilSiteInfoDataFamily();

/// See also [soilSiteInfoData].
class SoilSiteInfoDataFamily extends Family<AsyncValue<SoilPitSummaryData>> {
  /// See also [soilSiteInfoData].
  const SoilSiteInfoDataFamily();

  /// See also [soilSiteInfoData].
  SoilSiteInfoDataProvider call(
    int surveyId,
  ) {
    return SoilSiteInfoDataProvider(
      surveyId,
    );
  }

  @override
  SoilSiteInfoDataProvider getProviderOverride(
    covariant SoilSiteInfoDataProvider provider,
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
  String? get name => r'soilSiteInfoDataProvider';
}

/// See also [soilSiteInfoData].
class SoilSiteInfoDataProvider
    extends AutoDisposeFutureProvider<SoilPitSummaryData> {
  /// See also [soilSiteInfoData].
  SoilSiteInfoDataProvider(
    int surveyId,
  ) : this._internal(
          (ref) => soilSiteInfoData(
            ref as SoilSiteInfoDataRef,
            surveyId,
          ),
          from: soilSiteInfoDataProvider,
          name: r'soilSiteInfoDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$soilSiteInfoDataHash,
          dependencies: SoilSiteInfoDataFamily._dependencies,
          allTransitiveDependencies:
              SoilSiteInfoDataFamily._allTransitiveDependencies,
          surveyId: surveyId,
        );

  SoilSiteInfoDataProvider._internal(
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
    FutureOr<SoilPitSummaryData> Function(SoilSiteInfoDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SoilSiteInfoDataProvider._internal(
        (ref) => create(ref as SoilSiteInfoDataRef),
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
  AutoDisposeFutureProviderElement<SoilPitSummaryData> createElement() {
    return _SoilSiteInfoDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SoilSiteInfoDataProvider && other.surveyId == surveyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surveyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SoilSiteInfoDataRef on AutoDisposeFutureProviderRef<SoilPitSummaryData> {
  /// The parameter `surveyId` of this provider.
  int get surveyId;
}

class _SoilSiteInfoDataProviderElement
    extends AutoDisposeFutureProviderElement<SoilPitSummaryData>
    with SoilSiteInfoDataRef {
  _SoilSiteInfoDataProviderElement(super.provider);

  @override
  int get surveyId => (origin as SoilSiteInfoDataProvider).surveyId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
