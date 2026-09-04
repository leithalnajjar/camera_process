/// On-device face detection and text recognition for Flutter, powered by
/// Google ML Kit.
///
/// The entry point is [CameraProcess]. Obtain a detector from
/// [CameraProcess.vision], build an [InputImage], and call `processImage`:
///
/// ```dart
/// final detector = CameraProcess.vision.textDetector();
/// final result = await detector.processImage(
///   InputImage.fromFilePath('/path/to/image.jpg'),
/// );
/// await detector.close();
/// ```
library;

export 'src/camera_process.dart';
export 'src/vision/vision.dart';
