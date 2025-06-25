# Flutter Workshop: Clean Architecture with Multiple State Management Solutions

A comprehensive Flutter workshop demonstrating Clean Architecture implementation with three different state management approaches: **BLoC**, **Provider**, and **Riverpod**.

## 🎯 Workshop Overview

This workshop teaches Flutter developers how to implement Clean Architecture principles while comparing different state management solutions. Each branch demonstrates the same REST API functionality using a different state management approach.

## 🌳 Branch Structure

| Branch | State Management | Theme | Description |
|--------|------------------|-------|-------------|
| `main` | - | - | Workshop overview and setup |
| `03-rest-api-futurebuilder` | **BLoC** | 🔵 Blue | Clean Architecture with BLoC pattern |
| `04-rest-api-provider` | **Provider** | 🟢 Green | Clean Architecture with Provider pattern |
| `05-rest-api-riverpod` | **Riverpod** | 🟣 Purple | Clean Architecture with Riverpod pattern |

## 🏗️ Clean Architecture Implementation

All branches follow the same Clean Architecture principles:

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
│           ├── [state_management]/    # BLoC/Provider/Riverpod specific
│           ├── pages/
│           └── widgets/
└── main.dart
```

## 🔧 Core Technologies

### Shared Dependencies:
- **Flutter** - UI framework
- **Dio** - HTTP client for API requests
- **get_it** - Dependency injection
- **dartz** - Functional programming (Either)
- **equatable** - Object comparison
- **json_annotation** - JSON serialization

### State Management Specific:
- **flutter_bloc** - BLoC pattern implementation
- **provider** - Provider pattern implementation
- **flutter_riverpod** - Riverpod pattern implementation

## 📱 Features (All Branches)

- ✅ Load posts list from JSONPlaceholder API
- ✅ Detailed post view
- ✅ Loading state handling
- ✅ Error handling with retry capability
- ✅ Clean Architecture implementation
- ✅ Dependency Injection
- ✅ JSON serialization with code generation

## 🎓 Learning Path

### 1. **Start with BLoC** (`03-rest-api-futurebuilder`)
- Learn Clean Architecture fundamentals
- Understand event-driven architecture
- Master predictable state management

### 2. **Explore Provider** (`04-rest-api-provider`)
- Understand ChangeNotifier pattern
- Learn simpler state management approach
- Compare with BLoC implementation

### 3. **Discover Riverpod** (`05-rest-api-riverpod`)
- Experience modern state management
- Learn compile-time safety
- Understand provider composition

## 🔄 State Management Comparison

| Aspect | BLoC | Provider | Riverpod |
|--------|------|----------|----------|
| **Type Safety** | ✅ Compile-time | ❌ Runtime | ✅ Compile-time |
| **Simplicity** | ❌ Complex | ✅ Simple | ✅ Very simple |
| **Performance** | ✅ Excellent | ✅ Good | ✅ Excellent |
| **Testing** | ✅ Easy | ✅ Easy | ✅ Easy |
| **DevTools** | ✅ Excellent | ❌ Limited | ✅ Excellent |
| **Learning Curve** | ❌ Steep | ✅ Easy | ✅ Easy |
| **Boilerplate** | ❌ High | ✅ Low | ✅ Low |
| **Predictability** | ✅ High | ✅ Medium | ✅ High |

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- IDE (VS Code, Android Studio, or IntelliJ)

### Quick Start

1. **Clone the repository:**
```bash
git clone <repository-url>
cd paralect_flutter_workshop
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Generate code:**
```bash
dart run build_runner build
```

4. **Choose a branch to explore:**
```bash
# For BLoC implementation
git checkout 03-rest-api-futurebuilder

# For Provider implementation
git checkout 04-rest-api-provider

# For Riverpod implementation
git checkout 05-rest-api-riverpod
```

5. **Run the application:**
```bash
flutter run
```

## 📚 What You'll Learn

### Clean Architecture Principles:
- ✅ **Separation of Concerns** - Clear layer responsibilities
- ✅ **Dependency Inversion** - Domain doesn't depend on frameworks
- ✅ **Testability** - Easy testing for each layer
- ✅ **Independence** - UI, database, and frameworks are details

### State Management Patterns:
- ✅ **BLoC Pattern** - Event-driven architecture with streams
- ✅ **Provider Pattern** - ChangeNotifier with InheritedWidget
- ✅ **Riverpod Pattern** - Modern reactive programming

### Flutter Best Practices:
- ✅ **Code Generation** - JSON serialization automation
- ✅ **Dependency Injection** - Proper service location
- ✅ **Error Handling** - Functional error handling with Either
- ✅ **API Integration** - RESTful API consumption

## 🔗 API Information

All branches use the **JSONPlaceholder API**:
- **Base URL:** `https://jsonplaceholder.typicode.com`
- **Endpoints:**
  - `GET /posts` - List of all posts
  - `GET /posts/{id}` - Specific post details

## 📝 Workshop Structure

Each branch contains:
- 📖 **Detailed README** - Branch-specific documentation
- 🛠️ **Complete Implementation** - Working app with state management
- 🧪 **Tests** - Unit and widget tests
- 📚 **Code Examples** - Best practices demonstration

## 🎯 Target Audience

- **Flutter Developers** wanting to learn Clean Architecture
- **Mobile Developers** exploring state management options
- **Students** learning software architecture patterns
- **Teams** deciding on state management solutions

## 📚 Additional Resources

- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Provider Documentation](https://pub.dev/packages/provider)
- [Riverpod Documentation](https://riverpod.dev/)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)

## 🤝 Contributing

This is a workshop repository. Feel free to:
- Report issues
- Suggest improvements
- Submit pull requests
- Share feedback

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

🎉 **Happy Learning!** Explore each branch to master Clean Architecture with different state management solutions in Flutter!
