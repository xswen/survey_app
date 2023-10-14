// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'woody_debris_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wdDataHash() => r'7f129f2bf2445d2facca30f1ad1880cbf5fd36bd';

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

/// See also [wdData].
@ProviderFor(wdData)
const wdDataProvider = WdDataFamily();

/// See also [wdData].
class WdDataFamily extends Family<AsyncValue<WoodyDebrisSummaryData>> {
  /// See also [wdData].
  const WdDataFamily();

  /// See also [wdData].
  WdDataProvider call(
    int surveyId,
  ) {
    return WdDataProvider(
      surveyId,
    );
  }

  @visibleForOverriding
  @override
  WdDataProvider getProviderOverride(
    covariant WdDataProvider provider,
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
  String? get name => r'wdDataProvider';
}

/// See also [wdData].
class WdDataProvider extends AutoDisposeFutureProvider<WoodyDebrisSummaryData> {
  /// See also [wdData].
  WdDataProvider(
    int surveyId,
  ) : this._internal(
          (ref) => wdData(
            ref as WdDataRef,
            surveyId,
          ),
          from: wdDataProvider,
          name: r'wdDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdDataHash,
          dependencies: WdDataFamily._dependencies,
          allTransitiveDependencies: WdDataFamily._allTransitiveDependencies,
          surveyId: surveyId,
        );

