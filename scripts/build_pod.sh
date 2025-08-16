#!/usr/bin/env bash
set -euo pipefail

# Build the Flutter iOS frameworks and engine podspec for CocoaPods consumption.
# Usage: ./scripts/build_pod.sh [release|profile|debug]

MODE=${1:-release}
case "$MODE" in
  release)
    DEBUG_FLAG=--no-debug
    PROFILE_FLAG=--no-profile
    ;;
  profile)
    DEBUG_FLAG=--no-debug
    PROFILE_FLAG=--profile
    ;;
  debug)
    DEBUG_FLAG=--debug
    PROFILE_FLAG=--no-profile
    ;;
  *)
    echo "Unknown mode: $MODE" >&2
    exit 1
    ;;
esac

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT_DIR"

flutter pub get
flutter build ios-framework --output=./build/ios-framework --cocoapods ${DEBUG_FLAG} ${PROFILE_FLAG}

echo
echo "Artifacts:"
ls -la build/ios-framework || true
if [ -d build/ios-framework ]; then
  ls -la build/ios-framework
else
  echo "Directory build/ios-framework does not exist."
fi
if [ -d build/ios-framework/Release ]; then
  ls -la build/ios-framework/Release
else
  echo "Directory build/ios-framework/Release does not exist."
fi

echo
echo "Done. Point your host app Podfile to:"
echo "  pod 'Flutter', :podspec => File.join('<path-to-FlutNFeel>', 'build', 'ios-framework', 'Release', 'Flutter.podspec')"
echo "  pod 'FlutNFeel', :path => '<path-to-FlutNFeel>'"
