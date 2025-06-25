# Flutter Workshop: REST API + Clean Architecture

## Ветка: 03-rest-api-futurebuilder

Эта ветка демонстрирует реализацию REST API с использованием **Clean Architecture** в Flutter приложении.

## 🏗️ Архитектура

Проект организован согласно принципам Clean Architecture с разделением на три основных слоя:

### 📁 Структура проекта

```
lib/
├── core/
│   ├── error/
│   │   └── failures.dart              # Базовые классы ошибок
│   ├── injection/
│   │   └── injection_container.dart   # Dependency Injection
│   ├── network/
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
│           ├── bloc/
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

## 🔧 Используемые технологии

### Основные зависимости:
- **Flutter** - UI фреймворк
- **Dio** - HTTP клиент для API запросов
- **flutter_bloc** - State management
- **get_it** - Dependency injection
- **dartz** - Функциональное программирование (Either)
- **equatable** - Сравнение объектов
- **json_annotation** - JSON сериализация

### Dev зависимости:
- **json_serializable** - Генерация JSON кода
- **build_runner** - Генератор кода

## 🏛️ Слои архитектуры

### 1. Domain Layer (Бизнес-логика)
- **Entities** - Основные сущности бизнес-логики
- **Repositories** - Интерфейсы для получения данных
- **Use Cases** - Конкретные случаи использования

### 2. Data Layer (Данные)
- **Models** - Модели данных с JSON сериализацией
- **Data Sources** - Источники данных (API, база данных)
- **Repository Implementations** - Реализация интерфейсов репозиториев

### 3. Presentation Layer (Представление)
- **BLoC** - Управление состоянием
- **Pages** - Экраны приложения
- **Widgets** - Переиспользуемые компоненты UI

## 🔄 Принципы Clean Architecture

### ✅ Что демонстрирует эта ветка:

1. **Разделение ответственности**: Каждый слой имеет свою ответственность
2. **Инверсия зависимостей**: Domain слой не зависит от внешних фреймворков
3. **Тестируемость**: Легко тестировать каждый слой независимо
4. **Независимость от UI**: Бизнес-логика не зависит от UI
5. **Независимость от фреймворков**: Clean architecture не привязана к Flutter

### 📱 Функциональность:

- ✅ Загрузка списка постов из JSONPlaceholder API
- ✅ Детальный просмотр поста
- ✅ Обработка состояний загрузки
- ✅ Обработка ошибок с возможностью повтора
- ✅ Clean Architecture с BLoC pattern
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

## 📝 Основные файлы

### Domain Layer:
- `lib/features/posts/domain/entities/post.dart` - Entity поста
- `lib/features/posts/domain/usecases/get_posts.dart` - Use case для получения списка постов
- `lib/features/posts/domain/usecases/get_post.dart` - Use case для получения одного поста

### Data Layer:
- `lib/features/posts/data/models/post_model.dart` - Модель поста с JSON сериализацией
- `lib/features/posts/data/datasources/posts_remote_data_source.dart` - Источник данных API

### Presentation Layer:
- `lib/features/posts/presentation/bloc/posts_bloc.dart` - BLoC для управления состоянием
- `lib/features/posts/presentation/pages/posts_page.dart` - Главная страница со списком постов

## 🎯 Цели обучения

После изучения этой ветки вы поймете:

1. ✅ **Clean Architecture принципы**
2. ✅ **Разделение на слои**
3. ✅ **Dependency Injection**
4. ✅ **Use Cases паттерн**
5. ✅ **Repository паттерн**
6. ✅ **BLoC State Management**
7. ✅ **Error Handling**
8. ✅ **Code Generation**

## 🔗 API

Используется **JSONPlaceholder API**:
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints:
  - `GET /posts` - Список всех постов
  - `GET /posts/{id}` - Детали поста

## 📚 Дополнительные ресурсы

- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)
- [Dependency Injection in Flutter](https://pub.dev/packages/get_it)

---

🎉 **Поздравляем!** Вы изучили реализацию Clean Architecture в Flutter!
