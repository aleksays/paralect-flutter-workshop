# Flutter Workshop: REST API + Clean Architecture + BLoC

## Branch: 03-rest-api-futurebuilder

This branch demonstrates REST API implementation using **Clean Architecture** and **BLoC** for state management in a Flutter application.

## 🏗️ Architecture

The project is organized according to Clean Architecture principles with **BLoC** as a proven state management solution.

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
│           ├── bloc/                   # BLoC State Management
│           │   ├── posts_bloc.dart
│           │   ├── posts_event.dart
│           │   └── posts_state.dart
│           ├── pages/
│           │   ├── posts_page.dart
│           │   └── post_detail_page.dart
│           └── widgets/
│               ├── error_widget.dart
│               ├── loading_widget.dart
│               └── post_card.dart
└── main.dart
```

## 🔧 Technologies Used

### Core Dependencies:
- **Flutter** - UI framework
- **BLoC** - Proven state management
- **Dio** - HTTP client for API requests
- **get_it** - Dependency injection
- **dartz** - Functional programming (Either)
- **equatable** - Object comparison
- **json_annotation** - JSON serialization

## 🏛️ BLoC State Management

### 📊 BLoC Pattern

The BLoC pattern consists of three main components:

#### 1. Events (posts_event.dart)
```dart
abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class GetPostsEvent extends PostsEvent {
  const GetPostsEvent();
}

class GetPostEvent extends PostsEvent {
  final int id;
  const GetPostEvent(this.id);
}
```

#### 2. States (posts_state.dart)
```dart
abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {}
class PostsLoading extends PostsState {}
class PostsLoaded extends PostsState {
  final List<Post> posts;
}
class PostsError extends PostsState {
  final String message;
}
```

#### 3. BLoC (posts_bloc.dart)
```dart
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts getPosts;
  final GetPost getPost;
  
  PostsBloc({required this.getPosts, required this.getPost}) 
    : super(PostsInitial()) {
    on<GetPostsEvent>(_onGetPosts);
    on<GetPostEvent>(_onGetPost);
  }
}
```

## 🎯 BLoC Patterns

### ✅ BlocBuilder for UI updates:

```dart
BlocBuilder<PostsBloc, PostsState>(
  builder: (context, state) {
    if (state is PostsLoading) {
      return LoadingWidget();
    } else if (state is PostsLoaded) {
      return PostsList(state.posts);
    } else if (state is PostsError) {
      return ErrorWidget(state.message);
    }
    return InitialWidget();
  },
)
```

### ✅ Event dispatching:

```dart
// Trigger events
context.read<PostsBloc>().add(GetPostsEvent());
context.read<PostsBloc>().add(GetPostEvent(postId));
```

### ✅ BlocProvider for dependency injection:

```dart
BlocProvider<PostsBloc>(
  create: (context) => sl<PostsBloc>(),
  child: PostsPage(),
)
```

## 📱 Features

- ✅ Load posts list from JSONPlaceholder API
- ✅ Detailed post view
- ✅ Loading state handling with BLoC
- ✅ Error handling with retry capability
- ✅ Clean Architecture with BLoC pattern
- ✅ Dependency Injection
- ✅ Event-driven architecture

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

## 📝 Key BLoC Files

### BLoC State Management:
- `lib/features/posts/presentation/bloc/posts_bloc.dart` - Main BLoC logic
- `lib/features/posts/presentation/bloc/posts_event.dart` - Event definitions
- `lib/features/posts/presentation/bloc/posts_state.dart` - State definitions

### Pages:
- `lib/features/posts/presentation/pages/posts_page.dart` - Main page with BlocBuilder
- `lib/features/posts/presentation/pages/post_detail_page.dart` - Post details page

### Main Application:
- `lib/main.dart` - BlocProvider setup

## 🎯 Learning Objectives

After studying this branch you will understand:

1. ✅ **BLoC State Management**
2. ✅ **Event-driven architecture**
3. ✅ **BlocBuilder and BlocProvider**
4. ✅ **State classes with Equatable**
5. ✅ **Event dispatching with context.read()**
6. ✅ **Clean Architecture with BLoC**
7. ✅ **Dependency injection with get_it**
8. ✅ **Stream-based state management**

## 🔄 BLoC vs Provider vs Riverpod

| Aspect | BLoC | Provider | Riverpod |
|--------|------|----------|----------|
| **Type Safety** | ✅ Compile-time | ❌ Runtime | ✅ Compile-time |
| **Simplicity** | ❌ Complex | ✅ Simple | ✅ Very simple |
| **Performance** | ✅ Excellent | ✅ Good | ✅ Excellent |
| **Testing** | ✅ Easy | ✅ Easy | ✅ Easy |
| **DevTools** | ✅ Excellent | ❌ Limited | ✅ Excellent |
| **Learning Curve** | ❌ Steep | ✅ Easy | ✅ Easy |
| **Predictability** | ✅ High | ✅ Medium | ✅ High |

## 📚 BLoC Advantages

- 🔄 **Predictable** - Clear state transitions
- 🧪 **Testable** - Easy unit testing
- 🏗️ **Scalable** - Works well for large apps
- 📱 **Platform agnostic** - Works outside Flutter
- 🔧 **Separation of concerns** - Clear business logic separation
- 🛠️ **DevTools** - Excellent debugging tools
- 📊 **Time-travel debugging** - Replay events

## 🎯 BLoC Core Concepts

### 1. **Events** - User interactions or system events
```dart
abstract class PostsEvent extends Equatable {}
```

### 2. **States** - Application state at any given time
```dart
abstract class PostsState extends Equatable {}
```

### 3. **BLoC** - Business Logic Component
```dart
class PostsBloc extends Bloc<PostsEvent, PostsState> {}
```

### 4. **Transitions** - State changes
```dart
emit(PostsLoading());
emit(PostsLoaded(posts));
```

## 🔗 API

Uses **JSONPlaceholder API**:
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints:
  - `GET /posts` - List of all posts
  - `GET /posts/{id}` - Post details

## 📚 Additional Resources

- [BLoC Documentation](https://bloclibrary.dev/)
- [BLoC Pattern](https://www.didierboelens.com/2018/08/reactive-programming-streams-bloc/)
- [Flutter BLoC Tutorial](https://bloclibrary.dev/tutorials/flutter-counter/)
- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

---

🎉 **Congratulations!** You have learned Clean Architecture implementation with BLoC in Flutter!
