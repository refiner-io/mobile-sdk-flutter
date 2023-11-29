#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint refiner_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'refiner_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Official Flutter wrapper for the Refiner.io Mobile SDK'
  s.description      = <<-DESC
Official Flutter wrapper for the Refiner.io Mobile SDK
                       DESC
  s.homepage         = 'https://refiner.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Refiner' => 'contact@refiner.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'RefinerSDK', "~> 1.3.0"
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.static_framework = true
end
