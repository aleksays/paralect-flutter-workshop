# 💡 Riverpod Tips & Tricks

## Performance Optimization

### 🚀 **Consumer Optimization**

```dart
// ❌ BAD: Wraps entire page
Consumer(
  builder: (context, ref, child) => Scaffold(
    appBar: AppBar(title: Text('Posts')),
    body: _buildBody(ref),
  ),
)

// ✅ GOOD: Only wraps dynamic content
Scaffold(
  appBar: AppBar(title: Text('Posts')),
  body: Consumer(
    builder: (context, ref, child) => _buildBody(ref),
  ),
)
```

### 🎯 **Selective Rebuilding with select**

```dart
// ✅ Use select to listen to specific properties
Consumer(
  builder: (context, ref, child) {
    final posts = ref.watch(postsProvider.select((state) => state.posts));
    return PostsList(posts);
  },
)

// ✅ Multiple selectors
Consumer(
  builder: (context, ref, child) {
    final posts = ref.watch(postsProvider.select((state) => state.posts));
    final isLoading = ref.watch(postsProvider.select((state) => state.isLoading));
    
    if (isLoading) return LoadingWidget();
    return PostsList(posts);
  },
)
```

### ⚡ **Use child parameter for static widgets**

```dart
Consumer(
  builder: (context, ref, child) => Column(
    children: [
      child!, // Static widget, won't rebuild
      Text('Posts count: ${ref.watch(postsProvider).posts.length}'),
    ],
  ),
  child: Container(
    padding: EdgeInsets.all(16),
    child: Text('This widget never rebuilds'),
  ),
)
```

## Best Practices

### 🏗️ **Provider Structure**

```dart
// ✅ Use StateNotifier for complex state
class PostsState {
  final List<Post> posts;
  final Post? selectedPost;
  final bool isLoading;
  final String? error;

  const PostsState({
    this.posts = const [],
    this.selectedPost,
    this.isLoading = false,
    this.error,
  });

  PostsState copyWith({
    List<Post>? posts,
    Post? selectedPost,
    bool? isLoading,
    String? error,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      selectedPost: selectedPost ?? this.selectedPost,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get hasError => error != null;
  bool get hasPosts => posts.isNotEmpty;
}

class PostsNotifier extends StateNotifier<PostsState> {
  final GetPosts _getPosts;
  final GetPost _getPost;

  PostsNotifier({
    required GetPosts getPosts,
    required GetPost getPost,
  }) : _getPosts = getPosts,
       _getPost = getPost,
       super(const PostsState());

  Future<void> loadPosts() async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _getPosts(NoParams());
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (posts) => state = state.copyWith(
        isLoading: false,
        posts: posts,
        error: null,
      ),
    );
  }

  Future<void> getPost(int id) async {
    final result = await _getPost(Params(id));
    
    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (post) => state = state.copyWith(selectedPost: post),
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider definition
final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  return PostsNotifier(
    getPosts: ref.read(getPostsProvider),
    getPost: ref.read(getPostProvider),
  );
});
```

### 🎨 **Provider Types and Usage**

```dart
// ✅ Different provider types for different use cases

// Simple value provider
final counterProvider = StateProvider<int>((ref) => 0);

// Future provider for async operations
final postsProvider = FutureProvider<List<Post>>((ref) async {
  final repository = ref.read(postsRepositoryProvider);
  return repository.getPosts();
});

// Stream provider for real-time data
final messagesProvider = StreamProvider<List<Message>>((ref) {
  final repository = ref.read(messagesRepositoryProvider);
  return repository.getMessagesStream();
});

// Family provider for parameterized providers
final postProvider = FutureProvider.family<Post, int>((ref, id) async {
  final repository = ref.read(postsRepositoryProvider);
  return repository.getPost(id);
});

// AutoDispose for automatic cleanup
final searchProvider = FutureProvider.autoDispose.family<List<Post>, String>((ref, query) async {
  final repository = ref.read(postsRepositoryProvider);
  return repository.searchPosts(query);
});
```

### 🔄 **State Management Patterns**

