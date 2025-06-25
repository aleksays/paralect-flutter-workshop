// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPostsHash() => r'16711ea577e78e27dbda2762a4db59aaee6c8ec1';

/// See also [getPosts].
@ProviderFor(getPosts)
final getPostsProvider = AutoDisposeProvider<GetPosts>.internal(
  getPosts,
  name: r'getPostsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPostsRef = AutoDisposeProviderRef<GetPosts>;
String _$getPostHash() => r'aeac7a1152dbc48a2c7bc95b39f2882fa22de407';

/// See also [getPost].
@ProviderFor(getPost)
final getPostProvider = AutoDisposeProvider<GetPost>.internal(
  getPost,
  name: r'getPostProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPostHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPostRef = AutoDisposeProviderRef<GetPost>;
String _$postsHash() => r'e59af838cdeedae822725b3999dbfbef114a01b5';

/// See also [posts].
@ProviderFor(posts)
final postsProvider = AutoDisposeFutureProvider<List<Post>>.internal(
  posts,
  name: r'postsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$postsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PostsRef = AutoDisposeFutureProviderRef<List<Post>>;
String _$postHash() => r'4b6e47c48c565722b2b5e2cf4699a40ec5e003c6';

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

/// See also [post].
@ProviderFor(post)
const postProvider = PostFamily();

/// See also [post].
class PostFamily extends Family<AsyncValue<Post>> {
  /// See also [post].
  const PostFamily();

  /// See also [post].
  PostProvider call(int id) {
    return PostProvider(id);
  }

  @override
  PostProvider getProviderOverride(covariant PostProvider provider) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postProvider';
}

/// See also [post].
class PostProvider extends AutoDisposeFutureProvider<Post> {
  /// See also [post].
  PostProvider(int id)
    : this._internal(
        (ref) => post(ref as PostRef, id),
        from: postProvider,
        name: r'postProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$postHash,
        dependencies: PostFamily._dependencies,
        allTransitiveDependencies: PostFamily._allTransitiveDependencies,
        id: id,
      );

  PostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(FutureOr<Post> Function(PostRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: PostProvider._internal(
        (ref) => create(ref as PostRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Post> createElement() {
    return _PostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostRef on AutoDisposeFutureProviderRef<Post> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PostProviderElement extends AutoDisposeFutureProviderElement<Post>
    with PostRef {
  _PostProviderElement(super.provider);

  @override
  int get id => (origin as PostProvider).id;
}

String _$postsNotifierHash() => r'14f49a788932f92fe562221d5268fc12aa3e7224';

/// See also [PostsNotifier].
@ProviderFor(PostsNotifier)
final postsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<PostsNotifier, List<Post>>.internal(
      PostsNotifier.new,
      name: r'postsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$postsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PostsNotifier = AutoDisposeAsyncNotifier<List<Post>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
