Pod::Spec.new do |s|
  s.name             = 'FlutNFeel'
  s.version          = '0.1.0'
  s.summary          = 'FlutNFeel Flutter module for embedding in iOS apps.'
  s.description      = <<-DESC
FlutNFeel is a Flutter UI module packaged for iOS via CocoaPods.
It vends the compiled Flutter App.xcframework and plugin xcframeworks, and includes
GeneratedPluginRegistrant to wire up plugins. The Flutter engine itself is pulled in via
the generated Flutter.podspec (see integration steps in README/COCOAPODS.md).
  DESC
  s.homepage         = 'https://github.com/motojojoe/FlutNFeel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'FlutNFeel Authors' => 'noreply@example.com' }
  s.platform         = :ios, '13.0'

  # If you publish this pod, point to your git repo & tag. When using :path in a Podfile, CocoaPods ignores this.
  s.source           = { :git => 'https://github.com/motojojoe/FlutNFeel.git', :tag => s.version.to_s }

  # Compiled frameworks built with: `flutter build ios-framework --cocoapods --no-debug --no-profile`.
  s.vendored_frameworks = 'build/ios-framework/Release/*.xcframework'

  # Include GeneratedPluginRegistrant so consumers don't need to copy it into their app target.
  s.source_files = 'build/ios-framework/GeneratedPluginRegistrant.{h,m}'
  s.public_header_files = 'build/ios-framework/GeneratedPluginRegistrant.h'

  # Depend on the Flutter engine pod; the consumer Podfile must point CocoaPods to the generated Flutter.podspec.
  s.dependency 'Flutter'

  # CocoaPods will handle embedding/signing of dynamic frameworks.
  s.requires_arc = true
end
