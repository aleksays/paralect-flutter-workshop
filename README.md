# Flutter Workshop - Всесторонний курс по разработке на Flutter

Добро пожаловать в интерактивный воркшоп по Flutter! Этот проект создан для изучения Flutter от основ до продвинутых техник.

## 📚 Содержание воркшопа

### 🎯 Основные темы

1. **Основы Dart** - Переменные, функции, классы, наследование
2. **Основы Flutter** - Виджеты, layout, stateful/stateless
3. **REST API интеграция** - Работа с API, сериализация данных
4. **State Management** - Provider, BLoC, Riverpod
5. **Темизация** - Переключение между светлой/темной темами
6. **Анимации** - Implicit и Explicit анимации, Hero анимации
7. **Tips & Tricks** - Полезные советы и трюки

### 🌿 Структура веток

| Ветка | Описание | Технологии |
|-------|----------|------------|
| `main` | Стартовая точка с навигацией | Flutter основы |
| `01-dart-basics` | Основы языка Dart | Dart синтаксис |
| `02-flutter-basics` | Основы Flutter виджетов | StatelessWidget, StatefulWidget |
| `03-rest-api-futurebuilder` | REST API с FutureBuilder | http, json_serializable, FutureBuilder |
| `04-rest-api-provider` | Posts feed с Provider | Provider, ChangeNotifier |
| `05-rest-api-bloc` | Posts feed с BLoC | flutter_bloc, Cubit |
| `06-rest-api-riverpod` | Posts feed с Riverpod | flutter_riverpod, StateNotifier |
| `07-theme-provider` | Темы с Provider | ThemeMode, Provider |
| `08-theme-bloc` | Темы с BLoC | ThemeMode, BLoC |
| `09-theme-riverpod` | Темы с Riverpod | ThemeMode, Riverpod |
| `10-animations` | Анимации во Flutter | AnimationController, Tween |
| `11-tips-tricks` | Советы и трюки | Различные техники |

## 🚀 Быстрый старт

### Предварительные требования

- Flutter SDK 3.32+ (последняя стабильная версия)
- Dart SDK 3.8+
- IDE (VS Code, Android Studio, или IntelliJ)

### Установка

1. Клонируйте репозиторий:
```bash
git clone <repository-url>
cd paralect_flutter_workshop
```

2. Установите зависимости:
```bash
flutter pub get
```

3. Запустите приложение:
```bash
flutter run
```

## 📖 Как использовать воркшоп

### Навигация по веткам

Каждая тема воркшопа находится в отдельной ветке. Для изучения конкретной темы:

1. Переключитесь на нужную ветку:
```bash
git checkout 01-dart-basics
```

2. Установите зависимости (если требуется):
```bash
flutter pub get
```

3. Запустите приложение:
```bash
flutter run
```

4. Изучите код и документацию в файле `README.md` ветки

### Порядок изучения

Рекомендуется изучать темы в следующем порядке:

1. **01-dart-basics** - Изучите основы Dart
2. **02-flutter-basics** - Освойте основы Flutter
3. **03-rest-api-futurebuilder** - Научитесь работать с API
4. **04-rest-api-provider** до **06-rest-api-riverpod** - Изучите state management
5. **07-theme-provider** до **09-theme-riverpod** - Освойте темизацию
6. **10-animations** - Изучите анимации
7. **11-tips-tricks** - Узнайте полезные советы

## 🔧 Технологии и пакеты

### Основные зависимости

- **flutter** - UI фреймворк
- **dio** - HTTP клиент для работы с API
- **json_annotation** - Аннотации для JSON сериализации
- **provider** - State management решение от Flutter team
- **flutter_bloc** - Predictable state management library
- **flutter_riverpod** - Современное решение для state management

### Dev зависимости

- **json_serializable** - Кодогенерация для JSON
- **build_runner** - Инструмент для кодогенерации
- **flutter_lints** - Статический анализ кода

## 🌐 API

Воркшоп использует [JSONPlaceholder](https://jsonplaceholder.typicode.com/) для демонстрации работы с REST API:

- **Posts**: `https://jsonplaceholder.typicode.com/posts`
- **Users**: `https://jsonplaceholder.typicode.com/users`
- **Comments**: `https://jsonplaceholder.typicode.com/comments`

## 🎨 Примеры реализации

### REST API + Posts Feed

Каждая ветка с REST API демонстрирует:
- Получение списка постов
- Отображение в виде списка
- Обработка состояний загрузки и ошибок
- Различные подходы к state management

### Переключение тем

Демонстрирует реализацию:
- Системная тема
- Светлая тема
- Темная тема
- Сохранение выбора пользователя

## 📱 Поддерживаемые платформы

- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Участие в разработке

Если вы нашли ошибку или хотите предложить улучшение:

1. Создайте issue
2. Создайте pull request
3. Опишите изменения

## 📄 Лицензия

Этот проект создан в образовательных целях.

---

**Автор**: Paralect Team  
**Версия Flutter**: 3.32+  
**Последнее обновление**: 2024

Удачного изучения Flutter! 🚀
