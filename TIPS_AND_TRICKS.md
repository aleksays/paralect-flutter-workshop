# 💡 Provider Tips & Tricks

## Performance Optimization

### 🚀 **Consumer Optimization**

```dart
// ❌ BAD: Wraps entire page
Consumer<PostsProvider>(
  builder: (context, provider, child) => Scaffold(
    appBar: AppBar(title: Text('Posts')),
    body: _buildBody(provider),
  ),
)

// ✅ GOOD: Only wraps dynamic content
Scaffold(
  appBar: AppBar(title: Text('Posts')),
  body: Consumer<PostsProvider>(
    builder: (context, provider, child) => _buildBody(provider),
  ),
)
```

### 🎯 **Selective Rebuilding with Selector**

```dart
// ✅ Use Selector to listen to specific properties
Selector<PostsProvider, List<Post>>(
  selector: (context, provider) => provider.posts,
  builder: (context, posts, child) => PostsList(posts),
)

// ✅ Multiple properties
Selector<PostsProvider, ({List<Post> posts, bool isLoading})>(
  selector: (context, provider) => (
    posts: provider.posts,
    isLoading: provider.isLoading,
  ),
  builder: (context, data, child) {
    if (data.isLoading) return LoadingWidget();
    return PostsList(data.posts);
  },
)
```

### ⚡ **Use child parameter for static widgets**

```dart
Consumer<PostsProvider>(
  builder: (context, provider, child) => Column(
    children: [
      child!, // Static widget, won't rebuild
      Text('Posts count: ${provider.posts.length}'),
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
class PostsProvider extends ChangeNotifier {
  final GetPosts _getPosts;
  final GetPost _getPost;

  PostsProvider({
    required GetPosts getPosts,
    required GetPost getPost,
  }) : _getPosts = getPosts,
       _getPost = getPost;

  List<Post> _posts = [];
  Post? _selectedPost;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Post> get posts => List.unmodifiable(_posts);
  Post? get selectedPost => _selectedPost;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get hasPosts => _posts.isNotEmpty;

  // Methods
  Future<void> loadPosts() async {
    _setLoading(true);
    _clearError();
    
    final result = await _getPosts(NoParams());
    
    result.fold(
      (failure) => _setError(failure.message),
      (posts) => _setPosts(posts),
    );
    
    _setLoading(false);
  }

  // Private helpers
  void _setPosts(List<Post> posts) {
    _posts = posts;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
```

### 🎨 **Proper Provider Setup**

```dart
// ✅ Use MultiProvider for multiple providers
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => sl<PostsProvider>()),
    ChangeNotifierProvider(create: (_) => sl<UserProvider>()),
    Provider(create: (_) => sl<AuthService>()),
  ],
  child: MyApp(),
)

// ✅ Use ProxyProvider for dependencies
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProxyProvider<AuthProvider, PostsProvider>(
      create: (_) => PostsProvider(),
      update: (_, auth, posts) => posts!..updateAuth(auth),
    ),
  ],
  child: MyApp(),
)
```

### 🔄 **State Management Patterns**

```dart
// ✅ Use enums for state
enum LoadingState { initial, loading, loaded, error }

class PostsProvider extends ChangeNotifier {
  LoadingState _state = LoadingState.initial;
  List<Post> _posts = [];
  String? _error;

  LoadingState get state => _state;
  List<Post> get posts => List.unmodifiable(_posts);
  String? get error => _error;

  bool get isInitial => _state == LoadingState.initial;
  bool get isLoading => _state == LoadingState.loading;
  bool get isLoaded => _state == LoadingState.loaded;
  bool get hasError => _state == LoadingState.error;

  Future<void> loadPosts() async {
    _setState(LoadingState.loading);
    
    try {
      final result = await _getPosts(NoParams());
      result.fold(
        (failure) {
          _error = failure.message;
          _setState(LoadingState.error);
        },
        (posts) {
          _posts = posts;
          _error = null;
          _setState(LoadingState.loaded);
        },
      );
    } catch (e) {
      _error = e.toString();
      _setState(LoadingState.error);
    }
  }

  void _setState(LoadingState newState) {
    _state = newState;
    notifyListeners();
  }
}
```

## Advanced Techniques

### 🎭 **Custom Provider Widgets**

