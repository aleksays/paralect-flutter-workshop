# 🚀 Flutter Clean Architecture Workshop

A comprehensive Flutter workshop demonstrating **Clean Architecture** principles with different **state management** solutions. This educational project showcases how to build scalable, maintainable Flutter applications using industry best practices.

## 📋 Workshop Structure

This workshop is organized into branches, each demonstrating different aspects of Flutter development:

| Branch | Focus | State Management | Description |
|--------|-------|------------------|-------------|
| [`main`](../../tree/main) | **Workshop Overview** | - | Main branch with project overview and navigation |
| [`01-dart-basics`](../../tree/01-dart-basics) | **Dart Fundamentals** | - | Variables, functions, classes, OOP concepts |
| [`03-rest-api-futurebuilder`](../../tree/03-rest-api-futurebuilder) | **BLoC Pattern** | flutter_bloc | Clean Architecture + BLoC with event-driven architecture |
| [`04-rest-api-provider`](../../tree/04-rest-api-provider) | **Provider Pattern** | provider | Clean Architecture + Provider with ChangeNotifier |
| [`05-rest-api-riverpod`](../../tree/05-rest-api-riverpod) | **Riverpod Pattern** | riverpod | Clean Architecture + Riverpod with reactive programming |

## 🏗️ Clean Architecture Overview

This workshop demonstrates **Clean Architecture** principles as defined by Robert C. Martin (Uncle Bob). The architecture is divided into three main layers:

```┌─────────────────────────────────────────┐
   │           Presentation Layer            │
   │  (UI, Widgets, State Management)        │
   ├─────────────────────────────────────────┤
   │            Domain Layer                 │
   │     (Entities, Use Cases)               │
   ├─────────────────────────────────────────┤
   │             Data Layer                  │
   │  (Repositories, Data Sources, Models)   │
   └─────────────────────────────────────────┘
```

### 🎯 Architecture Benefits

- ✅ **Separation of Concerns** - Each layer has a specific responsibility
- ✅ **Dependency Inversion** - Inner layers don't depend on outer layers
- ✅ **Testability** - Easy unit testing for each layer
- ✅ **Maintainability** - Clean, organized, and scalable code
- ✅ **Independence** - Business logic is independent of frameworks

## 🔧 Core Technologies

### Shared Dependencies

- **Flutter** - UI framework
- **Dio** - HTTP client for API requests
- **json_serializable** - JSON serialization
- **json_annotation** - JSON serialization

### State Management Specific

- **flutter_bloc** - BLoC pattern implementation
- **provider** - Provider pattern implementation
- **riverpod** - Modern reactive state management

## 📚 What You'll Learn

### Clean Architecture Principles

- ✅ **Separation of Concerns** - Clear layer responsibilities
- ✅ **Dependency Inversion** - Domain doesn't depend on frameworks
- ✅ **Testability** - Easy testing for each layer
- ✅ **Independence** - UI, database, and frameworks are details

### State Management Patterns

- ✅ **BLoC Pattern** - Event-driven architecture with streams
- ✅ **Provider Pattern** - ChangeNotifier with InheritedWidget
- ✅ **Riverpod Pattern** - Modern reactive programming

### Flutter Best Practices

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

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- IDE (VS Code, Android Studio, or IntelliJ)

### Quick Start

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd paralect_flutter_workshop
   ```

2. **Choose a branch to explore:**

   ```bash
   # For Dart basics
   git checkout 01-dart-basics
   
   # For BLoC pattern
   git checkout 03-rest-api-futurebuilder
   
   # For Provider pattern  
   git checkout 04-rest-api-provider
   
   # For Riverpod pattern
   git checkout 05-rest-api-riverpod
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the app:**

   ```bash
   flutter run
   ```

## 📊 State Management Comparison

| Feature | BLoC | Provider | Riverpod |
|---------|------|----------|----------|
| **Learning Curve** | Steep | Moderate | Moderate |
| **Boilerplate** | High | Low | Low |
| **Testing** | Excellent | Good | Excellent |
| **Performance** | Excellent | Good | Excellent |
| **Scalability** | Excellent | Good | Excellent |
| **Community** | Large | Large | Growing |

## 📚 Additional Resources

- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Provider Documentation](https://pub.dev/packages/provider)
- [Riverpod Documentation](https://riverpod.dev/)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

***Happy Learning! 🎉***