  WdDataProvider._internal(
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
    FutureOr<WoodyDebrisSummaryData> Function(WdDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdDataProvider._internal(
        (ref) => create(ref as WdDataRef),
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
  AutoDisposeFutureProviderElement<WoodyDebrisSummaryData> createElement() {
    return _WdDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdDataProvider && other.surveyId == surveyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surveyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdDataRef on AutoDisposeFutureProviderRef<WoodyDebrisSummaryData> {
  /// The parameter `surveyId` of this provider.
  int get surveyId;
}

class _WdDataProviderElement
    extends AutoDisposeFutureProviderElement<WoodyDebrisSummaryData>
    with WdDataRef {
  _WdDataProviderElement(super.provider);

  @override
  int get surveyId => (origin as WdDataProvider).surveyId;
}

String _$transListHash() => r'c2949634a9430d3daf027b6bca761005cc0b17c8';

/// See also [transList].
@ProviderFor(transList)
const transListProvider = TransListFamily();

/// See also [transList].
class TransListFamily extends Family<AsyncValue<List<WoodyDebrisHeaderData>>> {
  /// See also [transList].
  const TransListFamily();

  /// See also [transList].
  TransListProvider call(
    int wdId,
  ) {
    return TransListProvider(
      wdId,
    );
  }

  @visibleForOverriding
  @override
  TransListProvider getProviderOverride(
    covariant TransListProvider provider,
  ) {
    return call(
      provider.wdId,
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
  String? get name => r'transListProvider';
}

/// See also [transList].
class TransListProvider
    extends AutoDisposeFutureProvider<List<WoodyDebrisHeaderData>> {
  /// See also [transList].
  TransListProvider(
    int wdId,
  ) : this._internal(
          (ref) => transList(
            ref as TransListRef,
            wdId,
          ),
          from: transListProvider,
          name: r'transListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transListHash,
          dependencies: TransListFamily._dependencies,
          allTransitiveDependencies: TransListFamily._allTransitiveDependencies,
          wdId: wdId,
        );

  TransListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wdId,
  }) : super.internal();

  final int wdId;

  @override
  Override overrideWith(
    FutureOr<List<WoodyDebrisHeaderData>> Function(TransListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransListProvider._internal(
        (ref) => create(ref as TransListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wdId: wdId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WoodyDebrisHeaderData>>
      createElement() {
    return _TransListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransListProvider && other.wdId == wdId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TransListRef
    on AutoDisposeFutureProviderRef<List<WoodyDebrisHeaderData>> {
  /// The parameter `wdId` of this provider.
  int get wdId;
}

class _TransListProviderElement
    extends AutoDisposeFutureProviderElement<List<WoodyDebrisHeaderData>>
    with TransListRef {
  _TransListProviderElement(super.provider);

  @override
  int get wdId => (origin as TransListProvider).wdId;
}

String _$parentCompleteHash() => r'698732317a0461dc5e14ed08b71a9254d2531e60';

/// See also [parentComplete].
@ProviderFor(parentComplete)
const parentCompleteProvider = ParentCompleteFamily();

/// See also [parentComplete].
class ParentCompleteFamily extends Family<AsyncValue<bool>> {
  /// See also [parentComplete].
  const ParentCompleteFamily();

  /// See also [parentComplete].
  ParentCompleteProvider call(
    int wdId,
  ) {
    return ParentCompleteProvider(
      wdId,
    );
  }

  @visibleForOverriding
  @override
  ParentCompleteProvider getProviderOverride(
    covariant ParentCompleteProvider provider,
  ) {
    return call(
      provider.wdId,
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
  String? get name => r'parentCompleteProvider';
}

/// See also [parentComplete].
class ParentCompleteProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [parentComplete].
  ParentCompleteProvider(
    int wdId,
  ) : this._internal(
          (ref) => parentComplete(
            ref as ParentCompleteRef,
            wdId,
          ),
          from: parentCompleteProvider,
          name: r'parentCompleteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$parentCompleteHash,
          dependencies: ParentCompleteFamily._dependencies,
          allTransitiveDependencies:
              ParentCompleteFamily._allTransitiveDependencies,
          wdId: wdId,
        );

  ParentCompleteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wdId,
  }) : super.internal();

  final int wdId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(ParentCompleteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ParentCompleteProvider._internal(
        (ref) => create(ref as ParentCompleteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wdId: wdId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _ParentCompleteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ParentCompleteProvider && other.wdId == wdId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ParentCompleteRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `wdId` of this provider.
  int get wdId;
}

class _ParentCompleteProviderElement
    extends AutoDisposeFutureProviderElement<bool> with ParentCompleteRef {
  _ParentCompleteProviderElement(super.provider);

  @override
  int get wdId => (origin as ParentCompleteProvider).wdId;
}

String _$wdhHash() => r'ac49594924601a309863d77dc7e3025f447ceddb';

/// See also [wdh].
@ProviderFor(wdh)
const wdhProvider = WdhFamily();

/// See also [wdh].
class WdhFamily extends Family<AsyncValue<WoodyDebrisHeaderData>> {
  /// See also [wdh].
  const WdhFamily();

  /// See also [wdh].
  WdhProvider call(
    int wdhId,
  ) {
    return WdhProvider(
      wdhId,
    );
  }

  @visibleForOverriding
  @override
  WdhProvider getProviderOverride(
    covariant WdhProvider provider,
  ) {
    return call(
      provider.wdhId,
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
  String? get name => r'wdhProvider';
}

/// See also [wdh].
class WdhProvider extends AutoDisposeFutureProvider<WoodyDebrisHeaderData> {
  /// See also [wdh].
  WdhProvider(
    int wdhId,
  ) : this._internal(
          (ref) => wdh(
            ref as WdhRef,
            wdhId,
          ),
          from: wdhProvider,
          name: r'wdhProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$wdhHash,
          dependencies: WdhFamily._dependencies,
          allTransitiveDependencies: WdhFamily._allTransitiveDependencies,
          wdhId: wdhId,
        );

  WdhProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wdhId,
  }) : super.internal();

  final int wdhId;

  @override
  Override overrideWith(
    FutureOr<WoodyDebrisHeaderData> Function(WdhRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdhProvider._internal(
        (ref) => create(ref as WdhRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wdhId: wdhId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<WoodyDebrisHeaderData> createElement() {
    return _WdhProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdhProvider && other.wdhId == wdhId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdhId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdhRef on AutoDisposeFutureProviderRef<WoodyDebrisHeaderData> {
  /// The parameter `wdhId` of this provider.
  int get wdhId;
}

class _WdhProviderElement
    extends AutoDisposeFutureProviderElement<WoodyDebrisHeaderData>
    with WdhRef {
  _WdhProviderElement(super.provider);

  @override
  int get wdhId => (origin as WdhProvider).wdhId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter
