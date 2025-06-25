# 🌐 REST API + FutureBuilder - Flutter Workshop

Добро пожаловать в изучение работы с REST API и FutureBuilder! Здесь мы научимся загружать данные из интернета и отображать их в приложении.

## 📖 Что вы изучите

### 1. Работа с REST API
- Настройка HTTP клиента (Dio)
- Выполнение GET запросов
- Обработка ошибок сети
- Таймауты и retry логика

### 2. JSON сериализация
- Аннотации `@JsonSerializable`
- Автоматическая генерация кода с `json_serializable`
- Методы `fromJson` и `toJson`
- Кодогенерация с `build_runner`

### 3. FutureBuilder виджет
- Работа с асинхронными операциями
- Обработка состояний загрузки
- Отображение ошибок
- Обновление данных

### 4. UI/UX паттерны
- Состояния загрузки (Loading states)
- Обработка ошибок (Error handling)
- Пустые состояния (Empty states)
- Pull-to-refresh функциональность

## 🚀 Как запустить

1. Убедитесь, что вы на правильной ветке:
```bash
git branch
# Должна быть выделена: * 03-rest-api-futurebuilder
```

2. Установите зависимости:
```bash
flutter pub get
```

3. Запустите кодогенерацию (если нужно):
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Запустите приложение:
```bash
flutter run
```

## 📱 Что происходит

При запуске приложения:

1. **Загрузка постов** - FutureBuilder автоматически начинает загрузку
2. **Отображение состояний** - показывает индикатор загрузки, ошибки или данные
3. **Навигация** - можно перейти к детальной информации о посте
4. **Обновление** - кнопка refresh для повторной загрузки

## 📚 Архитектура приложения

```
lib/
├── models/
│   ├── post.dart           # Модель данных поста
│   └── post.g.dart         # Сгенерированный код
├── api/
│   └── api_client.dart     # HTTP клиент для API
└── main.dart               # Главный файл с UI и FutureBuilder
```

## 🔍 Изучение кода

### `lib/models/post.dart`
Модель данных с json_serializable:
- Аннотация `@JsonSerializable()`
- Поля модели данных
- Методы `fromJson` и `toJson`
- Переопределение `toString`, `==` и `hashCode`

### `lib/api/api_client.dart`
HTTP клиент для работы с API:
- Настройка базового URL и таймаутов
- Метод `getPosts()` для получения списка постов
- Метод `getPost(id)` для получения конкретного поста
- Обработка различных типов ошибок

### `lib/main.dart`
Главное приложение с FutureBuilder:
- Использование `FutureBuilder<List<Post>>`
- Обработка состояний: loading, error, success, empty
- Кастомные виджеты для каждого состояния
- Навигация между экранами

## 🌐 API Endpoint

Используется бесплатный API [JSONPlaceholder](https://jsonplaceholder.typicode.com/):

```
GET https://jsonplaceholder.typicode.com/posts
```

Возвращает массив объектов:
```json
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat",
  "body": "quia et suscipit..."
}
```

## 🎯 Ключевые концепции

### FutureBuilder паттерны

```dart
FutureBuilder<List<Post>>(
  future: _postsFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return LoadingWidget();
    } else if (snapshot.hasError) {
      return ErrorWidget();
    } else if (snapshot.hasData) {
      return DataWidget(snapshot.data!);
    } else {
      return EmptyWidget();
    }
  },
)
```

### JSON сериализация

```dart
@JsonSerializable()
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
```

### HTTP запросы с Dio

```dart
Future<List<Post>> getPosts() async {
  final response = await _dio.get('/posts');
  final List<dynamic> data = response.data;
  return data.map((json) => Post.fromJson(json)).toList();
}
```

## 🎓 Практические задания

После изучения примеров попробуйте:

1. **Добавить поиск** - фильтрация постов по заголовку
2. **Добавить пагинацию** - загрузка постов частями
3. **Добавить избранное** - сохранение понравившихся постов
4. **Добавить кэширование** - сохранение данных локально

## 🛠️ Debugging советы

- **Проверьте интернет** - убедитесь что есть подключение
- **Смотрите консоль** - все ошибки выводятся в лог
- **Используйте breakpoints** - для отладки асинхронного кода
- **Проверьте модель** - убедитесь что JSON соответствует модели

## ➡️ Что дальше?

После изучения FutureBuilder переходите к state management:

```bash
# Provider
git checkout 04-rest-api-provider

# BLoC
git checkout 05-rest-api-bloc

# Riverpod
git checkout 06-rest-api-riverpod
```

## 💡 Полезные ресурсы

- [Dio Documentation](https://pub.dev/packages/dio)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [FutureBuilder в Flutter](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

---

**Следующая тема**: [REST API + Provider](../04-rest-api-provider)  
**Назад**: [Основы Flutter](../02-flutter-basics)
