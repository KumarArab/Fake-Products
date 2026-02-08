# Tamara Products - Flutter Interview Project

Welcome to the Tamara Flutter Interview! 🚀

This is a base project set up with the dependencies you'll need for the coding session.

---

## 📋 Prerequisites

- macOS, Windows, or Linux
- IDE with Flutter support (VS Code, Android Studio, or Cursor)
- A running emulator or physical device

---

## 🛠️ Setup Instructions

### Step 1: Install FVM (Flutter Version Management)

FVM is used to manage Flutter SDK versions. This project uses **Flutter 3.38.1**.

#### macOS (using Homebrew)
```bash
brew tap leoafarias/fvm
brew install fvm
```

#### macOS/Linux (using pub)
```bash
dart pub global activate fvm
```

#### Windows (using Chocolatey)
```bash
choco install fvm
```

#### Windows (using pub)
```bash
dart pub global activate fvm
```

> **Note**: If using `dart pub global activate`, make sure `~/.pub-cache/bin` is in your PATH.

### Step 2: Install Flutter SDK via FVM

Navigate to the project directory and install the required Flutter version:

```bash
cd flutter_project
fvm install 3.38.1
fvm use 3.38.1
```

### Step 3: Install Dependencies

```bash
fvm flutter pub get
```

### Step 4: Verify Setup

```bash
fvm flutter --version
```

You should see:
```
Flutter 3.38.1 • channel stable
```

---

## 🚀 Running the App

### Run on Emulator/Device
```bash
fvm flutter run
```

### Run Tests
```bash
fvm flutter test
```

---

## 📁 Project Structure

```
lib/
├── main.dart                           # App entry point
└── packages/
    ├── core/
    │   ├── network/                    # API client & networking
    │   │   ├── api_client.dart
    │   │   ├── api_exception.dart
    │   │   ├── api_response.dart
    │   │   └── network.dart            # Barrel export
    │   ├── logger/                     # Logging utilities
    │   │   ├── app_logger.dart
    │   │   └── logger.dart             # Barrel export
    │   └── analytics/                  # Analytics service
    │       ├── analytics_service.dart
    │       └── analytics.dart          # Barrel export
    └── design/
        └── design_system/              # Design tokens & components
            ├── tokens/
            │   ├── app_colors.dart
            │   └── app_spacing.dart
            └── design_system.dart      # Barrel export

test/
└── widget_test.dart
```

---

## 📦 Available Dependencies

### State Management
- `flutter_bloc` - BLoC pattern for state management
- `equatable` - Value equality for BLoC states/events

### Dependency Injection
- `get_it` - Service locator for DI

### Networking
- `dio` - HTTP client for API calls

### UI
- `cached_network_image` - Image caching and loading

### Testing
- `bloc_test` - Testing utilities for BLoC
- `mocktail` - Mocking library for tests

---

## 🔌 API Information

### Base URL
```
https://fakestoreapi.com
```

### Get All Products
```
GET /products
```

### Sample Response
```json
[
  {
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack",
    "price": 109.95,
    "description": "Your perfect pack for everyday use...",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "rating": {
      "rate": 3.9,
      "count": 120
    }
  }
]
```

---

## 🧮 Murabaha Calculation

You need to implement the installment calculation based on the Murabaha model:

```
Profit Margin = 12% (fixed)
Total Profit = Original Price × Profit Margin
Total Payable = Original Price + Total Profit
Monthly Installment = Total Payable / Number of Installments
```

**Installment Range:** 2-12 months

---

## 🛠️ Pre-built Packages

### Network Layer
```dart
import 'package:flutter_project/packages/core/network/network.dart';

final apiClient = ApiClient(Dio());
final response = await apiClient.get('/products');
```

### Logger
```dart
import 'package:flutter_project/packages/core/logger/logger.dart';

AppLogger.info('User action completed');
AppLogger.debug('API Response: $data');
AppLogger.error('Failed to load', error: e, stackTrace: st);
```

### Analytics
```dart
import 'package:flutter_project/packages/core/analytics/analytics.dart';

AnalyticsService.instance.trackScreenView('ProductList');
AnalyticsService.instance.trackEvent('product_selected', parameters: {'id': 1});
```

### Design System
```dart
import 'package:flutter_project/packages/design/design_system/design_system.dart';

// Colors
Container(color: AppColors.primary);

// Spacing
Padding(padding: EdgeInsets.all(AppSpacing.md));
```

---

## ✅ Your Task

Build a **Product Catalog Screen** with:

1. ✅ Product list fetched from the API
2. ✅ Search functionality to filter products
3. ✅ Installment selector (2-12 months) in each product item
4. ✅ Real-time monthly payment calculation
5. ✅ Proper state management with BLoC
6. ✅ Error and loading state handling

See `Flutter-interview.md` for detailed requirements.

---

## 💡 Tips

- Use the provided packages in `lib/packages/`
- Set up dependency injection using `get_it`
- Focus on clean architecture and proper state management
- Don't forget to handle keyboard behavior with input fields in the list
- Always use `fvm flutter` instead of `flutter` commands

---

## 🤖 AI IDE Usage

Feel free to use AI-powered IDE features for:
- Generating boilerplate code (models, BLoC, widgets)
- Implementing UI components
- Writing tests
- Debugging and refactoring

---

## ⚠️ Troubleshooting

### FVM not found
Make sure FVM is installed and in your PATH:
```bash
# Check if fvm is installed
fvm --version

# If using pub global, add to PATH
export PATH="$PATH:$HOME/.pub-cache/bin"
```

### Flutter SDK not found
```bash
fvm install 3.38.1
fvm use 3.38.1
```

### Dependencies not resolving
```bash
fvm flutter clean
fvm flutter pub get
```

---

**Good luck! Feel free to ask questions during the session.** 🎉
