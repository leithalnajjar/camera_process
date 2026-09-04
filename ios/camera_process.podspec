#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint camera_process.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'camera_process'
  s.version          = '1.1.0'
  s.summary          = 'On-device face detection and text recognition for Flutter, powered by Google ML Kit.'
  s.description      = <<-DESC
On-device face detection and text recognition for Flutter, powered by Google ML Kit.
Process still images or a live camera stream on Android and iOS.
                       DESC
  s.homepage         = 'https://github.com/leithalnajjar/camera_process'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Leith Alnajjar' => 'leith.najjar@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform                = :ios, '10.0'
  s.ios.deployment_target   = '10.0'
  s.static_framework = true
  # ML Kit vision
  s.dependency 'GoogleMLKit/FaceDetection', '~> 2.2.0'
  s.dependency 'GoogleMLKit/TextRecognition', '~> 2.2.0'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