```dart
// ✅ Create custom provider widgets for complex logic
class PostsConsumer extends StatelessWidget {
  final Widget Function(BuildContext, List<Post>) onLoaded;
  final Widget Function(BuildContext, String)? onError;
  final Widget Function(BuildContext)? onLoading;

  const PostsConsumer({
    Key? key,
    required this.onLoaded,
    this.onError,
    this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return onLoading?.call(context) ?? LoadingWidget();
        }
        
        if (provider.hasError) {
          return onError?.call(context, provider.error!) ?? 
                 ErrorWidget(provider.error!);
        }
        
        return onLoaded(context, provider.posts);
      },
    );
  }
}

// Usage
PostsConsumer(
  onLoaded: (context, posts) => PostsList(posts),
  onError: (context, error) => ErrorView(error),
  onLoading: (context) => CustomLoadingWidget(),
)
```

### 🔀 **Provider Communication**

```dart
// ✅ Provider-to-Provider communication
class UserProvider extends ChangeNotifier {
  final PostsProvider _postsProvider;
  
  UserProvider(this._postsProvider);

  Future<void> logout() async {
    // Clear user data
    _clearUserData();
    
    // Clear posts data
    _postsProvider.clearPosts();
    
    notifyListeners();
  }
}

// Setup with ProxyProvider
ChangeNotifierProxyProvider<UserProvider, PostsProvider>(
  create: (_) => PostsProvider(),
  update: (_, userProvider, postsProvider) {
    return postsProvider!..setUserProvider(userProvider);
  },
)
```

### 🔧 **Custom Change Notifiers**

```dart
// ✅ Custom ValueNotifier for simple state
class CounterNotifier extends ValueNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }

  void reset() {
    value = 0;
  }
}

// Usage
ValueListenableBuilder<int>(
  valueListenable: counterNotifier,
  builder: (context, count, child) => Text('Count: $count'),
)
```

## Common Mistakes

### ❌ **Don't Call notifyListeners() Excessively**

```dart
// ❌ BAD: Too many notifications
class PostsProvider extends ChangeNotifier {
  void updatePost(Post post) {
    _posts[_posts.indexWhere((p) => p.id == post.id)] = post;
    notifyListeners(); // Called for each update
  }
  
  void updateMultiplePosts(List<Post> posts) {
    for (final post in posts) {
      updatePost(post); // Calls notifyListeners() multiple times!
    }
  }
}

// ✅ GOOD: Batch updates
class PostsProvider extends ChangeNotifier {
  void updatePosts(List<Post> updatedPosts) {
    for (final post in updatedPosts) {
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = post;
      }
    }
    notifyListeners(); // Called once after all updates
  }
}
```

### ❌ **Don't Use Provider in initState()**

```dart
// ❌ BAD: Provider not ready in initState
class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  void initState() {
    super.initState();
    // DON'T DO THIS - Provider not ready yet
    Provider.of<PostsProvider>(context, listen: false).loadPosts();
  }
}

// ✅ GOOD: Use didChangeDependencies or WidgetsBinding
class _PostsListState extends State<PostsList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostsProvider>(context, listen: false).loadPosts();
    });
  }
}
```

### ❌ **Don't Forget to Dispose Resources**

```dart
// ✅ Always dispose resources
class PostsProvider extends ChangeNotifier {
  StreamSubscription? _subscription;
  Timer? _timer;

  @override
  void dispose() {
    _subscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}
```

## Testing

### 🧪 **Provider Testing**

```dart
group('PostsProvider', () {
  late PostsProvider provider;
  late MockGetPosts mockGetPosts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    provider = PostsProvider(getPosts: mockGetPosts);
  });

  tearDown(() {
    provider.dispose();
  });

  test('should load posts successfully', () async {
    // Arrange
    when(() => mockGetPosts(any()))
        .thenAnswer((_) async => Right(testPosts));

    // Act
    await provider.loadPosts();

    // Assert
    expect(provider.isLoaded, true);
    expect(provider.posts, testPosts);
    expect(provider.hasError, false);
  });

  test('should handle error when loading posts fails', () async {
    // Arrange
    when(() => mockGetPosts(any()))
        .thenAnswer((_) async => Left(ServerFailure('Server Error')));

    // Act
    await provider.loadPosts();

    // Assert
    expect(provider.hasError, true);
    expect(provider.error, 'Server Error');
    expect(provider.posts, isEmpty);
  });

  test('should notify listeners when state changes', () {
    // Arrange
    bool notified = false;
    provider.addListener(() => notified = true);

    // Act
    provider.clearPosts();

    // Assert
    expect(notified, true);
  });
});
```

### 🎯 **Widget Testing with Provider**

