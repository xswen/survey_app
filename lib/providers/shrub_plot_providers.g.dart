// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shrub_plot_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shrubEntryListHash() => r'361415a49d14fed5bbb12efb2a91f8e7650f065c';

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

/// See also [shrubEntryList].
@ProviderFor(shrubEntryList)
const shrubEntryListProvider = ShrubEntryListFamily();

/// See also [shrubEntryList].
class ShrubEntryListFamily
    extends Family<AsyncValue<List<ShrubListEntryData>>> {
  /// See also [shrubEntryList].
  const ShrubEntryListFamily();

  /// See also [shrubEntryList].
  ShrubEntryListProvider call(
    int shrubId,
  ) {
    return ShrubEntryListProvider(
      shrubId,
    );
  }

  @override
  ShrubEntryListProvider getProviderOverride(
    covariant ShrubEntryListProvider provider,
  ) {
    return call(
      provider.shrubId,
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
  String? get name => r'shrubEntryListProvider';
}

/// See also [shrubEntryList].
class ShrubEntryListProvider
    extends AutoDisposeFutureProvider<List<ShrubListEntryData>> {
  /// See also [shrubEntryList].
  ShrubEntryListProvider(
    int shrubId,
  ) : this._internal(
          (ref) => shrubEntryList(
            ref as ShrubEntryListRef,
            shrubId,
          ),
          from: shrubEntryListProvider,
          name: r'shrubEntryListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shrubEntryListHash,
          dependencies: ShrubEntryListFamily._dependencies,
          allTransitiveDependencies:
              ShrubEntryListFamily._allTransitiveDependencies,
          shrubId: shrubId,
        );

  ShrubEntryListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.shrubId,
  }) : super.internal();

  final int shrubId;

  @override
  Override overrideWith(
    FutureOr<List<ShrubListEntryData>> Function(ShrubEntryListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ShrubEntryListProvider._internal(
        (ref) => create(ref as ShrubEntryListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        shrubId: shrubId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ShrubListEntryData>> createElement() {
    return _ShrubEntryListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShrubEntryListProvider && other.shrubId == shrubId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, shrubId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ShrubEntryListRef
    on AutoDisposeFutureProviderRef<List<ShrubListEntryData>> {
  /// The parameter `shrubId` of this provider.
  int get shrubId;
}

class _ShrubEntryListProviderElement
    extends AutoDisposeFutureProviderElement<List<ShrubListEntryData>>
    with ShrubEntryListRef {
  _ShrubEntryListProviderElement(super.provider);

  @override
  int get shrubId => (origin as ShrubEntryListProvider).shrubId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
