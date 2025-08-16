#!/usr/bin/env bash
set -euo pipefail

# Build the Flutter iOS frameworks and engine podspec for CocoaPods consumption.
# Usage: ./scripts/build_pod.sh [release|profile|debug|all]
# If no mode is specified, builds all modes.

MODE=${1:-all}

build_mode() {
  local mode=$1
  local debug_flag=$2
  local profile_flag=$3
  
  echo "🔨 Building $mode mode..."
  flutter build ios-framework --output=./build/ios-framework --cocoapods ${debug_flag} ${profile_flag}
  
  echo "✅ $mode build completed"
  echo
}

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT_DIR"

flutter pub get

case "$MODE" in
  release)
    build_mode "release" "--no-debug" "--no-profile"
    ;;
  profile)
    build_mode "profile" "--no-debug" "--profile"
    ;;
  debug)
    build_mode "debug" "--debug" "--no-profile"
    ;;
  all)
    echo "🚀 Building all modes (release, profile, debug)..."
    echo
    build_mode "release" "--no-debug" "--no-profile"
    build_mode "profile" "--no-debug" "--profile"
    build_mode "debug" "--debug" "--no-profile"
    echo "🎉 All builds completed successfully!"
    ;;
  *)
    echo "Unknown mode: $MODE" >&2
    echo "Usage: $0 [release|profile|debug|all]" >&2
    exit 1
    ;;
esac

echo
echo "📦 Build Artifacts Summary:"
if [ -d build/ios-framework ]; then
  echo "Root directory contents:"
  ls -la build/ios-framework
  echo
  
  for mode_dir in Release Profile Debug; do
    if [ -d "build/ios-framework/$mode_dir" ]; then
      echo "$mode_dir directory contents:"
      ls -la "build/ios-framework/$mode_dir"
      echo
    fi
  done
else
  echo "❌ Directory build/ios-framework does not exist."
fi

echo
echo "📋 Integration Instructions:"
echo "Add to your host app's Podfile:"
echo
if [ "$MODE" = "all" ]; then
  echo "For Release mode:"
  echo "  pod 'Flutter', :podspec => File.join('<path-to-FlutNFeel>', 'build', 'ios-framework', 'Release', 'Flutter.podspec')"
  echo
  echo "For Profile mode:"
  echo "  pod 'Flutter', :podspec => File.join('<path-to-FlutNFeel>', 'build', 'ios-framework', 'Profile', 'Flutter.podspec')"
  echo
  echo "For Debug mode:"
  echo "  pod 'Flutter', :podspec => File.join('<path-to-FlutNFeel>', 'build', 'ios-framework', 'Debug', 'Flutter.podspec')"
  echo
  echo "And add the FlutNFeel module:"
  echo "  pod 'FlutNFeel', :path => '<path-to-FlutNFeel>'"
else
  echo "  pod 'Flutter', :podspec => File.join('<path-to-FlutNFeel>', 'build', 'ios-framework', '$MODE', 'Flutter.podspec')"
  echo "  pod 'FlutNFeel', :path => '<path-to-FlutNFeel>'"
fi
echo