```dart
testWidgets('displays posts when loaded', (tester) async {
  final mockProvider = MockPostsProvider();
  
  when(() => mockProvider.isLoaded).thenReturn(true);
  when(() => mockProvider.posts).thenReturn(testPosts);
  when(() => mockProvider.isLoading).thenReturn(false);
  when(() => mockProvider.hasError).thenReturn(false);
  
  await tester.pumpWidget(
    MaterialApp(
      home: ChangeNotifierProvider<PostsProvider>.value(
        value: mockProvider,
        child: PostsPage(),
      ),
    ),
  );
  
  expect(find.text(testPosts.first.title), findsOneWidget);
});
```

## Debugging

### 🔍 **Provider Debugging**

```dart
// ✅ Add logging to providers
class PostsProvider extends ChangeNotifier {
  static const _logger = 'PostsProvider';

  Future<void> loadPosts() async {
    debugPrint('$_logger: Loading posts...');
    
    _setLoading(true);
    
    try {
      final result = await _getPosts(NoParams());
      
      result.fold(
        (failure) {
          debugPrint('$_logger: Error loading posts: ${failure.message}');
          _setError(failure.message);
        },
        (posts) {
          debugPrint('$_logger: Loaded ${posts.length} posts');
          _setPosts(posts);
        },
      );
    } catch (e) {
      debugPrint('$_logger: Exception: $e');
      _setError(e.toString());
    }
    
    _setLoading(false);
  }
}
```

### 📱 **Provider DevTools**

```dart
// ✅ Use Provider DevTools extension
// Add to pubspec.yaml:
// dev_dependencies:
//   provider: ^6.0.0
//   flutter_devtools: ^2.0.0

// Enable in main.dart
void main() {
  runApp(
    DevToolsProvider(
      child: MyApp(),
    ),
  );
}
```

## Architecture Tips

### 🏗️ **Repository Pattern with Provider**

```dart
// ✅ Keep business logic in Provider, data access in Repository
class PostsProvider extends ChangeNotifier {
  final PostsRepository _repository;

  PostsProvider(this._repository);

  Future<void> loadPosts() async {
    _setLoading(true);
    
    try {
      final posts = await _repository.getPosts();
      _setPosts(posts);
    } catch (e) {
      _setError(e.toString());
    }
    
    _setLoading(false);
  }
}
```

### 🔗 **Provider Composition**

```dart
// ✅ Compose providers for complex state
class AppProvider extends ChangeNotifier {
  final UserProvider _userProvider;
  final PostsProvider _postsProvider;
  final SettingsProvider _settingsProvider;

  AppProvider(
    this._userProvider,
    this._postsProvider,
    this._settingsProvider,
  ) {
    _userProvider.addListener(_onUserChanged);
    _settingsProvider.addListener(_onSettingsChanged);
  }

  void _onUserChanged() {
    if (!_userProvider.isLoggedIn) {
      _postsProvider.clearPosts();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _userProvider.removeListener(_onUserChanged);
    _settingsProvider.removeListener(_onSettingsChanged);
    super.dispose();
  }
}
```

## Performance Tips

### ⚡ **Lazy Loading**

```dart
// ✅ Implement lazy loading for large datasets
class PostsProvider extends ChangeNotifier {
  static const int _pageSize = 20;
  
  List<Post> _posts = [];
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  int _currentPage = 0;

  Future<void> loadMorePosts() async {
    if (_isLoadingMore || !_hasMoreData) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final newPosts = await _repository.getPosts(
        page: _currentPage + 1,
        limit: _pageSize,
      );

      if (newPosts.length < _pageSize) {
        _hasMoreData = false;
      }

      _posts.addAll(newPosts);
      _currentPage++;
    } catch (e) {
      _setError(e.toString());
    }

    _isLoadingMore = false;
    notifyListeners();
  }
}
```

### 🎯 **Memory Management**

```dart
// ✅ Implement proper memory management
class PostsProvider extends ChangeNotifier {
  static const int _maxCachedPosts = 100;
  
  final Map<int, Post> _postCache = {};

  void _addToCache(Post post) {
    if (_postCache.length >= _maxCachedPosts) {
      // Remove oldest entries
      final oldestKey = _postCache.keys.first;
      _postCache.remove(oldestKey);
    }
    _postCache[post.id] = post;
  }

  Post? getCachedPost(int id) => _postCache[id];
}
```

---

## 📚 Additional Resources

- [Provider Documentation](https://pub.dev/packages/provider)
- [Provider Architecture](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)
- [Provider Best Practices](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#provider)
- [Testing Provider](https://flutter.dev/docs/cookbook/testing/unit/mocking)

---

**Remember**: Provider is simple and powerful for most use cases. Use it when you need straightforward state management without the complexity of BLoC! 