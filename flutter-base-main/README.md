# MyEshop — Flutter Base Code

> A production-ready Flutter base code project showcasing Clean Architecture, modular structure, and best practices.

| | |
|---|---|
| **Flutter** | 3.44.5 (stable) |
| **Dart SDK** | >= 3.8.0 < 4.0.0 |
| **State Management** | BLoC |
| **License** | MIT |

---

## Overview

**MyEshop** is a Flutter base code / starter project that demonstrates a scalable and maintainable application architecture. It serves as a reference implementation for building production-grade Flutter applications using Clean Architecture principles.

The project integrates with the [DummyJSON API](https://dummyjson.com/) as a sample data source, providing working examples of product listing and product detail features.

---

## Architecture

This project follows the **Clean Architecture** pattern, separating concerns into three distinct layers:

| Layer | Responsibility |
|---|---|
| **Presentation** | UI Screens, BLoC (State Management), State classes |
| **Domain** | Entities, UseCases, Repository Interfaces (contracts) |
| **Data** | Models, DataSource, Repository Implementations, API, Mapper |

### Key Principles

- **Separation of Concerns** — Each layer has a well-defined responsibility.
- **Dependency Inversion** — Inner layers don't depend on outer layers.
- **Testability** — Business logic is isolated from UI and framework dependencies.
- **Modularity** — Features are organized as independent modules.

---

## Project Structure

```
lib/
├── config/                       # Environment configuration
├── coreapp/                      # Core application layer
│   ├── data/
│   │   ├── api/                  # Retrofit API service & static endpoints
│   │   └── datasource/           # Network & local data sources
│   ├── di/                       # Dependency injection (GetIt)
│   ├── helpers/                  # Base state, base BLoC, utilities
│   └── presentation/             # Shared UI components
├── helpers/                      # Global helper extensions
├── l10n/                         # Localization (ARB: en & id)
├── modules/                      # Feature modules
│   ├── auth/                     # Authentication (Sign In, Session)
│   ├── home/                     # Home screen
│   ├── main/                     # Main screen (Bottom navigation)
│   ├── product/                  # Product list & detail
│   ├── account/                  # Account / profile
│   └── root/                     # Shared domain layer
├── navigation/                   # GoRouter routing & navigation
│   └── routers/                  # Feature-specific route classes
├── style/                        # Theme, colors, custom styles
├── main.dart                     # Entry point (dev)
└── main_prod.dart                # Entry point (production)
```

### Feature Module Structure

Each feature module follows this internal structure:

```
module_name/
├── data/
│   ├── models/                   # Request/response models
│   ├── datasource/               # Data source implementations
│   ├── mapper/                   # Entity <-> Model mappers
│   └── repository/               # Repository implementations
├── domain/
│   ├── entities/                 # Business entities
│   ├── repository/               # Repository interfaces
│   └── usecases/                 # Use cases (business logic)
├── di/                           # Module-level DI
└── presentation/
    ├── bloc/                     # BLoC + Event + State
    └── ui/                       # Screen widgets
```

---

## Tech Stack

| Category | Library | Version |
|---|---|---|
| State Management | [flutter_bloc](https://pub.dev/packages/flutter_bloc) | ^9.1.1 |
| Navigation | [go_router](https://pub.dev/packages/go_router) | ^17.3.0 |
| Dependency Injection | [get_it](https://pub.dev/packages/get_it) | ^9.2.1 |
| Network / HTTP | [dio](https://pub.dev/packages/dio) | ^5.10.0 |
| REST Client | [retrofit](https://pub.dev/packages/retrofit) | ^4.9.2 |
| JSON Serialization | [json_annotation](https://pub.dev/packages/json_annotation) + [json_serializable](https://pub.dev/packages/json_serializable) | ^4.12.0 / ^6.8.0 |
| Localization | Flutter built-in `flutter_localizations` + ARB files | — |
| Environment Config | [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) | ^6.0.1 |
| Code Generation | [build_runner](https://pub.dev/packages/build_runner) | ^2.15.1 |
| Shimmer Loading | [shimmer](https://pub.dev/packages/shimmer) | ^3.0.0 |
| Equatable | [equatable](https://pub.dev/packages/equatable) | ^2.0.5 |

---

## API Reference

This project uses the **[DummyJSON API](https://dummyjson.com/)** as a sample data source.

| Feature | Endpoint | Screen |
|---|---|---|
| Product List | `GET /products?limit=&skip=` | Home Screen (paginated list) |
| Product Detail | `GET /products/{id}` | Product Detail Screen |

> **Note:** The login feature uses **dummy/hardcoded credentials** pre-filled in the sign-in form. It does not connect to any authentication API.

---

## Getting Started

### Prerequisites

- Flutter SDK >= 3.44.5 (stable channel)
- Dart SDK >= 3.8.0

### 1. Setup Environment File

Create the environment file at `assets/env/.env.dev` with the following content:

```env
ENV_TYPE=development
API_URL=https://dummyjson.com/
```

> For production, create `assets/env/.env.prod` with the appropriate values.

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run Code Generation

This project uses `build_runner` for Retrofit API client and JSON model code generation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Or use watch mode for continuous generation during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### 4. Generate Localization Files

Localization is handled via Flutter's built-in `gen-l10n`. The ARB source files are located in `lib/l10n/`:

```bash
flutter gen-l10n
```

### 5. Run the App

```bash
# Development
flutter run

# Production
flutter run --target lib/main_prod.dart
```

---

## Environment Configuration

The app supports multiple environments via `.env` files stored in `assets/env/`:

| Variable | Description | Example |
|---|---|---|
| `ENV_TYPE` | Environment identifier | `development` or `production` |
| `API_URL` | Base URL for all API requests | `https://dummyjson.com/` |

These files are loaded at runtime using `flutter_dotenv`.

---

## Navigation

The app uses **GoRouter** with a centralized redirect system:

- **RootNavigationHelper** — Singleton managing `GoRouter` instance with auth-aware redirect logic.
- **Route Classes** — Each feature has its own `GoRoute` subclass (e.g., `SignInRoute`, `HomeRoute`, `ProductDetailRoute`).
- **Auth Guard** — Protected routes (History, Account, Cart) automatically redirect unauthenticated users to Sign In, then return them to the intended destination after successful login.
- **Callback-based Navigation** — UI screens receive navigation callbacks via constructor injection, keeping them decoupled from routing logic.

---

## Localization

Supported languages:

| Code | Language |
|---|---|
| `id` | Indonesian (Bahasa Indonesia) |
| `en` | English |

ARB files are located in `lib/l10n/`. To add a new language, create a new `app_xx.arb` file and register the locale in `common_locale.dart`.

---

## Available Commands

| Command | Description |
|---|---|
| `flutter pub get` | Install dependencies |
| `dart run build_runner build -d` | Code generation (Retrofit, JSON) |
| `dart run build_runner watch -d` | Watch mode code generation |
| `flutter gen-l10n` | Generate localization files |
| `flutter analyze` | Analyze code for issues |
| `flutter test` | Run unit tests |
| `dart run flutter_launcher_icons` | Generate launcher icons |
| `dart run flutter_native_splash:create` | Generate native splash screen |
| `flutter run` | Run app (dev) |
| `flutter run --target lib/main_prod.dart` | Run app (production) |

---


