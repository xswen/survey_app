// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stump_plot_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stumpEntryListHash() => r'2417153dda4d0fc7dc0abd06c3e7e8f095f73ca3';

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

/// See also [stumpEntryList].
@ProviderFor(stumpEntryList)
const stumpEntryListProvider = StumpEntryListFamily();

/// See also [stumpEntryList].
class StumpEntryListFamily extends Family<AsyncValue<List<StumpEntryData>>> {
  /// See also [stumpEntryList].
  const StumpEntryListFamily();

  /// See also [stumpEntryList].
  StumpEntryListProvider call(
    int stumpId,
  ) {
    return StumpEntryListProvider(
      stumpId,
    );
  }

  @override
  StumpEntryListProvider getProviderOverride(
    covariant StumpEntryListProvider provider,
  ) {
    return call(
      provider.stumpId,
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
  String? get name => r'stumpEntryListProvider';
}

/// See also [stumpEntryList].
class StumpEntryListProvider
    extends AutoDisposeFutureProvider<List<StumpEntryData>> {
  /// See also [stumpEntryList].
  StumpEntryListProvider(
    int stumpId,
  ) : this._internal(
          (ref) => stumpEntryList(
            ref as StumpEntryListRef,
            stumpId,
          ),
          from: stumpEntryListProvider,
          name: r'stumpEntryListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stumpEntryListHash,
          dependencies: StumpEntryListFamily._dependencies,
          allTransitiveDependencies:
              StumpEntryListFamily._allTransitiveDependencies,
          stumpId: stumpId,
        );

  StumpEntryListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stumpId,
  }) : super.internal();

  final int stumpId;

  @override
  Override overrideWith(
    FutureOr<List<StumpEntryData>> Function(StumpEntryListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StumpEntryListProvider._internal(
        (ref) => create(ref as StumpEntryListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stumpId: stumpId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<StumpEntryData>> createElement() {
    return _StumpEntryListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StumpEntryListProvider && other.stumpId == stumpId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stumpId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StumpEntryListRef on AutoDisposeFutureProviderRef<List<StumpEntryData>> {
  /// The parameter `stumpId` of this provider.
  int get stumpId;
}

class _StumpEntryListProviderElement
    extends AutoDisposeFutureProviderElement<List<StumpEntryData>>
    with StumpEntryListRef {
  _StumpEntryListProviderElement(super.provider);

  @override
  int get stumpId => (origin as StumpEntryListProvider).stumpId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
