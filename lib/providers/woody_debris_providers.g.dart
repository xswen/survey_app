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
  (int,) get argument {
    return (surveyId,);
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
  (int,) get argument {
    return (wdId,);
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
  (int,) get argument {
    return (wdhId,);
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
  (int,) get argument {
    return (wdId,);
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

String _$wdhSmallParentCompleteHash() =>
    r'23f8969eed9068b72154140a3d7e7e906d16734f';

/// See also [wdhSmallParentComplete].
@ProviderFor(wdhSmallParentComplete)
const wdhSmallParentCompleteProvider = WdhSmallParentCompleteFamily();

/// See also [wdhSmallParentComplete].
class WdhSmallParentCompleteFamily extends Family<AsyncValue<bool>> {
  /// See also [wdhSmallParentComplete].
  const WdhSmallParentCompleteFamily();

  /// See also [wdhSmallParentComplete].
  WdhSmallParentCompleteProvider call(
    int wdhId,
  ) {
    return WdhSmallParentCompleteProvider(
      wdhId,
    );
  }

  @visibleForOverriding
  @override
  WdhSmallParentCompleteProvider getProviderOverride(
    covariant WdhSmallParentCompleteProvider provider,
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
  String? get name => r'wdhSmallParentCompleteProvider';
}

/// See also [wdhSmallParentComplete].
class WdhSmallParentCompleteProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [wdhSmallParentComplete].
  WdhSmallParentCompleteProvider(
    int wdhId,
  ) : this._internal(
          (ref) => wdhSmallParentComplete(
            ref as WdhSmallParentCompleteRef,
            wdhId,
          ),
          from: wdhSmallParentCompleteProvider,
          name: r'wdhSmallParentCompleteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdhSmallParentCompleteHash,
          dependencies: WdhSmallParentCompleteFamily._dependencies,
          allTransitiveDependencies:
              WdhSmallParentCompleteFamily._allTransitiveDependencies,
          wdhId: wdhId,
        );

  WdhSmallParentCompleteProvider._internal(
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
    FutureOr<bool> Function(WdhSmallParentCompleteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdhSmallParentCompleteProvider._internal(
        (ref) => create(ref as WdhSmallParentCompleteRef),
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
  (int,) get argument {
    return (wdhId,);
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _WdhSmallParentCompleteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdhSmallParentCompleteProvider && other.wdhId == wdhId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdhId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdhSmallParentCompleteRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `wdhId` of this provider.
  int get wdhId;
}

class _WdhSmallParentCompleteProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with WdhSmallParentCompleteRef {
  _WdhSmallParentCompleteProviderElement(super.provider);

  @override
  int get wdhId => (origin as WdhSmallParentCompleteProvider).wdhId;
}

String _$wdPieceOddHash() => r'b787ad2e81ae15fc4fdbfa7751d1c5538cbdcb99';

/// See also [wdPieceOdd].
@ProviderFor(wdPieceOdd)
const wdPieceOddProvider = WdPieceOddFamily();

/// See also [wdPieceOdd].
class WdPieceOddFamily extends Family<AsyncValue<List<WoodyDebrisOddData>>> {
  /// See also [wdPieceOdd].
  const WdPieceOddFamily();

  /// See also [wdPieceOdd].
  WdPieceOddProvider call(
    int wdhId,
  ) {
    return WdPieceOddProvider(
      wdhId,
    );
  }

  @visibleForOverriding
  @override
  WdPieceOddProvider getProviderOverride(
    covariant WdPieceOddProvider provider,
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
  String? get name => r'wdPieceOddProvider';
}

/// See also [wdPieceOdd].
class WdPieceOddProvider
    extends AutoDisposeFutureProvider<List<WoodyDebrisOddData>> {
  /// See also [wdPieceOdd].
  WdPieceOddProvider(
    int wdhId,
  ) : this._internal(
          (ref) => wdPieceOdd(
            ref as WdPieceOddRef,
            wdhId,
          ),
          from: wdPieceOddProvider,
          name: r'wdPieceOddProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdPieceOddHash,
          dependencies: WdPieceOddFamily._dependencies,
          allTransitiveDependencies:
              WdPieceOddFamily._allTransitiveDependencies,
          wdhId: wdhId,
        );

  WdPieceOddProvider._internal(
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
    FutureOr<List<WoodyDebrisOddData>> Function(WdPieceOddRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdPieceOddProvider._internal(
        (ref) => create(ref as WdPieceOddRef),
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
  (int,) get argument {
    return (wdhId,);
  }

  @override
  AutoDisposeFutureProviderElement<List<WoodyDebrisOddData>> createElement() {
    return _WdPieceOddProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdPieceOddProvider && other.wdhId == wdhId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdhId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdPieceOddRef on AutoDisposeFutureProviderRef<List<WoodyDebrisOddData>> {
  /// The parameter `wdhId` of this provider.
  int get wdhId;
}

class _WdPieceOddProviderElement
    extends AutoDisposeFutureProviderElement<List<WoodyDebrisOddData>>
    with WdPieceOddRef {
  _WdPieceOddProviderElement(super.provider);

  @override
  int get wdhId => (origin as WdPieceOddProvider).wdhId;
}

String _$wdPieceRoundHash() => r'97305a76a66a5d15e8c418c542f4c7ed66b859a8';

/// See also [wdPieceRound].
@ProviderFor(wdPieceRound)
const wdPieceRoundProvider = WdPieceRoundFamily();

/// See also [wdPieceRound].
class WdPieceRoundFamily
    extends Family<AsyncValue<List<WoodyDebrisRoundData>>> {
  /// See also [wdPieceRound].
  const WdPieceRoundFamily();

  /// See also [wdPieceRound].
  WdPieceRoundProvider call(
    int wdhId,
  ) {
    return WdPieceRoundProvider(
      wdhId,
    );
  }

  @visibleForOverriding
  @override
  WdPieceRoundProvider getProviderOverride(
    covariant WdPieceRoundProvider provider,
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
  String? get name => r'wdPieceRoundProvider';
}

/// See also [wdPieceRound].
class WdPieceRoundProvider
    extends AutoDisposeFutureProvider<List<WoodyDebrisRoundData>> {
  /// See also [wdPieceRound].
  WdPieceRoundProvider(
    int wdhId,
  ) : this._internal(
          (ref) => wdPieceRound(
            ref as WdPieceRoundRef,
            wdhId,
          ),
          from: wdPieceRoundProvider,
          name: r'wdPieceRoundProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdPieceRoundHash,
          dependencies: WdPieceRoundFamily._dependencies,
          allTransitiveDependencies:
              WdPieceRoundFamily._allTransitiveDependencies,
          wdhId: wdhId,
        );

  WdPieceRoundProvider._internal(
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
    FutureOr<List<WoodyDebrisRoundData>> Function(WdPieceRoundRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdPieceRoundProvider._internal(
        (ref) => create(ref as WdPieceRoundRef),
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
  (int,) get argument {
    return (wdhId,);
  }

  @override
  AutoDisposeFutureProviderElement<List<WoodyDebrisRoundData>> createElement() {
    return _WdPieceRoundProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdPieceRoundProvider && other.wdhId == wdhId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdhId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdPieceRoundRef
    on AutoDisposeFutureProviderRef<List<WoodyDebrisRoundData>> {
  /// The parameter `wdhId` of this provider.
  int get wdhId;
}

class _WdPieceRoundProviderElement
    extends AutoDisposeFutureProviderElement<List<WoodyDebrisRoundData>>
    with WdPieceRoundRef {
  _WdPieceRoundProviderElement(super.provider);

  @override
  int get wdhId => (origin as WdPieceRoundProvider).wdhId;
}

String _$wdSmallHash() => r'e13eddbbd08c3a80fe66a2860593fa1266c8069e';

/// See also [wdSmall].
@ProviderFor(wdSmall)
const wdSmallProvider = WdSmallFamily();

/// See also [wdSmall].
class WdSmallFamily extends Family<AsyncValue<WoodyDebrisSmallData?>> {
  /// See also [wdSmall].
  const WdSmallFamily();

  /// See also [wdSmall].
  WdSmallProvider call(
    int wdhId,
  ) {
    return WdSmallProvider(
      wdhId,
    );
  }

  @visibleForOverriding
  @override
  WdSmallProvider getProviderOverride(
    covariant WdSmallProvider provider,
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
  String? get name => r'wdSmallProvider';
}

/// See also [wdSmall].
class WdSmallProvider extends AutoDisposeFutureProvider<WoodyDebrisSmallData?> {
  /// See also [wdSmall].
  WdSmallProvider(
    int wdhId,
  ) : this._internal(
          (ref) => wdSmall(
            ref as WdSmallRef,
            wdhId,
          ),
          from: wdSmallProvider,
          name: r'wdSmallProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wdSmallHash,
          dependencies: WdSmallFamily._dependencies,
          allTransitiveDependencies: WdSmallFamily._allTransitiveDependencies,
          wdhId: wdhId,
        );

  WdSmallProvider._internal(
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
    FutureOr<WoodyDebrisSmallData?> Function(WdSmallRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WdSmallProvider._internal(
        (ref) => create(ref as WdSmallRef),
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
  (int,) get argument {
    return (wdhId,);
  }

  @override
  AutoDisposeFutureProviderElement<WoodyDebrisSmallData?> createElement() {
    return _WdSmallProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WdSmallProvider && other.wdhId == wdhId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wdhId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WdSmallRef on AutoDisposeFutureProviderRef<WoodyDebrisSmallData?> {
  /// The parameter `wdhId` of this provider.
  int get wdhId;
}

class _WdSmallProviderElement
    extends AutoDisposeFutureProviderElement<WoodyDebrisSmallData?>
    with WdSmallRef {
  _WdSmallProviderElement(super.provider);

  @override
  int get wdhId => (origin as WdSmallProvider).wdhId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
