# 💡 BLoC Tips & Tricks

## Performance Optimization

### 🚀 **BlocBuilder Optimization**

```dart
// ❌ BAD: Wraps entire page
BlocBuilder<PostsBloc, PostsState>(
  builder: (context, state) => Scaffold(
    appBar: AppBar(title: Text('Posts')),
    body: _buildBody(state),
  ),
)

// ✅ GOOD: Only wraps dynamic content
Scaffold(
  appBar: AppBar(title: Text('Posts')),
  body: BlocBuilder<PostsBloc, PostsState>(
    builder: (context, state) => _buildBody(state),
  ),
)
```

### 🎯 **Selective Rebuilding**

```dart
// ✅ Use buildWhen to control rebuilds
BlocBuilder<PostsBloc, PostsState>(
  buildWhen: (previous, current) {
    // Only rebuild when posts actually change
    return previous != current && current is PostsLoaded;
  },
  builder: (context, state) => PostsList(),
)
```

### ⚡ **Use BlocSelector for Specific Data**

```dart
// ✅ Only rebuild when specific field changes
BlocSelector<PostsBloc, PostsState, List<Post>>(
  selector: (state) {
    if (state is PostsLoaded) return state.posts;
    return [];
  },
  builder: (context, posts) => PostsList(posts),
)
```

## Best Practices

### 🏗️ **BLoC Structure**

```dart
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts _getPosts;
  final GetPost _getPost;

  PostsBloc({
    required GetPosts getPosts,
    required GetPost getPost,
  }) : _getPosts = getPosts,
       _getPost = getPost,
       super(PostsInitial()) {
    on<GetPostsEvent>(_onGetPosts);
    on<GetPostEvent>(_onGetPost);
  }

  Future<void> _onGetPosts(
    GetPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());
    
    final result = await _getPosts(NoParams());
    
    result.fold(
      (failure) => emit(PostsError(failure.message)),
      (posts) => emit(PostsLoaded(posts)),
    );
  }
}
```

### 🎨 **State Management Patterns**

```dart
// ✅ Use sealed classes for better type safety (Dart 3.0+)
sealed class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoading extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoaded extends PostsState {
  final List<Post> posts;
  
  const PostsLoaded(this.posts);
  
  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {
  final String message;
  
  const PostsError(this.message);
  
  @override
  List<Object> get props => [message];
}
```

### 🔄 **Event Handling**

```dart
// ✅ Use meaningful event names
abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class LoadPostsRequested extends PostsEvent {
  @override
  List<Object> get props => [];
}

class RefreshPostsRequested extends PostsEvent {
  @override
  List<Object> get props => [];
}

class PostDetailsRequested extends PostsEvent {
  final int postId;
  
  const PostDetailsRequested(this.postId);
  
  @override
  List<Object> get props => [postId];
}
```

## Advanced Techniques

### 🎭 **BlocListener for Side Effects**

```dart
BlocListener<PostsBloc, PostsState>(
  listener: (context, state) {
    if (state is PostsError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () => context.read<PostsBloc>().add(LoadPostsRequested()),
          ),
        ),
      );
    }
  },
  child: YourWidget(),
)
```

### 🔀 **BlocConsumer for Both Building and Listening**

```dart
BlocConsumer<PostsBloc, PostsState>(
  listener: (context, state) {
    // Handle side effects (navigation, snackbars, etc.)
    if (state is PostsError) {
      _showErrorDialog(context, state.message);
    }
  },
  builder: (context, state) {
    // Build UI based on state
    return switch (state) {
      PostsInitial() => _buildInitial(),
      PostsLoading() => _buildLoading(),
      PostsLoaded() => _buildLoaded(state.posts),
      PostsError() => _buildError(),
    };
  },
)
```

### 🔧 **Transform Events**

```dart
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<SearchPostsEvent>(
      _onSearchPosts,
      transformer: debounce(Duration(milliseconds: 300)),
    );
  }
}

// Custom transformer for debouncing
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
```

## Common Mistakes

### ❌ **Don't Create BLoCs in build()**

```dart
// ❌ BAD: Creates new BLoC on every rebuild
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc()..add(LoadPostsRequested()),
      child: PostsList(),
    );
  }
}

// ✅ GOOD: Use dependency injection
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostsBloc>()..add(LoadPostsRequested()),
      child: PostsList(),
    );
  }
}
```

### ❌ **Don't Add Events in build()**

