# FlutNFeel
A simple yet powerful Flutter example project showcasing clean architecture, modular code structure, and integration with popular packages. This repository is designed to help developers quickly understand and implement common Flutter features in a maintainable way.

## Features

- App Store-style homepage displaying featured items using a scrollable list of cards.
- Responsive layout that adapts to mobile, tablet, and web screens.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable version)
- For iOS development: Xcode 15.0 or later
- For Android development: Android Studio

### iOS Development Setup

To run this project on iOS devices or simulators, follow these steps:

#### 1. Install Dependencies

Make sure you have the required tools installed:

```bash
# Install Xcode from App Store (required for iOS development)
# Install Bundler for Ruby dependency management
gem install bundler
```

#### 2. Set up iOS Dependencies

Navigate to the iOS directory and install dependencies:

```bash
cd ios
bundle install          # Install Ruby gems (including CocoaPods)
bundle exec pod install # Install iOS dependencies
cd ..
```

#### 3. Open in Xcode (Optional)

You can open the iOS project in Xcode for advanced configuration:

```bash
open ios/Runner.xcworkspace
```

#### 4. Run on iOS

```bash
# List available iOS simulators
flutter devices

# Run on iOS simulator
flutter run -d "iPhone 15 Pro"

# Run on connected iOS device
flutter run -d ios
```

### Running the App

Ensure you have the Flutter SDK installed, then run:

```bash
flutter run
```

This will launch the example app on your chosen device or emulator. The project
supports iOS, iPadOS, Android, and web targets; select your desired platform
with `-d` followed by the device id (for example `-d chrome` for web).
