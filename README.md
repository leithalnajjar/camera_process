# camera_process

[![pub package](https://img.shields.io/pub/v/camera_process.svg)](https://pub.dev/packages/camera_process)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![platform](https://img.shields.io/badge/platform-android%20%7C%20ios-blue.svg)](https://pub.dev/packages/camera_process)

On-device **face detection** and **text recognition** for Flutter, powered by
[Google ML Kit](https://developers.google.com/ml-kit). Works on still images and
on a live camera stream, fully offline, on both Android and iOS.

## Donation

If this package helps you, consider supporting its development:

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://ko-fi.com/alnajjar)

## Features

| Feature                                                                          | Android | iOS |
|----------------------------------------------------------------------------------|:-------:|:---:|
| [Text Recognition](https://developers.google.com/ml-kit/vision/text-recognition) |    ✅    |  ✅  |
| [Face Detection](https://developers.google.com/ml-kit/vision/face-detection)     |    ✅    |  ✅  |

- Runs entirely **on-device** — no network calls, no API keys.
- Detect faces with landmarks, contours, head angles, and smile / eyes-open probabilities.
- Recognize text as a hierarchy of blocks → lines → elements, each with bounding boxes.
- Feed it a file, a `File`, or raw camera bytes.

## Requirements

### Android

- `minSdkVersion` 21
- `compileSdkVersion` 34

### iOS

- Minimum deployment target: iOS 10.0
- Uses CocoaPods (see the [Swift Package Manager](#swift-package-manager) note below)

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  camera_process: ^1.1.0
```

Then run:

```bash
flutter pub get
```

### Permissions

This plugin does not request permissions itself — declare the ones your app uses.

**Android** (`android/app/src/main/AndroidManifest.xml`):

```xml
<uses-permission android:name="android.permission.CAMERA" />
```

**iOS** (`ios/Runner/Info.plist`):

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to detect faces and text.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to process selected images.</string>
```

## Usage

### Text recognition

```dart
import 'package:camera_process/camera_process.dart';

final textDetector = CameraProcess.vision.textDetector();

final inputImage = InputImage.fromFilePath('/path/to/image.jpg');
final RecognisedText recognisedText = await textDetector.processImage(inputImage);

print(recognisedText.text);
for (final block in recognisedText.blocks) {
  for (final line in block.lines) {
    print('${line.text} @ ${line.rect}');
  }
}

// Release native resources when done.
await textDetector.close();
```

### Face detection

```dart
import 'package:camera_process/camera_process.dart';

final faceDetector = CameraProcess.vision.faceDetector(
  const FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ),
);

final inputImage = InputImage.fromFilePath('/path/to/image.jpg');
final List<Face> faces = await faceDetector.processImage(inputImage);

for (final face in faces) {
  print('Face at ${face.boundingBox}');
  print('Smiling: ${face.smilingProbability}');
}

await faceDetector.close();
```

### Building an `InputImage`

```dart
// From a file path
InputImage.fromFilePath('/path/to/image.jpg');

// From a dart:io File
InputImage.fromFile(file);

// From raw camera-stream bytes
InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
```

For a complete real-time example (live camera stream + gallery), including drawing
the results with a `CustomPainter`, see the [`example/`](example/lib/main.dart) app.

## Swift Package Manager

Flutter's Swift Package Manager (SPM) support is still gated by this plugin's
native dependency: **Google ML Kit ships as CocoaPods only and has no official SPM
distribution**. Until Google publishes SPM artifacts, the iOS side of this plugin
must be built with CocoaPods.

An SPM scaffold is included at `ios/camera_process/Package.swift.template` and the
migration path is documented in [`ios/SPM.md`](ios/SPM.md) so the package can move
to SPM the moment the ML Kit dependency supports it.

## Contributing

Issues and pull requests are welcome on
[GitHub](https://github.com/leithalnajjar/camera_process/issues).

## License

Released under the [MIT License](LICENSE).