```dart
// ❌ BAD: Adds event on every rebuild
class PostsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PostsBloc>().add(LoadPostsRequested()); // DON'T DO THIS
    
    return BlocBuilder<PostsBloc, PostsState>(...);
  }
}

// ✅ GOOD: Add events in initState or user interactions
class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(LoadPostsRequested());
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(...);
  }
}
```

### ❌ **Don't Mutate State Objects**

```dart
// ❌ BAD: Mutating existing state
class PostsLoaded extends PostsState {
  final List<Post> posts;
  
  PostsLoaded(this.posts);
  
  void addPost(Post post) {
    posts.add(post); // DON'T MUTATE!
  }
}

// ✅ GOOD: Create new state instances
class PostsLoaded extends PostsState {
  final List<Post> posts;
  
  const PostsLoaded(this.posts);
  
  PostsLoaded copyWith({List<Post>? posts}) {
    return PostsLoaded(posts ?? this.posts);
  }
  
  PostsLoaded addPost(Post post) {
    return PostsLoaded([...posts, post]);
  }
}
```

## Testing

### 🧪 **BLoC Testing**

```dart
group('PostsBloc', () {
  late PostsBloc postsBloc;
  late MockGetPosts mockGetPosts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    postsBloc = PostsBloc(getPosts: mockGetPosts);
  });

  tearDown(() {
    postsBloc.close();
  });

  blocTest<PostsBloc, PostsState>(
    'emits [PostsLoading, PostsLoaded] when LoadPostsRequested succeeds',
    build: () => postsBloc,
    act: (bloc) => bloc.add(LoadPostsRequested()),
    expect: () => [
      PostsLoading(),
      PostsLoaded(testPosts),
    ],
    verify: (_) {
      verify(() => mockGetPosts(NoParams())).called(1);
    },
  );

  blocTest<PostsBloc, PostsState>(
    'emits [PostsLoading, PostsError] when LoadPostsRequested fails',
    build: () => postsBloc,
    setUp: () {
      when(() => mockGetPosts(any()))
          .thenAnswer((_) async => Left(ServerFailure('Server Error')));
    },
    act: (bloc) => bloc.add(LoadPostsRequested()),
    expect: () => [
      PostsLoading(),
      PostsError('Server Error'),
    ],
  );
});
```

### 🎯 **Widget Testing with BLoC**

```dart
testWidgets('displays posts when PostsLoaded', (tester) async {
  final mockBloc = MockPostsBloc();
  
  when(() => mockBloc.state).thenReturn(PostsLoaded(testPosts));
  
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<PostsBloc>.value(
        value: mockBloc,
        child: PostsPage(),
      ),
    ),
  );
  
  expect(find.text(testPosts.first.title), findsOneWidget);
});
```

## Debugging

### 🔍 **BlocObserver for Debugging**

```dart
class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(BlocBase bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(BlocBase bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}
```

### 📱 **Using Flutter DevTools**

1. **Enable BLoC Inspector** in Flutter DevTools
2. **Monitor state changes** in real-time
3. **Replay events** for debugging
4. **Track performance** issues

## Architecture Tips

### 🏗️ **Repository Pattern with BLoC**

```dart
// ✅ Keep business logic in BLoC, data access in Repository
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _repository;

  PostsBloc(this._repository) : super(PostsInitial()) {
    on<LoadPostsRequested>(_onLoadPosts);
  }

  Future<void> _onLoadPosts(
    LoadPostsRequested event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());
    
    try {
      final posts = await _repository.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
```

### 🔗 **BLoC Communication**

```dart
// ✅ Use events for BLoC-to-BLoC communication
class UserBloc extends Bloc<UserEvent, UserState> {
  final PostsBloc _postsBloc;

  UserBloc(this._postsBloc) : super(UserInitial()) {
    on<UserLoggedOut>(_onUserLoggedOut);
  }

  Future<void> _onUserLoggedOut(
    UserLoggedOut event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoggedOutState());
    
    // Trigger posts cleanup
    _postsBloc.add(ClearPostsRequested());
  }
}
```

---

## 📚 Additional Resources

- [BLoC Library Documentation](https://bloclibrary.dev/)
- [BLoC Architecture Tutorial](https://bloclibrary.dev/tutorials/flutter-counter/)
- [Testing BLoCs](https://bloclibrary.dev/testing/)
- [BLoC Best Practices](https://bloclibrary.dev/bloc-concepts/)

---

**Remember**: BLoC is powerful but comes with complexity. Use it when you need predictable state management and clear separation of business logic! 