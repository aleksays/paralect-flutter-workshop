# Flutter Workshop: REST API + Clean Architecture + Riverpod

## Branch: 05-rest-api-riverpod

This branch demonstrates REST API implementation using **Clean Architecture** and **Riverpod** for state management in a Flutter application.

## 🏗️ Architecture

The project is organized according to Clean Architecture principles with **Riverpod** as a modern state management solution.

### 📁 Project Structure

```
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
│           ├── providers/              # Riverpod Providers
│           │   └── posts_providers.dart
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

### Core Dependencies:
- **Flutter** - UI framework
- **Riverpod** - Modern state management
- **Dio** - HTTP client for API requests
- **get_it** - Dependency injection
- **dartz** - Functional programming (Either)
- **equatable** - Object comparison
- **json_annotation** - JSON serialization

## 🏛️ Riverpod State Management

### 📊 Riverpod Providers

The `posts_providers.dart` file contains various provider types:

#### 1. Use Cases Providers
```dart
final getPostsProvider = Provider<GetPosts>((ref) => di.sl<GetPosts>());
final getPostProvider = Provider<GetPost>((ref) => di.sl<GetPost>());
```

#### 2. FutureProvider for simple async operations
```dart
final postsProvider = FutureProvider<List<Post>>((ref) async {
  final getPosts = ref.watch(getPostsProvider);
  final result = await getPosts(const NoParams());
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (posts) => posts,
  );
});
```

#### 3. StateNotifierProvider for complex state management
```dart
class PostsNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  Future<void> fetchPosts() async {
    state = const AsyncValue.loading();
    // Loading logic...
  }
}

final postsNotifierProvider = StateNotifierProvider<PostsNotifier, AsyncValue<List<Post>>>((ref) {
  return PostsNotifier(ref.watch(getPostsProvider));
});
```

## 🎯 Riverpod Patterns

### ✅ ConsumerWidget for accessing ref:

```dart
class PostsRiverpodPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsNotifierProvider);
    
    return postsAsync.when(
      loading: () => LoadingWidget(),
      data: (posts) => PostsList(posts),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

### ✅ AsyncValue.when() for state handling:

```dart
postsAsync.when(
  loading: () => CircularProgressIndicator(),
  data: (posts) => ListView.builder(...),
  error: (error, stackTrace) => ErrorWidget(),
)
```

### ✅ Reading and modifying state:

```dart
// Reading state
final posts = ref.watch(postsProvider);

// Triggering actions
ref.read(postsNotifierProvider.notifier).fetchPosts();
```

## 📱 Features

- ✅ Load posts list from JSONPlaceholder API
- ✅ Detailed post view
- ✅ Loading state handling with Riverpod
- ✅ Error handling with retry capability
- ✅ Clean Architecture with Riverpod pattern
- ✅ Dependency Injection
- ✅ FutureProvider and StateNotifier patterns

## 🚀 Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Generate code for JSON serialization:
```bash
dart run build_runner build
```

3. Run the application:
```bash
flutter run
```

## 📝 Key Riverpod Files

### Riverpod State Management:
- `lib/features/posts/presentation/providers/posts_providers.dart` - All Riverpod providers
- `lib/features/posts/presentation/pages/posts_riverpod_page.dart` - Main page with ConsumerWidget
- `lib/features/posts/presentation/pages/post_riverpod_detail_page.dart` - Post details page

### Main Application:
- `lib/main.dart` - ProviderScope and Riverpod setup

## 🎯 Learning Objectives

After studying this branch you will understand:

1. ✅ **Riverpod State Management**
2. ✅ **Provider, FutureProvider, StateNotifierProvider**
3. ✅ **ConsumerWidget and ConsumerStatefulWidget**
4. ✅ **AsyncValue and .when() method**
5. ✅ **ref.watch() and ref.read()**
6. ✅ **ProviderScope for DI**
7. ✅ **State management with Clean Architecture**
8. ✅ **Family providers for parameters**

## 🔄 Riverpod vs Provider vs BLoC

| Aspect | Riverpod | Provider | BLoC |
|--------|----------|----------|------|
| **Type Safety** | ✅ Compile-time | ❌ Runtime | ✅ Compile-time |
| **Simplicity** | ✅ Very simple | ✅ Simple | ❌ Complex |
| **Performance** | ✅ Excellent | ✅ Good | ✅ Excellent |
| **Testing** | ✅ Easy | ✅ Easy | ✅ Easy |
| **DevTools** | ✅ Excellent | ❌ Limited | ✅ Excellent |
| **Async** | ✅ AsyncValue | ❌ Manual | ✅ Stream |
| **Dependencies** | ✅ Automatic | ❌ Manual | ❌ Manual |

## 📚 Riverpod Advantages

- 🔒 **Type Safety** - Compile-time checks
- 🚀 **Performance** - Automatic optimization
- 🧪 **Testability** - Easy testing and mocking
- 🔄 **Reactive** - Automatic dependency updates
- 🛠️ **DevTools** - Excellent debugging
- 📱 **No Context** - No BuildContext dependency
- 🔧 **Clean API** - Intuitive and simple API

## 🎯 Riverpod Provider Types

### 1. **Provider** - For immutable data
```dart
final configProvider = Provider((ref) => Config());
```

### 2. **FutureProvider** - For async operations  
```dart
final userProvider = FutureProvider((ref) async => api.getUser());
```

### 3. **StateProvider** - For simple state
```dart
final counterProvider = StateProvider((ref) => 0);
```

### 4. **StateNotifierProvider** - For complex state
```dart
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) => TodosNotifier());
```

## 🔗 API

Uses **JSONPlaceholder API**:
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints:
  - `GET /posts` - List of all posts
  - `GET /posts/{id}` - Post details

## 📚 Additional Resources

- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod vs Provider](https://riverpod.dev/docs/concepts/why_riverpod)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

---

🎉 **Congratulations!** You have learned Clean Architecture implementation with Riverpod in Flutter!
