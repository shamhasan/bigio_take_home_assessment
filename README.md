# Rick and Morty Wiki - Bigio Takehome Assessment

## <a name="introduction"></a> Introduction
This project is a mobile application built with **Flutter** that allows users to explore characters from the Rick and Morty universe. The application implements **Clean Architecture** to ensure separation of concerns, scalability, and testability.

Users can view a list of characters, search for specific names, view detailed information, and save their favorite characters locally using a SQLite database. The project also includes Unit Tests for the State Management layer.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Tech Stack & Libraries](#libraries)
- [Project Architecture](#project-structures)
- [Unit Testing](#unit-testing)
- [APK Link](#apk-link)

## <a name="features"></a> Features
- **Character List**: Displays a paginated list of characters fetched from the Rick and Morty API.
- **Search Feature**: Real-time search functionality with debounce to find specific characters.
- **Character Detail**: View detailed attributes of a character (Status, Species, Gender, Origin, Location).
- **Favorite System**: Save and remove characters from a local database (SQLite/Sqflite).
- **Offline Support**: Access saved favorite characters even without an internet connection.
- **Error Handling**: Proper error messages for Server Failures or Database Failures.

## <a name="libraries"></a> Tech Stack & Libraries
This project uses the following libraries and tools:

- **Framework**: Flutter (Dart)
- **Architecture**: Clean Architecture (Data, Domain, Presentation)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Networking**: [dio](https://pub.dev/packages/dio) (Powerful Http Client for Dart)
- **Local Database**: [sqflite](https://pub.dev/packages/sqflite) & [path](https://pub.dev/packages/path)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Functional Programming**: [dartz](https://pub.dev/packages/dartz) (For `Either<Failure, Type>` handling)
- **Testing**:
  - [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
  - [mockito](https://pub.dev/packages/mockito) (Mocking dependencies)


## <a name="project-structures"></a> Project Structure
The project follows a **Feature-First Clean Architecture** structure:

```text
lib/
├── core/                   # Core functionality (Error handling, Utils, Constants)
│   ├── error/              # Failures & Exceptions
│   ├── usecases/           # Base UseCase class
│   └── utils/              # RequestState enum, constants
├── features/
│   └── character/          # Feature: Character
│       ├── data/           # Data Layer
│       │   ├── datasources/    # Remote (API) & Local (SQLite) Data Sources
│       │   ├── models/         # JSON/DB Models (extends Entity)
│       │   └── repositories/   # Repository Implementation
│       ├── domain/         # Domain Layer (Business Logic)
│       │   ├── entities/       # Core Business Objects
│       │   ├── repositories/   # Repository Interfaces (Contracts)
│       │   └── usecases/       # Logic for specific actions (Get, Search, Toggle Fav)
│       └── presentation/   # Presentation Layer (UI)
│           ├── pages/          # Screens (Home, Detail, Search, Favorite)
│           ├── provider/       # State Management (ChangeNotifier)
│           └── widgets/        # Reusable Widgets
├── injection_container.dart # Dependency Injection Setup (Service Locator)
└── main.dart               # Entry point
```

## <a name="unit-testing"></a> Unit Testing
This project includes Unit Tests to ensure the reliability of the business logic and state management. The tests cover:
1.  **Provider/Bloc Logic**: Verifying initial states, loading states, and success/error states.
2.  **Repository/UseCases**: Mocking data sources to test data flow.

To run the tests, execute the following command in the terminal:

```bash
flutter test
```

## <a name="apk-link"></a> APK Link
You can download the compiled release APK to test the application directly on an Android device:

[Download APK Here](# Rick and Morty Wiki - Bigio Takehome Assessment

## <a name="introduction"></a> Introduction
This project is a mobile application built with **Flutter** that allows users to explore characters from the Rick and Morty universe. The application implements **Clean Architecture** to ensure separation of concerns, scalability, and testability.

Users can view a list of characters, search for specific names, view detailed information, and save their favorite characters locally using a SQLite database. The project also includes Unit Tests for the State Management layer.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Tech Stack & Libraries](#libraries)
- [Project Architecture](#project-structures)
- [Unit Testing](#unit-testing)
- [APK Link](#apk-link)

## <a name="features"></a> Features
- **Character List**: Displays a paginated list of characters fetched from the Rick and Morty API.
- **Search Feature**: Real-time search functionality with debounce to find specific characters.
- **Character Detail**: View detailed attributes of a character (Status, Species, Gender, Origin, Location).
- **Favorite System**: Save and remove characters from a local database (SQLite/Sqflite).
- **Offline Support**: Access saved favorite characters even without an internet connection.
- **Error Handling**: Proper error messages for Server Failures or Database Failures.

## <a name="libraries"></a> Tech Stack & Libraries
This project uses the following libraries and tools:

- **Framework**: Flutter (Dart)
- **Architecture**: Clean Architecture (Data, Domain, Presentation)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Networking**: [http](https://pub.dev/packages/http)
- **Local Database**: [sqflite](https://pub.dev/packages/sqflite) & [path](https://pub.dev/packages/path)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Functional Programming**: [dartz](https://pub.dev/packages/dartz) (For `Either<Failure, Type>` handling)
- **Testing**:
  - [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
  - [mockito](https://pub.dev/packages/mockito) (Mocking dependencies)
  - [build_runner](https://pub.dev/packages/build_runner) (Code generation)

## <a name="project-structures"></a> Project Structure
The project follows a **Feature-First Clean Architecture** structure:

```text
lib/
├── core/                   # Core functionality (Error handling, Utils, Constants)
│   ├── error/              # Failures & Exceptions
│   ├── usecases/           # Base UseCase class
│   └── utils/              # RequestState enum, constants
├── features/
│   └── character/          # Feature: Character
│       ├── data/           # Data Layer
│       │   ├── datasources/    # Remote (API) & Local (SQLite) Data Sources
│       │   ├── models/         # JSON/DB Models (extends Entity)
│       │   └── repositories/   # Repository Implementation
│       ├── domain/         # Domain Layer (Business Logic)
│       │   ├── entities/       # Core Business Objects
│       │   ├── repositories/   # Repository Interfaces (Contracts)
│       │   └── usecases/       # Logic for specific actions (Get, Search, Toggle Fav)
│       └── presentation/   # Presentation Layer (UI)
│           ├── pages/          # Screens (Home, Detail, Search, Favorite)
│           ├── provider/       # State Management (ChangeNotifier)
│           └── widgets/        # Reusable Widgets
├── injection_container.dart # Dependency Injection Setup (Service Locator)
└── main.dart               # Entry point
```

## <a name="unit-testing"></a> Unit Testing
This project includes Unit Tests to ensure the reliability of the business logic and state management. The tests cover:
1.  **Provider Logic**: Verifying initial states, loading states, and success/error states (ChangeNotifier).
2.  **Mocking**: Using Mockito with **Manual Mocking** strategy to simulate UseCase responses without hitting the actual API/Database.

To run the tests, execute the following command in the terminal:

```bash
flutter test
```

## <a name="apk-link"></a> APK Link
You can download the compiled release APK to test the application directly on an Android device:

[Download APK Here](https://drive.google.com/drive/folders/1PtK5UVl5r73DRUdKdrTOQ0EiOxNmfYzj?usp=sharing)
