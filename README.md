# Flutter Workshop: REST API + Clean Architecture + Riverpod (Annotations)

## Branch: 06-rest-api-riverpod-annotations

This branch demonstrates REST API implementation using **Clean Architecture** and **Riverpod with annotations and code generation** for state management in a Flutter application.

## 🏗️ Architecture

The project is organized according to Clean Architecture principles with **Riverpod Annotations** as a modern, type-safe state management solution.

### 📁 Project Structure

```markdown
lib/
├── core/
│   ├── error/
│   │   └── failures.dart              # Base error classes
│   ├── injection/
│   │   └── injection_container.dart   # Dependency Injection
│   └── usecases/
│       └── usecase.dart               # Base UseCase interface
├── features/
│   └── posts/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── posts_remote_data_source.dart
│       │   ├── models/
│       │   │   ├── post_model.dart
│       │   │   └── post_model.g.dart
│       │   └── repositories/
│       │       └── posts_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── post.dart
│       │   ├── repositories/
│       │   │   └── posts_repository.dart
│       │   └── usecases/
│       │       ├── get_post.dart
│       │       └── get_posts.dart
│       └── presentation/
│           ├── providers/              # Riverpod Providers (with annotations)
│           │   ├── posts_providers.dart
│           │   └── posts_providers.g.dart
│           ├── pages/
│           │   ├── posts_riverpod_page.dart
│           │   └── post_riverpod_detail_page.dart
│           └── widgets/
│               ├── error_widget.dart
│               ├── loading_widget.dart
│               └── post_card.dart
└── main.dart
```

## 🔧 Technologies Used

### Core Dependencies

- **Flutter** - UI framework
- **Riverpod** - Modern state management with annotations
- **riverpod_annotation** - Annotations for code generation
- **Dio** - HTTP client for API requests
- **get_it** - Dependency injection
- **dartz** - Functional programming (Either)
- **equatable** - Object comparison
- **json_annotation** - JSON serialization

### Dev Dependencies

- **riverpod_generator** - Code generation for Riverpod
- **build_runner** - Build system

## 🏛️ Riverpod Annotations State Management

### 📊 Generated Providers

The `posts_providers.dart` file uses annotations for automatic code generation:

#### 1. Use Case Providers

```dart
@riverpod
GetPosts getPosts(GetPostsRef ref) {
  return di.sl<GetPosts>();
}

@riverpod
GetPost getPost(GetPostRef ref) {
  return di.sl<GetPost>();
}
```

#### 2. Simple FutureProvider

```dart
@riverpod
Future<List<Post>> posts(PostsRef ref) async {
  final getPosts = ref.watch(getPostsProvider);
  final result = await getPosts(const NoParams());
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (posts) => posts,
  );
}
```

#### 3. Family Provider (Auto-generated)

```dart
@riverpod
Future<Post> post(PostRef ref, int id) async {
  final getPost = ref.watch(getPostProvider);
  final result = await getPost(GetPostParams(id: id));
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (post) => post,
  );
}
```

#### 4. StateNotifier with Annotations

```dart
@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  Future<List<Post>> build() async {
    return _fetchPosts();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPosts());
  }
}
```

## 🎯 Riverpod Annotations Patterns

### ✅ ConsumerWidget with ref parameter

```dart
class PostsRiverpodPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);
    
    return postsAsync.when(
      loading: () => LoadingWidget(),
      data: (posts) => PostsList(posts),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

### ✅ Family providers usage

```dart
// Automatically generates postProvider.call(id)
final postAsync = ref.watch(postProvider(postId));

