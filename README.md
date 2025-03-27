# Gourmet Guide AI

An AI-powered food recommendation app built with Flutter that suggests meals based on inferred user preferences and location.

## 📱 Features

- **Location Detection**: Auto-detect or manually input user location
- **Natural Language Input**: Enter food preferences in natural language
- **AI-Powered Recommendations**: Get personalized restaurant and meal suggestions
- **Interactive UI**: Modern, conversational interface with smooth animations
- **Detailed Restaurant Cards**: View restaurant information and popular menu items

## 🚀 Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.7.0 or higher)
- [Dart](https://dart.dev/get-dart) (version 3.0.0 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/gofood_ai.git
   cd gofood_ai
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 💻 Development

### Project Structure

```
lib/
├── main.dart           # App entry point
├── models/             # Data models
│   ├── restaurant.dart # Restaurant and food item models
│   └── mock_data.dart  # Mock data for development
├── screens/            # App screens
│   ├── location_screen.dart    # Location selection screen
│   ├── preference_screen.dart  # Food preference input screen
│   └── results_screen.dart     # Restaurant recommendations screen
├── utils/              # Utility functions
│   ├── location_service.dart   # Location services
│   └── theme.dart              # App theme configuration
└── widgets/            # Reusable UI components
    └── restaurant_card.dart    # Restaurant card widget
```

### Running the App

#### On a Physical Device

1. Connect your device via USB and enable USB debugging
2. Run the app:
   ```bash
   flutter run
   ```

#### On an Emulator/Simulator

1. Start your Android emulator or iOS simulator
2. Run the app:
   ```bash
   flutter run
   ```

#### On Web

```bash
flutter run -d chrome
```

### Debugging

#### Hot Reload

During development, you can use hot reload to quickly see changes:
```bash
# While the app is running, press:
r       # Hot reload
R       # Hot restart (if hot reload doesn't work)
```

#### Flutter DevTools

For advanced debugging:
```bash
flutter run --dev-tools
```

#### Logging

The app uses `print` statements for basic logging. For more advanced logging, consider implementing a logging package like `logger`.

## 🔧 Customization

### Theme

You can modify the app's theme in `lib/utils/theme.dart`.

### Mock Data

Currently, the app uses mock data located in `lib/models/mock_data.dart`. Replace this with actual API calls when integrating with a backend.

## 📦 Building for Production

### Android

```bash
flutter build apk --release
# or for app bundle
flutter build appbundle
```

The built APK will be located at `build/app/outputs/flutter-apk/app-release.apk`

### iOS

```bash
flutter build ios --release
```

Then use Xcode to archive and distribute the app.

### Web

```bash
flutter build web --release
```

The built web app will be located in the `build/web` directory.

## 🔄 Backend Integration (Future)

The app is designed to be integrated with:
- **LangGraph** for AI-powered recommendations
- **GoFood Next.js API** for restaurant data

To integrate with the backend:
1. Replace mock data with API calls
2. Implement authentication if needed
3. Add error handling for API requests

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgements

- Flutter team for the amazing framework
- The open-source community for various packages used in this project
