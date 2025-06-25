# Flutter Workshop: REST API + Clean Architecture + Provider

## Ветка: 04-rest-api-provider

Эта ветка демонстрирует реализацию REST API с использованием **Clean Architecture** и **Provider** для state management в Flutter приложении.

## 🏗️ Архитектура

Проект организован согласно принципам Clean Architecture с **Provider** в качестве solution для управления состоянием.

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

## 🔧 Используемые технологии

### Основные зависимости:
- **Flutter** - UI фреймворк
- **Provider** - State management solution
- **Dio** - HTTP клиент для API запросов
- **get_it** - Dependency injection
- **dartz** - Функциональное программирование (Either)
- **equatable** - Сравнение объектов
- **json_annotation** - JSON сериализация

## 🏛️ Provider State Management

### 📊 PostsProvider

Provider класс который управляет состоянием постов:

```dart
class PostsProvider extends ChangeNotifier {
  PostsStatus _status = PostsStatus.initial;
  List<Post> _posts = [];
  Post? _selectedPost;
  String _errorMessage = '';

  Future<void> fetchPosts() async {
    _status = PostsStatus.loading;
    notifyListeners();
    
    final result = await _getPosts(const NoParams());
    // Обработка результата...
    notifyListeners();
  }
}
```

### 🔄 Состояния Provider

```dart
enum PostsStatus { 
  initial, 
  loading, 
  loaded, 
  error 
}
```

## 🎯 Provider паттерны

### ✅ Consumer для слушания изменений:

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
    }
  },
)
```

### ✅ Запуск действий через Provider:

```dart
context.read<PostsProvider>().fetchPosts();
```

## 📱 Функциональность

- ✅ Загрузка списка постов из JSONPlaceholder API
- ✅ Детальный просмотр поста
- ✅ Обработка состояний загрузки с Provider
- ✅ Обработка ошибок с возможностью повтора
- ✅ Clean Architecture с Provider pattern
- ✅ Dependency Injection

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

## 📝 Основные файлы Provider

### Provider State Management:
- `lib/features/posts/presentation/providers/posts_provider.dart` - Provider для управления состоянием
- `lib/features/posts/presentation/pages/posts_provider_page.dart` - Главная страница с Consumer
- `lib/features/posts/presentation/pages/post_provider_detail_page.dart` - Страница деталей поста

### Dependency Injection:
- `lib/core/injection/injection_container.dart` - Регистрация PostsProvider

## 🎯 Цели обучения

После изучения этой ветки вы поймете:

1. ✅ **Provider State Management**
2. ✅ **ChangeNotifier паттерн**
3. ✅ **Consumer виджет**
4. ✅ **Context.read() и Context.watch()**
5. ✅ **State management с Clean Architecture**
6. ✅ **Provider dependency injection**
7. ✅ **Lifecycle management в Provider**

## 🔄 Provider vs BLoC

| Аспект | Provider | BLoC |
|--------|----------|------|
| **Простота** | ✅ Простой в изучении | ❌ Больше boilerplate кода |
| **Events** | ❌ Методы напрямую | ✅ Отдельные Event классы |
| **States** | ❌ Enum состояния | ✅ Отдельные State классы |
| **Реактивность** | ✅ ChangeNotifier | ✅ Stream/Bloc |
| **Тестирование** | ✅ Легко тестировать | ✅ Легко тестировать |

## 📚 Provider преимущества

- 🚀 **Простота** - Легко изучить и использовать
- 🔄 **Реактивность** - Автоматическое обновление UI
- 💡 **Гибкость** - Можно использовать с любыми классами
- 🎯 **Performance** - Оптимизация перерисовки
- 🔧 **DI friendly** - Легко интегрируется с DI

## 🔗 API

Используется **JSONPlaceholder API**:
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints:
  - `GET /posts` - Список всех постов
  - `GET /posts/{id}` - Детали поста

## 📚 Дополнительные ресурсы

- [Provider Documentation](https://pub.dev/packages/provider)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

---

🎉 **Поздравляем!** Вы изучили реализацию Clean Architecture с Provider в Flutter!
