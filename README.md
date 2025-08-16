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

## Add to the host app Podfile
If you want to embed this Flutter module in a native iOS app via CocoaPods
In the iOS app’s `Podfile`:

```ruby
platform :ios, '13.0'
use_frameworks!

# Point to the generated Flutter engine podspec produced in Step 1.
pod 'Flutter', :podspec => File.join(__dir__, '..', 'FlutNFeel', 'build', 'ios-framework', 'Release', 'Flutter.podspec')

# Add the module pod:
# Option A: Local path
# pod 'FlutNFeel', :path => File.join(__dir__, '..', 'FlutNFeel')

# Option B: Git tag
# pod 'FlutNFeel', :git => 'https://github.com/motojojoe/FlutNFeel.git', :tag => '0.1.0'
```

Then install pods:

```bash
cd ios
pod install
```

Open `YourApp.xcworkspace` and build.

## Initialize Flutter in your app

### UIKit Implementation

Minimal UIKit example using a shared engine:

```swift
import UIKit
import Flutter

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  lazy var flutterEngine = FlutterEngine(name: "flutnfeel_engine")

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    flutterEngine.run()
    GeneratedPluginRegistrant.register(with: flutterEngine) // provided by FlutNFeel pod

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: ViewController())
    window?.makeKeyAndVisible()
    return true
  }
}

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "FlutNFeel Demo"

    let button = UIButton(type: .system)
    button.setTitle("Show Flutter", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  @objc func showFlutter() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let flutterVC = FlutterViewController(engine: appDelegate.flutterEngine, nibName: nil, bundle: nil)
    flutterVC.modalPresentationStyle = .fullScreen
    present(flutterVC, animated: true)
  }
}
```

### SwiftUI Implementation

For SwiftUI apps, you can integrate Flutter using a `UIViewControllerRepresentable`:

```swift
import SwiftUI
import Flutter

@main
struct FlutNFeelApp: App {
  let flutterEngine = FlutterEngine(name: "flutnfeel_engine")
  
  init() {
    flutterEngine.run()
    GeneratedPluginRegistrant.register(with: flutterEngine) // provided by FlutNFeel pod
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(FlutterEngineWrapper(engine: flutterEngine))
    }
  }
}

class FlutterEngineWrapper: ObservableObject {
  let engine: FlutterEngine
  
  init(engine: FlutterEngine) {
    self.engine = engine
  }
}

struct ContentView: View {
  @EnvironmentObject var flutterEngine: FlutterEngineWrapper
  @State private var isFlutterPresented = false
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Text("FlutNFeel Demo")
          .font(.largeTitle)
          .fontWeight(.bold)
        
        Button("Show Flutter") {
          isFlutterPresented = true
        }
        .font(.title2)
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
      }
      .navigationTitle("Home")
    }
    .fullScreenCover(isPresented: $isFlutterPresented) {
      FlutterViewControllerWrapper(engine: flutterEngine.engine)
    }
  }
}

struct FlutterViewControllerWrapper: UIViewControllerRepresentable {
  let engine: FlutterEngine
  
  func makeUIViewController(context: Context) -> FlutterViewController {
    let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    return flutterViewController
  }
  
  func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {
    // No updates needed
  }
}

#Preview {
  ContentView()
    .environmentObject(FlutterEngineWrapper(engine: FlutterEngine()))
}
```

`App.xcframework` already contains `flutter_assets`. No extra copy steps are needed.

## How to export as a CocoaPods

To package and ship this Flutter module for iOS consumption via CocoaPods ("ship Flutter as a pod"), follow the step-by-step guide here:

- See: [EXPORT_COCOAPODS.md](EXPORT_COCOAPODS.md)

That guide covers:
- Building iOS .xcframeworks and generating the Flutter engine podspec.
- Choosing a distribution strategy (local path vs. git tag vs. binary).
- Wiring your host app’s Podfile and initializing Flutter (engine + view controller).
- Rebuilding on changes and common troubleshooting tips.
