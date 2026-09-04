import 'vision/ml_vision.dart';

/// Entry point of the package.
///
/// Use [CameraProcess.vision] to obtain the available detectors, such as
/// [Vision.textDetector] and [Vision.faceDetector].
class CameraProcess {
  CameraProcess._();

  /// The singleton [Vision] instance used to create detectors.
  static final Vision vision = Vision.instance;
}