```dart
// ✅ Use sealed classes for better type safety (Dart 3.0+)
sealed class AsyncState<T> {
  const AsyncState();
}

class AsyncLoading<T> extends AsyncState<T> {
  const AsyncLoading();
}

class AsyncData<T> extends AsyncState<T> {
  final T data;
  const AsyncData(this.data);
}

class AsyncError<T> extends AsyncState<T> {
  final Object error;
  final StackTrace stackTrace;
  const AsyncError(this.error, this.stackTrace);
}

// Usage in StateNotifier
class PostsNotifier extends StateNotifier<AsyncState<List<Post>>> {
  PostsNotifier() : super(const AsyncLoading());

  Future<void> loadPosts() async {
    state = const AsyncLoading();
    
    try {
      final posts = await _repository.getPosts();
      state = AsyncData(posts);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
```

## Advanced Techniques

### 🎭 **Provider Listening and Side Effects**

```dart
// ✅ Use ref.listen for side effects
class PostsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for errors and show snackbars
    ref.listen<PostsState>(postsProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => ref.read(postsProvider.notifier).loadPosts(),
            ),
          ),
        );
      }
    });

    final state = ref.watch(postsProvider);
    
    return Scaffold(
      body: switch (state) {
        PostsState(isLoading: true) => LoadingWidget(),
        PostsState(hasError: true) => ErrorWidget(state.error!),
        PostsState(hasPosts: true) => PostsList(state.posts),
        _ => EmptyWidget(),
      },
    );
  }
}
```

### 🔀 **Provider Dependencies**

```dart
// ✅ Provider dependencies and composition
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  final auth = ref.watch(authProvider);
  
  return PostsNotifier(
    authToken: auth.token,
    getPosts: ref.read(getPostsProvider),
  );
});

// Conditional provider based on auth state
final userPostsProvider = Provider<AsyncValue<List<Post>>>((ref) {
  final auth = ref.watch(authProvider);
  
  if (!auth.isAuthenticated) {
    return const AsyncValue.data([]);
  }
  
  return ref.watch(postsProvider);
});
```

### 🔧 **Custom Providers and Modifiers**

```dart
// ✅ Custom provider with keepAlive
final cacheProvider = Provider.autoDispose<CacheManager>((ref) {
  final cache = CacheManager();
  
  // Keep alive for 5 minutes after last use
  final timer = Timer(Duration(minutes: 5), () {
    ref.invalidateSelf();
  });
  
  ref.onDispose(() {
    timer.cancel();
    cache.dispose();
  });
  
  return cache;
});

// ✅ Family provider with custom equality
final postProvider = FutureProvider.autoDispose.family<Post, int>(
  (ref, id) async {
    final repository = ref.read(postsRepositoryProvider);
    return repository.getPost(id);
  },
);

// Keep specific instances alive
final keepAlivePostProvider = Provider.family<Post?, int>((ref, id) {
  final asyncPost = ref.watch(postProvider(id));
  
  return asyncPost.when(
    data: (post) {
      // Keep this instance alive
      ref.keepAlive();
      return post;
    },
    loading: () => null,
    error: (_, __) => null,
  );
});
```

## Common Mistakes

### ❌ **Don't Read Providers in build() Without watch**

```dart
// ❌ BAD: Reading without watching
class PostsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This won't rebuild when state changes!
    final posts = ref.read(postsProvider).posts;
    
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => PostCard(posts[index]),
    );
  }
}

// ✅ GOOD: Use watch to listen to changes
class PostsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postsProvider);
    
    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, index) => PostCard(state.posts[index]),
    );
  }
}
```

### ❌ **Don't Mutate State Directly**

```dart
// ❌ BAD: Mutating state directly
class PostsNotifier extends StateNotifier<List<Post>> {
  PostsNotifier() : super([]);

  void addPost(Post post) {
    state.add(post); // DON'T MUTATE!
    // This won't trigger rebuilds
  }
}

// ✅ GOOD: Create new state instances
class PostsNotifier extends StateNotifier<List<Post>> {
  PostsNotifier() : super([]);

  void addPost(Post post) {
    state = [...state, post]; // Create new list
  }

  void removePost(int id) {
    state = state.where((post) => post.id != id).toList();
  }

  void updatePost(Post updatedPost) {
    state = state.map((post) {
      return post.id == updatedPost.id ? updatedPost : post;
    }).toList();
  }
}
```

### ❌ **Don't Forget AutoDispose for Temporary Data**

