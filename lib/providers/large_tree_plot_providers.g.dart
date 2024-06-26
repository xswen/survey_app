// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'large_tree_plot_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ltpDataHash() => r'fe81aecc5bb2dcd7fcb069e5bb6cae834e78158b';

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

/// See also [ltpData].
@ProviderFor(ltpData)
const ltpDataProvider = LtpDataFamily();

/// See also [ltpData].
class LtpDataFamily extends Family<AsyncValue<LtpSummaryData>> {
  /// See also [ltpData].
  const LtpDataFamily();

  /// See also [ltpData].
  LtpDataProvider call(
    int ltpId,
  ) {
    return LtpDataProvider(
      ltpId,
    );
  }

  @override
  LtpDataProvider getProviderOverride(
    covariant LtpDataProvider provider,
  ) {
    return call(
      provider.ltpId,
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
  String? get name => r'ltpDataProvider';
}

/// See also [ltpData].
class LtpDataProvider extends AutoDisposeFutureProvider<LtpSummaryData> {
  /// See also [ltpData].
  LtpDataProvider(
    int ltpId,
  ) : this._internal(
          (ref) => ltpData(
            ref as LtpDataRef,
            ltpId,
          ),
          from: ltpDataProvider,
          name: r'ltpDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ltpDataHash,
          dependencies: LtpDataFamily._dependencies,
          allTransitiveDependencies: LtpDataFamily._allTransitiveDependencies,
          ltpId: ltpId,
        );

  LtpDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ltpId,
  }) : super.internal();

  final int ltpId;

  @override
  Override overrideWith(
    FutureOr<LtpSummaryData> Function(LtpDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LtpDataProvider._internal(
        (ref) => create(ref as LtpDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ltpId: ltpId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LtpSummaryData> createElement() {
    return _LtpDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LtpDataProvider && other.ltpId == ltpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ltpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LtpDataRef on AutoDisposeFutureProviderRef<LtpSummaryData> {
  /// The parameter `ltpId` of this provider.
  int get ltpId;
}

class _LtpDataProviderElement
    extends AutoDisposeFutureProviderElement<LtpSummaryData> with LtpDataRef {
  _LtpDataProviderElement(super.provider);

  @override
  int get ltpId => (origin as LtpDataProvider).ltpId;
}

String _$ltpMergedTreeEntryListHash() =>
    r'1ce8372ea0398e40ae7b9ee81595a29bfc6056d7';

/// See also [ltpMergedTreeEntryList].
@ProviderFor(ltpMergedTreeEntryList)
const ltpMergedTreeEntryListProvider = LtpMergedTreeEntryListFamily();

/// See also [ltpMergedTreeEntryList].
class LtpMergedTreeEntryListFamily
    extends Family<AsyncValue<List<LtpMergedTreeEntry>>> {
  /// See also [ltpMergedTreeEntryList].
  const LtpMergedTreeEntryListFamily();

  /// See also [ltpMergedTreeEntryList].
  LtpMergedTreeEntryListProvider call(
    int ltpSummaryId,
  ) {
    return LtpMergedTreeEntryListProvider(
      ltpSummaryId,
    );
  }

  @override
  LtpMergedTreeEntryListProvider getProviderOverride(
    covariant LtpMergedTreeEntryListProvider provider,
  ) {
    return call(
      provider.ltpSummaryId,
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
  String? get name => r'ltpMergedTreeEntryListProvider';
}

/// See also [ltpMergedTreeEntryList].
class LtpMergedTreeEntryListProvider
    extends AutoDisposeFutureProvider<List<LtpMergedTreeEntry>> {
  /// See also [ltpMergedTreeEntryList].
  LtpMergedTreeEntryListProvider(
    int ltpSummaryId,
  ) : this._internal(
          (ref) => ltpMergedTreeEntryList(
            ref as LtpMergedTreeEntryListRef,
            ltpSummaryId,
          ),
          from: ltpMergedTreeEntryListProvider,
          name: r'ltpMergedTreeEntryListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ltpMergedTreeEntryListHash,
          dependencies: LtpMergedTreeEntryListFamily._dependencies,
          allTransitiveDependencies:
              LtpMergedTreeEntryListFamily._allTransitiveDependencies,
          ltpSummaryId: ltpSummaryId,
        );

  LtpMergedTreeEntryListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ltpSummaryId,
  }) : super.internal();

  final int ltpSummaryId;

  @override
  Override overrideWith(
    FutureOr<List<LtpMergedTreeEntry>> Function(
            LtpMergedTreeEntryListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LtpMergedTreeEntryListProvider._internal(
        (ref) => create(ref as LtpMergedTreeEntryListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ltpSummaryId: ltpSummaryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LtpMergedTreeEntry>> createElement() {
    return _LtpMergedTreeEntryListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LtpMergedTreeEntryListProvider &&
        other.ltpSummaryId == ltpSummaryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ltpSummaryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LtpMergedTreeEntryListRef
    on AutoDisposeFutureProviderRef<List<LtpMergedTreeEntry>> {
  /// The parameter `ltpSummaryId` of this provider.
  int get ltpSummaryId;
}

class _LtpMergedTreeEntryListProviderElement
    extends AutoDisposeFutureProviderElement<List<LtpMergedTreeEntry>>
    with LtpMergedTreeEntryListRef {
  _LtpMergedTreeEntryListProviderElement(super.provider);

  @override
  int get ltpSummaryId =>
      (origin as LtpMergedTreeEntryListProvider).ltpSummaryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
