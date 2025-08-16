# Export FlutNFeel as a CocoaPods Pod (Step by Step)

This guide shows how to ship this Flutter module so iOS apps can consume it via CocoaPods ("ship Flutter as a pod").

## Prerequisites

- macOS with Xcode 15+
- Flutter SDK (stable) installed
- CocoaPods installed (via `gem install cocoapods` or Bundler)

Optional (recommended for iOS folder work):
- Ruby Bundler: `gem install bundler`

## 1) Build iOS frameworks + Flutter engine podspec

From the repo root:

```bash
flutter pub get
flutter build ios-framework --output=./build/ios-framework --cocoapods --no-debug --no-profile
```

This generates:
- `build/ios-framework/Release/App.xcframework` (compiled Dart + assets)
- `build/ios-framework/Release/*.xcframework` (plugins)
- `build/ios-framework/Release/Flutter.podspec` (engine pod)
- `build/ios-framework/GeneratedPluginRegistrant.{h,m}`

Shortcut script:

```bash
./scripts/build_pod.sh release
```

## 2) Choose a distribution strategy

You have three common options:
- Local development: consume via `:path => '/absolute/or/relative/path/to/FlutNFeel'`.
- Git tag: create a tag (e.g., `0.1.0`) and consume via `:git` + `:tag`.
- Binary release: host frameworks externally and update the podspec to point there (advanced).

Note: If using git tags, ensure artifacts are available in the repo or adjust the podspec/source to a binary host.



## 5) Versioning and tagging (if using git distribution)

- Update `s.version` in `FlutNFeel.podspec` (e.g., `0.1.1`).
- Commit and tag the repo:

```bash
git add .
git commit -m "Bump to 0.1.1 and rebuild iOS frameworks"
git tag 0.1.1
git push origin develop --tags
```

- Update host app’s Podfile to the new `:tag` and run `pod install`.

## 6) Rebuilding when Dart code or deps change

Rebuild frameworks and engine podspec:

```bash
./scripts/build_pod.sh release
```

Commit artifacts (if your strategy needs them) and bump the pod version/tag.

## 7) Debugging & notes

- Apple Silicon simulator issues (arm64): some plugins may not support arm64 on the simulator. Workarounds:
  - Exclude arm64 for simulator in the host app build settings, or
  - Test on an actual device, or
  - Ensure plugins include arm64 simulator slices.

- LLDB & attach: If you plan to `flutter attach` for add-to-app debugging, follow Flutter docs to set your scheme’s LLDB init file for Debug builds.

- If CocoaPods can’t find Flutter engine: confirm the `Flutter.podspec` path in the Podfile is correct and built.

- Clean state: `rm -rf ~/Library/Developer/Xcode/DerivedData/*` if Xcode caches cause issues.

- Clean CocoaPods state if needed:

```bash
cd ios
pod deintegrate
pod install
```

## 8) What this pod ships

- `FlutNFeel.podspec`: vends `build/ios-framework/Release/*.xcframework` (App + plugins) and exports `GeneratedPluginRegistrant.h/m`.
- Depends on the `Flutter` pod (engine) via the generated `Flutter.podspec` you point to in the host Podfile.

That’s it — your iOS app can now present Flutter screens using this pod.