```dart
// ❌ BAD: No auto dispose for search results
final searchProvider = FutureProvider.family<List<Post>, String>((ref, query) async {
  final repository = ref.read(postsRepositoryProvider);
  return repository.searchPosts(query);
});

// ✅ GOOD: Use autoDispose for temporary data
final searchProvider = FutureProvider.autoDispose.family<List<Post>, String>((ref, query) async {
  final repository = ref.read(postsRepositoryProvider);
  return repository.searchPosts(query);
});
```

## Testing

### 🧪 **Riverpod Testing**

```dart
group('PostsNotifier', () {
  late ProviderContainer container;
  late MockGetPosts mockGetPosts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    container = ProviderContainer(
      overrides: [
        getPostsProvider.overrideWithValue(mockGetPosts),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('should load posts successfully', () async {
    // Arrange
    when(() => mockGetPosts(any()))
        .thenAnswer((_) async => Right(testPosts));

    // Act
    await container.read(postsProvider.notifier).loadPosts();

    // Assert
    final state = container.read(postsProvider);
    expect(state.posts, testPosts);
    expect(state.isLoading, false);
    expect(state.hasError, false);
  });

  test('should handle error when loading posts fails', () async {
    // Arrange
    when(() => mockGetPosts(any()))
        .thenAnswer((_) async => Left(ServerFailure('Server Error')));

    // Act
    await container.read(postsProvider.notifier).loadPosts();

    // Assert
    final state = container.read(postsProvider);
    expect(state.hasError, true);
    expect(state.error, 'Server Error');
    expect(state.posts, isEmpty);
  });
});
```

### 🎯 **Widget Testing with Riverpod**

```dart
testWidgets('displays posts when loaded', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        postsProvider.overrideWith((ref) => PostsNotifier()
          ..state = PostsState(posts: testPosts)),
      ],
      child: MaterialApp(home: PostsPage()),
    ),
  );
  
  expect(find.text(testPosts.first.title), findsOneWidget);
});

// Testing with AsyncValue
testWidgets('displays loading state', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        postsProvider.overrideWith(
          (ref) => const AsyncValue<List<Post>>.loading(),
        ),
      ],
      child: MaterialApp(home: PostsPage()),
    ),
  );
  
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

## Debugging

### 🔍 **Riverpod Debugging**

```dart
// ✅ Add logging with ProviderObserver
class LoggerProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    print('Provider ${provider.name ?? provider.runtimeType} was initialized with $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    print('Provider ${provider.name ?? provider.runtimeType} was disposed');
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('Provider ${provider.name ?? provider.runtimeType} updated from $previousValue to $newValue');
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    print('Provider ${provider.name ?? provider.runtimeType} failed with $error');
  }
}

void main() {
  runApp(
    ProviderScope(
      observers: [LoggerProviderObserver()],
      child: MyApp(),
    ),
  );
}
```

### 📱 **Riverpod DevTools**

```dart
// ✅ Enable Riverpod DevTools
// Add to pubspec.yaml:
// dev_dependencies:
//   riverpod_generator: ^2.0.0
//   riverpod_annotation: ^2.0.0

// Use riverpod_inspector for debugging
void main() {
  runApp(
    ProviderScope(
      observers: [
        if (kDebugMode) LoggerProviderObserver(),
      ],
      child: MyApp(),
    ),
  );
}
```

## Architecture Tips

### 🏗️ **Repository Pattern with Riverpod**

```dart
// ✅ Define repository providers
final postsRepositoryProvider = Provider<PostsRepository>((ref) {
  final dio = ref.read(dioProvider);
  return PostsRepositoryImpl(PostsRemoteDataSource(dio));
});

// ✅ Use case providers
final getPostsProvider = Provider<GetPosts>((ref) {
  final repository = ref.read(postsRepositoryProvider);
  return GetPosts(repository);
});

// ✅ State notifier with dependencies
final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  return PostsNotifier(
    getPosts: ref.read(getPostsProvider),
  );
});
```

### 🔗 **Provider Composition and Dependencies**

```dart
// ✅ Complex provider dependencies
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

final appProvider = Provider<AppState>((ref) {
  final user = ref.watch(userProvider);
  final settings = ref.watch(settingsProvider);
  
  return AppState(
    user: user,
    settings: settings,
    isReady: user.isLoggedIn && settings.isLoaded,
  );
});

