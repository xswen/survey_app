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

String _$wdTransListHash() => r'ed90e9decde33e2a0ed46f8a5773ce81cf1eceb5';

/// See also [wdTransList].
@ProviderFor(wdTransList)
const wdTransListProvider = WdTransListFamily();

/// See also [wdTransList].
class WdTransListFamily
    extends Family<AsyncValue<List<WoodyDebrisHeaderData>>> {
  /// See also [wdTransList].
  const WdTransListFamily();

  /// See also [wdTransList].
  WdTransListProvider call(
    int wdId,
  ) {
    return WdTransListProvider(
      wdId,
    );
  }

  @visibleForOverriding
  @override
  WdTransListProvider getProviderOverride(
    covariant WdTransListProvider provider,
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
  String? get name => r'wdTransListProvider';
}

/// See also [wdTransList].
class WdTransListProvider
    extends AutoDisposeFutureProvider<List<WoodyDebrisHeaderData>> {
  /// See also [wdTransList].
  WdTransListProvider(
    int wdId,
  ) : this._internal(
          (ref) => wdTransList(
            ref as WdTransListRef,
            wdId,
          ),
          from: wdTransListProvider,
          name: r'wdTransListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdTransListHash,
          dependencies: WdTransListFamily._dependencies,
          allTransitiveDependencies:
              WdTransListFamily._allTransitiveDependencies,
          wdId: wdId,
        );

  WdTransListProvider._internal(
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
    FutureOr<List<WoodyDebrisHeaderData>> Function(WdTransListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdTransListProvider._internal(
        (ref) => create(ref as WdTransListRef),
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
    return _WdTransListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdTransListProvider && other.wdId == wdId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdTransListRef
    on AutoDisposeFutureProviderRef<List<WoodyDebrisHeaderData>> {
  /// The parameter `wdId` of this provider.
  int get wdId;
}

class _WdTransListProviderElement
    extends AutoDisposeFutureProviderElement<List<WoodyDebrisHeaderData>>
    with WdTransListRef {
  _WdTransListProviderElement(super.provider);

  @override
  int get wdId => (origin as WdTransListProvider).wdId;
}

String _$wdhParentCompleteHash() => r'54294265adb906ba93dd462ee94822140d2cd023';

/// See also [wdhParentComplete].
@ProviderFor(wdhParentComplete)
const wdhParentCompleteProvider = WdhParentCompleteFamily();

/// See also [wdhParentComplete].
class WdhParentCompleteFamily extends Family<AsyncValue<bool>> {
  /// See also [wdhParentComplete].
  const WdhParentCompleteFamily();

  /// See also [wdhParentComplete].
  WdhParentCompleteProvider call(
    int wdId,
  ) {
    return WdhParentCompleteProvider(
      wdId,
    );
  }

  @visibleForOverriding
  @override
  WdhParentCompleteProvider getProviderOverride(
    covariant WdhParentCompleteProvider provider,
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
  String? get name => r'wdhParentCompleteProvider';
}

/// See also [wdhParentComplete].
class WdhParentCompleteProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [wdhParentComplete].
  WdhParentCompleteProvider(
    int wdId,
  ) : this._internal(
          (ref) => wdhParentComplete(
            ref as WdhParentCompleteRef,
            wdId,
          ),
          from: wdhParentCompleteProvider,
          name: r'wdhParentCompleteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdhParentCompleteHash,
          dependencies: WdhParentCompleteFamily._dependencies,
          allTransitiveDependencies:
              WdhParentCompleteFamily._allTransitiveDependencies,
          wdId: wdId,
        );

  WdhParentCompleteProvider._internal(
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
    FutureOr<bool> Function(WdhParentCompleteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdhParentCompleteProvider._internal(
        (ref) => create(ref as WdhParentCompleteRef),
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
    return _WdhParentCompleteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdhParentCompleteProvider && other.wdId == wdId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdhParentCompleteRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `wdId` of this provider.
  int get wdId;
}

class _WdhParentCompleteProviderElement
    extends AutoDisposeFutureProviderElement<bool> with WdhParentCompleteRef {
  _WdhParentCompleteProviderElement(super.provider);

  @override
  int get wdId => (origin as WdhParentCompleteProvider).wdId;
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

String _$wdhCompanionHash() => r'e045b3adc1f9f31201622d0d550915f1ec6b4951';

/// See also [wdhCompanion].
@ProviderFor(wdhCompanion)
const wdhCompanionProvider = WdhCompanionFamily();

/// See also [wdhCompanion].
class WdhCompanionFamily extends Family<WoodyDebrisHeaderCompanion> {
  /// See also [wdhCompanion].
  const WdhCompanionFamily();

  /// See also [wdhCompanion].
  WdhCompanionProvider call(
    WoodyDebrisHeaderCompanion wdhC,
  ) {
    return WdhCompanionProvider(
      wdhC,
    );
  }

  @visibleForOverriding
  @override
  WdhCompanionProvider getProviderOverride(
    covariant WdhCompanionProvider provider,
  ) {
    return call(
      provider.wdhC,
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
  String? get name => r'wdhCompanionProvider';
}

/// See also [wdhCompanion].
class WdhCompanionProvider
    extends AutoDisposeProvider<WoodyDebrisHeaderCompanion> {
  /// See also [wdhCompanion].
  WdhCompanionProvider(
    WoodyDebrisHeaderCompanion wdhC,
  ) : this._internal(
          (ref) => wdhCompanion(
            ref as WdhCompanionRef,
            wdhC,
          ),
          from: wdhCompanionProvider,
          name: r'wdhCompanionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdhCompanionHash,
          dependencies: WdhCompanionFamily._dependencies,
          allTransitiveDependencies:
              WdhCompanionFamily._allTransitiveDependencies,
          wdhC: wdhC,
        );

  WdhCompanionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wdhC,
  }) : super.internal();

  final WoodyDebrisHeaderCompanion wdhC;

  @override
  Override overrideWith(
    WoodyDebrisHeaderCompanion Function(WdhCompanionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdhCompanionProvider._internal(
        (ref) => create(ref as WdhCompanionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wdhC: wdhC,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<WoodyDebrisHeaderCompanion> createElement() {
    return _WdhCompanionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdhCompanionProvider && other.wdhC == wdhC;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdhC.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdhCompanionRef on AutoDisposeProviderRef<WoodyDebrisHeaderCompanion> {
  /// The parameter `wdhC` of this provider.
  WoodyDebrisHeaderCompanion get wdhC;
}

class _WdhCompanionProviderElement
    extends AutoDisposeProviderElement<WoodyDebrisHeaderCompanion>
    with WdhCompanionRef {
  _WdhCompanionProviderElement(super.provider);

  @override
  WoodyDebrisHeaderCompanion get wdhC => (origin as WdhCompanionProvider).wdhC;
}

String _$wdhCompanionHandlerHash() =>
    r'5dc65ba5a4ebb2a6abc62ee7b1a092912be7fcfa';

abstract class _$WdhCompanionHandler
    extends BuildlessAutoDisposeNotifier<WoodyDebrisHeaderCompanion> {
  late final WoodyDebrisHeaderCompanion wdh;

  WoodyDebrisHeaderCompanion build(
    WoodyDebrisHeaderCompanion wdh,
  );
}

/// See also [WdhCompanionHandler].
@ProviderFor(WdhCompanionHandler)
const wdhCompanionHandlerProvider = WdhCompanionHandlerFamily();

/// See also [WdhCompanionHandler].
class WdhCompanionHandlerFamily extends Family<WoodyDebrisHeaderCompanion> {
  /// See also [WdhCompanionHandler].
  const WdhCompanionHandlerFamily();

  /// See also [WdhCompanionHandler].
  WdhCompanionHandlerProvider call(
    WoodyDebrisHeaderCompanion wdh,
  ) {
    return WdhCompanionHandlerProvider(
      wdh,
    );
  }

  @visibleForOverriding
  @override
  WdhCompanionHandlerProvider getProviderOverride(
    covariant WdhCompanionHandlerProvider provider,
  ) {
    return call(
      provider.wdh,
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
  String? get name => r'wdhCompanionHandlerProvider';
}

/// See also [WdhCompanionHandler].
class WdhCompanionHandlerProvider extends AutoDisposeNotifierProviderImpl<
    WdhCompanionHandler, WoodyDebrisHeaderCompanion> {
  /// See also [WdhCompanionHandler].
  WdhCompanionHandlerProvider(
    WoodyDebrisHeaderCompanion wdh,
  ) : this._internal(
          () => WdhCompanionHandler()..wdh = wdh,
          from: wdhCompanionHandlerProvider,
          name: r'wdhCompanionHandlerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdhCompanionHandlerHash,
          dependencies: WdhCompanionHandlerFamily._dependencies,
          allTransitiveDependencies:
              WdhCompanionHandlerFamily._allTransitiveDependencies,
          wdh: wdh,
        );

  WdhCompanionHandlerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wdh,
  }) : super.internal();

  final WoodyDebrisHeaderCompanion wdh;

  @override
  WoodyDebrisHeaderCompanion runNotifierBuild(
    covariant WdhCompanionHandler notifier,
  ) {
    return notifier.build(
      wdh,
    );
  }

  @override
  Override overrideWith(WdhCompanionHandler Function() create) {
    return ProviderOverride(
      origin: this,
      override: WdhCompanionHandlerProvider._internal(
        () => create()..wdh = wdh,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wdh: wdh,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<WdhCompanionHandler,
      WoodyDebrisHeaderCompanion> createElement() {
    return _WdhCompanionHandlerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdhCompanionHandlerProvider && other.wdh == wdh;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdh.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdhCompanionHandlerRef
    on AutoDisposeNotifierProviderRef<WoodyDebrisHeaderCompanion> {
  /// The parameter `wdh` of this provider.
  WoodyDebrisHeaderCompanion get wdh;
}

class _WdhCompanionHandlerProviderElement
    extends AutoDisposeNotifierProviderElement<WdhCompanionHandler,
        WoodyDebrisHeaderCompanion> with WdhCompanionHandlerRef {
  _WdhCompanionHandlerProviderElement(super.provider);

  @override
  WoodyDebrisHeaderCompanion get wdh =>
      (origin as WdhCompanionHandlerProvider).wdh;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter
