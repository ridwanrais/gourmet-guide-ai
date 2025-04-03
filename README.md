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

## 🛠️ Troubleshooting

### Android Build Issues

#### NDK Configuration Errors
If you encounter NDK-related errors during Android build, follow these steps:

1. Update the NDK version in `android/app/build.gradle.kts`:
   ```kotlin
   android {
       namespace = "com.example.gofood_ai"
       compileSdk = 35
       
       compileOptions {
           sourceCompatibility = JavaVersion.VERSION_11
           targetCompatibility = JavaVersion.VERSION_11
       }

       kotlinOptions {
           jvmTarget = JavaVersion.VERSION_11.toString()
       }

       defaultConfig {
           applicationId = "com.example.gofood_ai"
           minSdk = 21
           targetSdk = 35
           versionCode = 1
           versionName = "1.0"

           ndk {
               abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
           }
       }
   }
   ```

2. Clean and rebuild the project:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

#### Device Connection Issues

1. Ensure USB Debugging is enabled on your Android device:
   - Go to Settings > About phone
   - Tap "Build number" 7 times to enable Developer Options
   - Go to Settings > Developer options
   - Enable "USB debugging"

2. Connect your device via USB and accept the USB debugging prompt

3. Verify device connection:
   ```bash
   adb devices
   ```

4. If using wireless debugging:
   - Enable "Wireless debugging" in Developer Options
   - Use the QR code method or IP address method to pair your device
   - Run the app with the device ID:
     ```bash
     flutter run -d <DEVICE_ID>
     ```
     
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