// Conditional providers
final postsProvider = FutureProvider<List<Post>>((ref) async {
  final app = ref.watch(appProvider);
  
  if (!app.isReady) {
    throw Exception('App not ready');
  }
  
  final repository = ref.read(postsRepositoryProvider);
  return repository.getPosts();
});
```

## Performance Tips

### ⚡ **Lazy Loading and Pagination**

```dart
// ✅ Implement pagination with Riverpod
class PaginatedPostsNotifier extends StateNotifier<PaginatedState<Post>> {
  static const int _pageSize = 20;
  final PostsRepository _repository;

  PaginatedPostsNotifier(this._repository) : super(PaginatedState());

  Future<void> loadNextPage() async {
    if (state.isLoadingMore || !state.hasMoreData) return;

    final isFirstPage = state.items.isEmpty;
    
    state = state.copyWith(
      isLoading: isFirstPage,
      isLoadingMore: !isFirstPage,
    );

    try {
      final newPosts = await _repository.getPosts(
        page: state.currentPage + 1,
        limit: _pageSize,
      );

      final hasMoreData = newPosts.length == _pageSize;
      
      state = state.copyWith(
        items: [...state.items, ...newPosts],
        currentPage: state.currentPage + 1,
        hasMoreData: hasMoreData,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (error) {
      state = state.copyWith(
        error: error.toString(),
        isLoading: false,
        isLoadingMore: false,
      );
    }
  }
}

final paginatedPostsProvider = StateNotifierProvider<PaginatedPostsNotifier, PaginatedState<Post>>((ref) {
  final repository = ref.read(postsRepositoryProvider);
  return PaginatedPostsNotifier(repository);
});
```

### 🎯 **Memory Management and Caching**

```dart
// ✅ Implement smart caching
final postCacheProvider = Provider<PostCache>((ref) {
  return PostCache();
});

final postProvider = FutureProvider.family.autoDispose<Post, int>((ref, id) async {
  final cache = ref.read(postCacheProvider);
  
  // Check cache first
  final cachedPost = cache.get(id);
  if (cachedPost != null) {
    return cachedPost;
  }
  
  // Fetch from repository
  final repository = ref.read(postsRepositoryProvider);
  final post = await repository.getPost(id);
  
  // Cache the result
  cache.put(id, post);
  
  return post;
});

// Keep frequently accessed posts alive
final favoritePostsProvider = Provider<List<Post>>((ref) {
  final favoriteIds = ref.watch(favoritePostIdsProvider);
  
  return favoriteIds.map((id) {
    final asyncPost = ref.watch(postProvider(id));
    return asyncPost.when(
      data: (post) {
        ref.keepAlive(); // Keep alive for favorites
        return post;
      },
      loading: () => null,
      error: (_, __) => null,
    );
  }).whereType<Post>().toList();
});
```

### 🔄 **Optimistic Updates**

```dart
// ✅ Implement optimistic updates
class PostsNotifier extends StateNotifier<List<Post>> {
  final PostsRepository _repository;

  PostsNotifier(this._repository) : super([]);

  Future<void> likePost(int postId) async {
    // Optimistic update
    final optimisticState = state.map((post) {
      if (post.id == postId) {
        return post.copyWith(
          isLiked: !post.isLiked,
          likesCount: post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
        );
      }
      return post;
    }).toList();
    
    state = optimisticState;

    try {
      // Actual API call
      final updatedPost = await _repository.likePost(postId);
      
      // Update with real data
      state = state.map((post) {
        return post.id == postId ? updatedPost : post;
      }).toList();
    } catch (error) {
      // Revert optimistic update on error
      state = state.map((post) {
        if (post.id == postId) {
          return post.copyWith(
            isLiked: !post.isLiked,
            likesCount: post.isLiked ? post.likesCount + 1 : post.likesCount - 1,
          );
        }
        return post;
      }).toList();
      
      rethrow;
    }
  }
}
```

---

## 📚 Additional Resources

- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod Architecture](https://riverpod.dev/docs/concepts/reading)
- [Riverpod Best Practices](https://riverpod.dev/docs/concepts/modifiers/auto_dispose)
- [Testing with Riverpod](https://riverpod.dev/docs/cookbooks/testing)

---

**Remember**: Riverpod provides compile-time safety and excellent performance. Use it when you need type-safe, scalable state management with great DevTools support! 