// Invalidate specific instance
ref.invalidate(postProvider(postId));
```

### ✅ Type-safe provider access

```dart
// Auto-generated with proper types
ref.watch(postsProvider);           // AsyncValue<List<Post>>
ref.watch(postProvider(1));        // AsyncValue<Post>
ref.read(postsNotifierProvider.notifier); // PostsNotifier
```

## 🎯 Annotations Benefits

### ✅ **Type Safety**

- All providers are type-safe at compile time
- No runtime errors from incorrect provider access
- Full IDE auto-completion support

### ✅ **Code Generation**

- No boilerplate code needed
- Automatic family provider generation
- Consistent API across all providers

### ✅ **Developer Experience**

- Better error messages
- Automatic parameter handling
- Built-in documentation

### ✅ **Performance**

- Optimized generated code
- Automatic dependency tracking
- Efficient rebuilds

## 📱 Features

- ✅ Load posts list from JSONPlaceholder API
- ✅ Detailed post view with family providers
- ✅ Loading state handling with AsyncValue
- ✅ Error handling with retry capability
- ✅ Clean Architecture with Riverpod annotations
- ✅ Type-safe state management
- ✅ Code generation for providers
- ✅ Automatic family provider handling

## 🚀 Getting Started

1.Install dependencies:

```bash
flutter pub get
```

2.Generate code for both JSON serialization and Riverpod:

```bash
dart run build_runner build
```

3.Watch for changes (optional):

```bash
dart run build_runner watch
```

4.Run the application:

```bash
flutter run
```

## 📝 Key Files

### Riverpod Annotations

- `lib/features/posts/presentation/providers/posts_providers.dart` - Annotated providers
- `lib/features/posts/presentation/providers/posts_providers.g.dart` - Generated code
- `lib/features/posts/presentation/pages/posts_riverpod_page.dart` - Main page
- `lib/features/posts/presentation/pages/post_riverpod_detail_page.dart` - Detail page

### Main Application

- `lib/main.dart` - ProviderScope setup
- `pubspec.yaml` - Dependencies including riverpod_annotation

## 🎯 Learning Objectives

After studying this branch you will understand:

1. ✅ **Riverpod Annotations (@riverpod)**
2. ✅ **Code generation with riverpod_generator**  
3. ✅ **Type-safe provider definitions**
4. ✅ **Automatic family provider generation**
5. ✅ **ConsumerWidget and WidgetRef**
6. ✅ **AsyncValue.when() pattern**
7. ✅ **StateNotifier with annotations**
8. ✅ **Provider invalidation and refresh**

## 🔄 Comparison: Manual vs Annotations

| Aspect | Manual Riverpod | Riverpod Annotations |
|--------|-----------------|---------------------|
| **Type Safety** | ✅ Good | ✅ Excellent |
| **Boilerplate** | ❌ High | ✅ Minimal |
| **Family Providers** | ❌ Manual setup | ✅ Automatic |
| **IDE Support** | ✅ Good | ✅ Excellent |
| **Error Messages** | ✅ Good | ✅ Better |
| **Learning Curve** | ✅ Moderate | ✅ Easy |
| **Code Generation** | ❌ No | ✅ Yes |

## 📚 Riverpod Annotations Advantages

- 🎯 **Zero Boilerplate** - Annotations handle everything
- 🔒 **Type Safety** - Compile-time checking
- 🚀 **Auto-completion** - Full IDE support
- 📝 **Self-documenting** - Clear provider definitions
- 🔄 **Family Providers** - Automatic parameter handling
- 🛠️ **Consistent API** - Same pattern for all providers
- 🧪 **Easy Testing** - Generated providers are mockable

## 🎯 Annotation Types

### 1. **@riverpod** - General purpose provider

```dart
@riverpod
String config(ConfigRef ref) => 'value';
```

### 2. **@riverpod** with async

```dart
@riverpod
Future<User> user(UserRef ref) async => api.getUser();
```

### 3. **@riverpod** with parameters (family)

```dart
@riverpod
Future<Post> post(PostRef ref, int id) async => api.getPost(id);
```

### 4. **@riverpod** class for StateNotifier

```dart
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;
  
  void increment() => state++;
}
```

## 🔗 API

Uses **JSONPlaceholder API**:

- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints:
  - `GET /posts` - List of all posts
  - `GET /posts/{id}` - Post details

## 📚 Additional Resources

- [Riverpod Annotations Documentation](https://riverpod.dev/docs/concepts/about_code_generation)
- [Code Generation Guide](https://riverpod.dev/docs/concepts/about_code_generation)
- [Riverpod vs Provider](https://riverpod.dev/docs/concepts/why_riverpod)
- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

---

🎉 **Congratulations!** You have learned Clean Architecture implementation with Riverpod Annotations in Flutter!
