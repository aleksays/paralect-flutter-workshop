# Flutter Workshop: REST API + Clean Architecture + Provider

## Branch: 04-rest-api-provider

This branch demonstrates REST API implementation using **Clean Architecture** and **Provider** for state management in a Flutter application.

## 🏗️ Architecture

The project is organized according to Clean Architecture principles with **Provider** as a simple and effective state management solution.

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
│           ├── providers/              # Provider State Management
│           │   └── posts_provider.dart
│           ├── pages/
│           │   ├── posts_provider_page.dart
│           │   └── post_provider_detail_page.dart
│           └── widgets/
│               ├── error_widget.dart
│               ├── loading_widget.dart
│               └── post_card.dart
└── main.dart
```

## 🔧 Technologies Used

### Core Dependencies:
- **Flutter** - UI framework
- **Provider** - Simple state management
- **Dio** - HTTP client for API requests
- **get_it** - Dependency injection
- **dartz** - Functional programming (Either)
- **equatable** - Object comparison
- **json_annotation** - JSON serialization

## 🏛️ Provider State Management

### 📊 Provider Pattern

The Provider pattern uses `ChangeNotifier` to manage state:

#### 1. PostsProvider (posts_provider.dart)
```dart
enum PostsStatus { initial, loading, loaded, error }

class PostsProvider extends ChangeNotifier {
  final GetPosts _getPosts;
  final GetPost _getPost;
  
  PostsStatus _status = PostsStatus.initial;
  List<Post> _posts = [];
  Post? _selectedPost;
  String _errorMessage = '';
  
  // Getters
  PostsStatus get status => _status;
  List<Post> get posts => _posts;
  Post? get selectedPost => _selectedPost;
  String get errorMessage => _errorMessage;
  
  Future<void> fetchPosts() async {
    _status = PostsStatus.loading;
    notifyListeners();
    
    final result = await _getPosts(const NoParams());
    
    result.fold(
      (failure) {
        _status = PostsStatus.error;
        _errorMessage = failure.message;
        _posts = [];
      },
      (posts) {
        _status = PostsStatus.loaded;
        _posts = posts;
        _errorMessage = '';
      },
    );
    
    notifyListeners();
  }
}
```

## 🎯 Provider Patterns

### ✅ Consumer for listening to changes:

```dart
Consumer<PostsProvider>(
  builder: (context, postsProvider, child) {
    switch (postsProvider.status) {
      case PostsStatus.loading:
        return LoadingWidget();
      case PostsStatus.loaded:
        return PostsList(postsProvider.posts);
      case PostsStatus.error:
        return ErrorWidget(postsProvider.errorMessage);
      case PostsStatus.initial:
        return InitialWidget();
    }
  },
)
```

### ✅ Provider access methods:

```dart
// Reading state (causes rebuild)
final posts = context.watch<PostsProvider>().posts;

// Calling methods (no rebuild)
context.read<PostsProvider>().fetchPosts();

// Provider.of alternative
final provider = Provider.of<PostsProvider>(context);
```

### ✅ ChangeNotifierProvider setup:

```dart
ChangeNotifierProvider<PostsProvider>(
  create: (context) => sl<PostsProvider>(),
  child: PostsProviderPage(),
)
```

## 📱 Features

- ✅ Load posts list from JSONPlaceholder API
- ✅ Detailed post view
- ✅ Loading state handling with Provider
- ✅ Error handling with retry capability
- ✅ Clean Architecture with Provider pattern
- ✅ Dependency Injection
- ✅ ChangeNotifier for state management

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

## 📝 Key Provider Files

### Provider State Management:
- `lib/features/posts/presentation/providers/posts_provider.dart` - Main Provider logic
- `lib/features/posts/presentation/pages/posts_provider_page.dart` - Main page with Consumer
- `lib/features/posts/presentation/pages/post_provider_detail_page.dart` - Post details page

### Main Application:
- `lib/main.dart` - ChangeNotifierProvider setup

## 🎯 Learning Objectives

After studying this branch you will understand:

1. ✅ **Provider State Management**
2. ✅ **ChangeNotifier pattern**
3. ✅ **Consumer and context.watch()/context.read()**
4. ✅ **Provider dependency injection**
5. ✅ **State management with enums**
6. ✅ **Clean Architecture with Provider**
7. ✅ **ChangeNotifierProvider setup**
8. ✅ **Manual state management**

## 🔄 Provider vs BLoC vs Riverpod

| Aspect | Provider | BLoC | Riverpod |
|--------|----------|------|----------|
| **Type Safety** | ❌ Runtime | ✅ Compile-time | ✅ Compile-time |
| **Simplicity** | ✅ Simple | ❌ Complex | ✅ Very simple |
| **Performance** | ✅ Good | ✅ Excellent | ✅ Excellent |
| **Testing** | ✅ Easy | ✅ Easy | ✅ Easy |
| **DevTools** | ❌ Limited | ✅ Excellent | ✅ Excellent |
| **Learning Curve** | ✅ Easy | ❌ Steep | ✅ Easy |
| **Boilerplate** | ✅ Low | ❌ High | ✅ Low |

## 📚 Provider Advantages

- 🔧 **Simple** - Easy to learn and implement
- 📱 **Built-in** - Part of Flutter ecosystem
- 🎯 **Lightweight** - Minimal boilerplate
- 🧪 **Testable** - Easy unit testing
- 🔄 **Flexible** - Works with any state type
- 📚 **Well documented** - Extensive documentation
- 🏗️ **InheritedWidget** - Uses Flutter's native mechanism

## 🎯 Provider Core Concepts

### 1. **ChangeNotifier** - Notifies listeners about changes
```dart
class PostsProvider extends ChangeNotifier {
  void updateState() {
    // Update state
    notifyListeners(); // Notify UI
  }
}
```

### 2. **Consumer** - Listens to provider changes
```dart
Consumer<PostsProvider>(
  builder: (context, provider, child) => Widget(),
)
```

### 3. **context.watch()** - Listens to changes
```dart
final posts = context.watch<PostsProvider>().posts;
```

### 4. **context.read()** - Accesses provider without listening
```dart
context.read<PostsProvider>().fetchPosts();
```

## 🔗 API

Uses **JSONPlaceholder API**:
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints:
  - `GET /posts` - List of all posts
  - `GET /posts/{id}` - Post details

## 📚 Additional Resources

- [Provider Documentation](https://pub.dev/packages/provider)
- [Provider Pattern](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)
- [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html)
- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

---

🎉 **Congratulations!** You have learned Clean Architecture implementation with Provider in Flutter!
