# Rick and Morty Wiki - Bigio Takehome Assessment

## <a name="introduction"></a> Introduction
This Android application was developed as a submission for the **BIGIO Mobile Dev Take Home Challenge**. In strict accordance with the technical requirements, this project is built applying **Clean Architecture** principles and modern mobile development best practices to ensure scalability and testability.

The application utilizes the **Rick and Morty REST API** to fetch and display data, featuring the following mandatory components:
* **Home Page**: Displays a list of characters.
* **Detail Page**: Shows detailed information (=name, species, gender, origin, location, and image) for a selected character.
* **Search Page**: Allows users to perform real-time searches for characters by name.
* **State Management**: Comprehensively handles all UI states, including *loading*, *loaded*, *error*, and *empty*.

To exceed the basic requirements, this project also implements the suggested additional features:
* **Local Database (SQLite)**: A feature to add and remove characters from a local "Favorites" list.
* **Unit Testing**: Implementation of unit tests for business logic and state management.

This project demonstrates clean, structured code, proper indentation, and efficient resource management.

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
- **Character Detail**: View detailed attributes of a character (Photo, Species, Gender, Origin, Location).
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
- **Testing**:
  - [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
  - [mockito](https://pub.dev/packages/mockito) (Mocking dependencies)

## <a name="project-structures"></a> Project Structure
The project follows a **Feature-First Clean Architecture** structure:

```text
lib/
├── core/                   # Core functionality
│   ├── constants/          # Application Constants (API Endpoints, Routes, Assets)
│   ├── error/              # Failures (Failure classes) & Exceptions
│   └── utils/              # RequestState Enum, Extensions, Common Helpers
├── features/
│   └── character/          # Feature: Character
│       ├── data/           # Data Layer (Remote/Local Data)
│       │   ├── datasources/    # RemoteDataSource & LocalDataSource
│       │   ├── models/         # API Response & DB Models (extends Entity)
│       │   └── repositories/   # Repository Implementation
│       ├── domain/         # Domain Layer (Pure Business Logic)
│       │   ├── entities/       # Core Business Objects
│       │   ├── repositories/   # Repository Interfaces (Contracts)
│       │   └── usecases/       # UseCases (GetCharacters, SearchCharacters, etc.)
│       └── presentation/   # Presentation Layer (UI)
│           ├── pages/          # Screens (Home, Detail, Search)
│           └── provider/       # State Management (ChangeNotifier)
├── injection_container.dart # Dependency Injection Setup (GetIt)
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
## Test result preview
<img width="1920" height="1080" alt="Screenshot (193)" src="https://github.com/user-attachments/assets/14e1b34a-19ac-4e29-93f4-ae4757ad5b74" />


## <a name="apk-link"></a> APK Link
You can download the compiled release APK to test the application directly on an Android device:

[Download APK Here](https://drive.google.com/drive/folders/1PtK5UVl5r73DRUdKdrTOQ0EiOxNmfYzj?usp=sharing)
