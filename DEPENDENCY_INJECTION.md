# Dependency Injection in Flutter

## Table of Contents

- [What is Dependency Injection?](#what-is-dependency-injection)
- [Problems without DI](#problems-without-di)
- [Benefits of Dependency Injection](#benefits-of-dependency-injection)
- [DI Libraries in Flutter](#di-libraries-in-flutter)
- [GetIt - Service Locator Pattern](#getit---service-locator-pattern)
- [Implementation in Clean Architecture](#implementation-in-clean-architecture)
- [Testing with DI](#testing-with-di)
- [Best Practices](#best-practices)
- [Examples](#examples)

## What is Dependency Injection?

**Dependency Injection (DI)** is a design pattern that allows objects to receive their dependencies from external sources rather than creating them internally. It's a form of **Inversion of Control (IoC)** where the control of dependency creation is inverted from the object itself to an external entity.

### Core Concept

Instead of a class creating its own dependencies:

```dart
class OrderService {
  final PaymentService _paymentService = PaymentService(); // ❌ Tight coupling
}
```

Dependencies are injected from outside:

```dart
class OrderService {
  final PaymentService _paymentService;
  
  OrderService(this._paymentService); // ✅ Loose coupling
}
```

## Problems without DI

### 1. **Tight Coupling**

```dart
// ❌ BAD: Hard dependencies
class PostsBloc {
  final _getPosts = GetPosts(
    PostsRepositoryImpl(
      remoteDataSource: PostsRemoteDataSourceImpl(
        dio: Dio(BaseOptions(
          baseUrl: 'https://api.example.com',
        )),
      ),
    ),
  );
  
  // Problems:
  // - Cannot change implementation easily
  // - Hard to test with mocks
  // - Violates Single Responsibility Principle
  // - Creates multiple instances of same objects
}
```

### 2. **Difficult Testing**

```dart
// ❌ BAD: Cannot mock dependencies
class PostsRepository {
  final _dataSource = PostsRemoteDataSourceImpl(
    dio: Dio(), // Will make real HTTP calls in tests!
  );
  
  Future<List<Post>> getPosts() async {
    return await _dataSource.getPosts(); // Slow, unreliable tests
  }
}
```

### 3. **Configuration Issues**

```dart
// ❌ BAD: Hard-coded configuration
class ApiClient {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://api.production.com', // Cannot change for staging/dev
    timeout: Duration(seconds: 30),
  ));
}
```

### 4. **Object Lifecycle Problems**

```dart
// ❌ BAD: Multiple instances created
class ServiceA {
  final database = Database(); // New instance
}

class ServiceB {
  final database = Database(); // Another new instance!
}
```

## Benefits of Dependency Injection

### 1. **Loose Coupling**

- Classes depend on abstractions, not concrete implementations
- Easy to swap implementations
- Better separation of concerns

### 2. **Improved Testability**

- Easy to inject mock objects for testing
- Isolated unit tests
- Fast and reliable test execution

### 3. **Better Configuration Management**

- Centralized dependency configuration
- Environment-specific setups (dev, staging, production)
- Feature flags and A/B testing support

### 4. **Object Lifecycle Control**

- Singleton pattern for shared resources
- Factory pattern for new instances
- Lazy initialization for performance

### 5. **Maintainability**

- Clear dependency graphs
- Easier refactoring
- Better code organization

## DI Libraries in Flutter

### 1. **get_it** (Service Locator Pattern)

```yaml
dependencies:
  get_it: ^7.6.4
```

**Pros:**

- Simple and lightweight
- No code generation required
- Global access pattern
- Supports different registration types

**Cons:**

- Not compile-time safe
- Global state can be problematic
- Runtime dependency resolution

### 2. **injectable** (with get_it)

```yaml
dependencies:
  get_it: ^7.6.4
  injectable: ^2.3.2

dev_dependencies:
  injectable_generator: ^2.4.1
  build_runner: ^2.4.7
```

**Pros:**

- Code generation for type safety
- Annotation-based registration
- Works with get_it under the hood

**Cons:**

- Requires code generation
- More complex setup

### 3. **Provider** (InheritedWidget-based)

```yaml
dependencies:
  provider: ^6.1.1
```

**Pros:**

- Built on Flutter's InheritedWidget
- Tree-scoped dependencies
- No global state

**Cons:**

- Requires BuildContext
- More boilerplate for deep dependency graphs

### 4. **Riverpod** (Modern Provider)

```yaml
dependencies:
  flutter_riverpod: ^2.4.9
```

**Pros:**

- Compile-time safety
- No BuildContext required
- Automatic dependency disposal
- Excellent DevTools support

**Cons:**

- Learning curve for Provider users
- Newer ecosystem

## GetIt - Service Locator Pattern

### Basic Setup

```dart
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // Service Locator

Future<void> setupDependencies() async {
  // Registration
  sl.registerLazySingleton(() => ApiClient());
  sl.registerFactory(() => UserRepository(sl()));
}

// Usage
final repository = sl<UserRepository>();
```

### Registration Types

#### 1. **Factory** - New instance every time

```dart
sl.registerFactory<UserBloc>(() => UserBloc(
  getUserUseCase: sl(),
  updateUserUseCase: sl(),
));

// Usage: Creates new instance each time
final bloc1 = sl<UserBloc>(); // New instance
final bloc2 = sl<UserBloc>(); // Another new instance
```

#### 2. **LazySingleton** - Single instance, created on first access

```dart
sl.registerLazySingleton<DatabaseService>(() => DatabaseService());

// Usage: Same instance returned
final db1 = sl<DatabaseService>(); // Creates instance
final db2 = sl<DatabaseService>(); // Returns same instance
```

#### 3. **Singleton** - Single instance, created immediately

```dart
final apiClient = ApiClient();
sl.registerSingleton<ApiClient>(apiClient);

// Instance is created and stored immediately
```

#### 4. **Factory with Parameter**

```dart
sl.registerFactoryParam<UserRepository, String, void>(
  (baseUrl, _) => UserRepository(baseUrl: baseUrl),
);

// Usage
final repo = sl<UserRepository>(param1: 'https://api.example.com');
```

## Implementation in Clean Architecture

### Project Structure

```markdawn
lib/
├── core/
│   └── injection/
│       └── injection_container.dart    # DI setup
├── features/
│   └── posts/
│       ├── data/
│       │   ├── datasources/
│       │   └── repositories/
│       ├── domain/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           └── bloc/
```

### Dependency Graph

```markdawn
┌─────────────┐    ┌──────────────┐    ┌─────────────────┐
│  PostsBloc  │───▶│  GetPosts    │───▶│ PostsRepository │
│             │    │  UseCase     │    │   (Interface)   │
└─────────────┘    └──────────────┘    └─────────────────┘
                                                │
                                                ▼
                                       ┌─────────────────┐
                                       │PostsRepositoryImpl│
                                       │  (Implementation) │
                                       └─────────────────┘
                                                │
                                                ▼
                                       ┌─────────────────┐    ┌──────────┐
                                       │PostsRemoteDataSource│───▶│   Dio    │
                                       │                 │    │HTTP Client│
                                       └─────────────────┘    └──────────┘
```

### injection_container.dart Implementation

```dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Posts
  
  // Presentation Layer (BLoC)
  sl.registerFactory(() => PostsBloc(
    getPosts: sl(),
    getPost: sl(),
  ));

  // Domain Layer (Use Cases)
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => GetPost(sl()));

  // Data Layer (Repository Implementation)
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Layer (Data Sources)
  sl.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(dio: sl()),
  );

  //! External Dependencies
  sl.registerLazySingleton(() => Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  )));
}
```

### Usage in main.dart

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await di.init();
  
  runApp(MyApp());
}
```

### Usage in BLoC

```dart
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts _getPosts;
  final GetPost _getPost;

  PostsBloc({
    required GetPosts getPosts,
    required GetPost getPost,
  }) : _getPosts = getPosts,
       _getPost = getPost,
       super(PostsInitial());
}

// Registration
sl.registerFactory(() => PostsBloc(
  getPosts: sl(), // GetIt resolves GetPosts automatically
  getPost: sl(),  // GetIt resolves GetPost automatically
));
```

## Testing with DI

### Test Setup

```dart
void main() {
  setUpAll(() async {
    await setupTestDI();
  });

  tearDownAll(() {
    sl.reset(); // Clear all registrations
  });

  group('PostsBloc Tests', () {
    late PostsBloc bloc;
    late MockGetPosts mockGetPosts;

    setUp(() {
      mockGetPosts = MockGetPosts();
      // Override with mock for testing
      sl.registerFactory<GetPosts>(() => mockGetPosts);
      bloc = sl<PostsBloc>();
    });

    test('should emit PostsLoaded when getPosts succeeds', () {
      // Arrange
      when(() => mockGetPosts(any()))
          .thenAnswer((_) async => Right([testPost]));

      // Act & Assert
      expectLater(
        bloc.stream,
        emitsInOrder([PostsLoading(), PostsLoaded([testPost])]),
      );

      bloc.add(GetPostsEvent());
    });
  });
}

Future<void> setupTestDI() async {
  // Register mocks instead of real implementations
  sl.registerFactory<PostsRepository>(() => MockPostsRepository());
  sl.registerFactory<PostsRemoteDataSource>(() => MockPostsRemoteDataSource());
  sl.registerFactory(() => MockDio());
}
```

### Mock Objects

```dart
class MockPostsRepository extends Mock implements PostsRepository {}
class MockGetPosts extends Mock implements GetPosts {}
class MockDio extends Mock implements Dio {}
```

## Best Practices

### 1. **Register Dependencies in Correct Order**

```dart
Future<void> init() async {
  // 1. External dependencies first (lowest level)
  sl.registerLazySingleton(() => Dio());
  
  // 2. Data sources
  sl.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(dio: sl()),
  );
  
  // 3. Repositories
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(remoteDataSource: sl()),
  );
  
  // 4. Use cases
  sl.registerLazySingleton(() => GetPosts(sl()));
  
  // 5. Presentation layer last (highest level)
  sl.registerFactory(() => PostsBloc(getPosts: sl()));
}
```

### 2. **Use Interfaces/Abstract Classes**

```dart
// ✅ GOOD: Register with interface type
sl.registerLazySingleton<PostsRepository>(
  () => PostsRepositoryImpl(remoteDataSource: sl()),
);

// ❌ BAD: Register with concrete type
sl.registerLazySingleton<PostsRepositoryImpl>(
  () => PostsRepositoryImpl(remoteDataSource: sl()),
);
```

### 3. **Choose Appropriate Registration Types**

```dart
// Singletons for shared resources
sl.registerLazySingleton(() => Dio());
sl.registerLazySingleton(() => DatabaseService());

// Factories for stateful objects
sl.registerFactory(() => PostsBloc(getPosts: sl()));
sl.registerFactory(() => UserBloc(getUser: sl()));
```

### 4. **Environment-Specific Configuration**

```dart
Future<void> init({bool isProduction = false}) async {
  sl.registerLazySingleton(() => Dio(BaseOptions(
    baseUrl: isProduction 
      ? 'https://api.production.com'
      : 'https://api.staging.com',
  )));
}
```

### 5. **Avoid Circular Dependencies**

```dart
// ❌ BAD: Circular dependency
class ServiceA {
  ServiceA(ServiceB serviceB);
}

class ServiceB {
  ServiceB(ServiceA serviceA); // Circular!
}

// ✅ GOOD: Use mediator pattern or events
class ServiceA {
  ServiceA(EventBus eventBus);
}

class ServiceB {
  ServiceB(EventBus eventBus);
}
```

## Examples

### Example 1: Simple Service Registration

```dart
// Service interface
abstract class StorageService {
  Future<void> save(String key, String value);
  Future<String?> get(String key);
}

// Implementation
class LocalStorageService implements StorageService {
  @override
  Future<void> save(String key, String value) async {
    // Implementation
  }

  @override
  Future<String?> get(String key) async {
    // Implementation
  }
}

// Registration
sl.registerLazySingleton<StorageService>(() => LocalStorageService());

// Usage
final storage = sl<StorageService>();
await storage.save('token', 'abc123');
```

### Example 2: Factory with Parameters

```dart
// Service that needs configuration
class ApiService {
  final String baseUrl;
  final Dio dio;
  
  ApiService({required this.baseUrl, required this.dio});
}

// Registration with factory param
sl.registerFactoryParam<ApiService, String, void>(
  (baseUrl, _) => ApiService(baseUrl: baseUrl, dio: sl()),
);

// Usage
final prodApi = sl<ApiService>(param1: 'https://api.production.com');
final stagingApi = sl<ApiService>(param1: 'https://api.staging.com');
```

### Example 3: Complex Dependency Graph

```dart
Future<void> init() async {
  // Core services
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<StorageService>(() => LocalStorageService());
  
  // Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );
  
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storage: sl()),
  );
  
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  
  // BLoCs
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(),
    logoutUseCase: sl(),
  ));
}
```

---

## Conclusion

Dependency Injection is a powerful pattern that promotes:

- **Loose coupling** between components
- **Better testability** with mock objects
- **Improved maintainability** and refactoring
- **Flexible configuration** for different environments

The **get_it** library provides a simple and effective Service Locator implementation for Flutter applications, making it easy to manage dependencies in Clean Architecture projects.

For more complex scenarios, consider using **injectable** with code generation or **Riverpod** for a more modern approach to dependency management.
