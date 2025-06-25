# Flutter Workshop: REST API + Clean Architecture + Riverpod

## Ветка: 05-rest-api-riverpod

Эта ветка демонстрирует реализацию REST API с использованием **Clean Architecture** и **Riverpod** для state management в Flutter приложении.

## 🏗️ Архитектура

Проект организован согласно принципам Clean Architecture с **Riverpod** в качестве современного solution для управления состоянием.

### 📁 Структура проекта

```
lib/
├── core/
│   ├── error/
│   │   └── failures.dart              # Базовые классы ошибок
│   ├── injection/
│   │   └── injection_container.dart   # Dependency Injection
│   └── usecases/
│       └── usecase.dart               # Базовый интерфейс UseCase
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

## 🔧 Используемые технологии

### Основные зависимости:
- **Flutter** - UI фреймворк
- **Riverpod** - Современный state management
- **Dio** - HTTP клиент для API запросов
- **get_it** - Dependency injection
- **dartz** - Функциональное программирование (Either)
- **equatable** - Сравнение объектов
- **json_annotation** - JSON сериализация

## 🏛️ Riverpod State Management

### 📊 Riverpod Providers

Файл `posts_providers.dart` содержит различные типы провайдеров:

#### 1. Use Cases Providers
```dart
final getPostsProvider = Provider<GetPosts>((ref) => di.sl<GetPosts>());
final getPostProvider = Provider<GetPost>((ref) => di.sl<GetPost>());
```

#### 2. FutureProvider для простых асинхронных операций
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

#### 3. StateNotifierProvider для сложного state management
```dart
class PostsNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  Future<void> fetchPosts() async {
    state = const AsyncValue.loading();
    // Логика загрузки...
  }
}

final postsNotifierProvider = StateNotifierProvider<PostsNotifier, AsyncValue<List<Post>>>((ref) {
  return PostsNotifier(ref.watch(getPostsProvider));
});
```

## 🎯 Riverpod паттерны

### ✅ ConsumerWidget для доступа к ref:

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

### ✅ AsyncValue.when() для обработки состояний:

```dart
postsAsync.when(
  loading: () => CircularProgressIndicator(),
  data: (posts) => ListView.builder(...),
  error: (error, stackTrace) => ErrorWidget(),
)
```

### ✅ Чтение и модификация состояния:

```dart
// Чтение состояния
final posts = ref.watch(postsProvider);

// Запуск действий
ref.read(postsNotifierProvider.notifier).fetchPosts();
```

## 📱 Функциональность

- ✅ Загрузка списка постов из JSONPlaceholder API
- ✅ Детальный просмотр поста
- ✅ Обработка состояний загрузки с Riverpod
- ✅ Обработка ошибок с возможностью повтора
- ✅ Clean Architecture с Riverpod pattern
- ✅ Dependency Injection
- ✅ FutureProvider и StateNotifier patterns

## 🚀 Запуск

1. Установите зависимости:
```bash
flutter pub get
```

2. Сгенерируйте код для JSON сериализации:
```bash
dart run build_runner build
```

3. Запустите приложение:
```bash
flutter run
```

## 📝 Основные файлы Riverpod

### Riverpod State Management:
- `lib/features/posts/presentation/providers/posts_providers.dart` - Все Riverpod провайдеры
- `lib/features/posts/presentation/pages/posts_riverpod_page.dart` - Главная страница с ConsumerWidget
- `lib/features/posts/presentation/pages/post_riverpod_detail_page.dart` - Страница деталей поста

### Main Application:
- `lib/main.dart` - ProviderScope и настройка Riverpod

## 🎯 Цели обучения

После изучения этой ветки вы поймете:

1. ✅ **Riverpod State Management**
2. ✅ **Provider, FutureProvider, StateNotifierProvider**
3. ✅ **ConsumerWidget и ConsumerStatefulWidget**
4. ✅ **AsyncValue и .when() метод**
5. ✅ **ref.watch() и ref.read()**
6. ✅ **ProviderScope для DI**
7. ✅ **State management с Clean Architecture**
8. ✅ **Family providers для параметров**

## 🔄 Riverpod vs Provider vs BLoC

| Аспект | Riverpod | Provider | BLoC |
|--------|----------|----------|------|
| **Безопасность типов** | ✅ Compile-time | ❌ Runtime | ✅ Compile-time |
| **Простота** | ✅ Очень простой | ✅ Простой | ❌ Сложный |
| **Performance** | ✅ Отличный | ✅ Хороший | ✅ Отличный |
| **Testing** | ✅ Легко | ✅ Легко | ✅ Легко |
| **DevTools** | ✅ Отличные | ❌ Ограниченные | ✅ Отличные |
| **Async** | ✅ AsyncValue | ❌ Manual | ✅ Stream |
| **Dependencies** | ✅ Автоматические | ❌ Manual | ❌ Manual |

## 📚 Riverpod преимущества

- 🔒 **Type Safety** - Compile-time проверки
- 🚀 **Performance** - Автоматическая оптимизация
- 🧪 **Testability** - Легкое тестирование и моки
- 🔄 **Reactive** - Автоматическое обновление зависимостей
- 🛠️ **DevTools** - Отличная отладка
- 📱 **No Context** - Не нужен BuildContext
- 🔧 **Clean API** - Интуитивный и простой API

## 🎯 Riverpod Provider Types

### 1. **Provider** - Для неизменяемых данных
```dart
final configProvider = Provider((ref) => Config());
```

### 2. **FutureProvider** - Для асинхронных операций  
```dart
final userProvider = FutureProvider((ref) async => api.getUser());
```

### 3. **StateProvider** - Для простого состояния
```dart
final counterProvider = StateProvider((ref) => 0);
```

### 4. **StateNotifierProvider** - Для сложного состояния
```dart
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) => TodosNotifier());
```

## 🔗 API

Используется **JSONPlaceholder API**:
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints:
  - `GET /posts` - Список всех постов
  - `GET /posts/{id}` - Детали поста

## 📚 Дополнительные ресурсы

- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod vs Provider](https://riverpod.dev/docs/concepts/why_riverpod)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

---

🎉 **Поздравляем!** Вы изучили реализацию Clean Architecture с Riverpod в Flutter!
