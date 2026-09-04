import 'package:camera_process/camera_process.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Vision factory', () {
    test('CameraProcess.vision is the Vision singleton', () {
      expect(CameraProcess.vision, same(Vision.instance));
    });

    test('creates a TextDetector', () {
      expect(CameraProcess.vision.textDetector(), isA<TextDetector>());
    });

    test('creates a FaceDetector', () {
      expect(CameraProcess.vision.faceDetector(), isA<FaceDetector>());
    });
  });

  group('InputImageFormat', () {
    test('maps to the expected native raw values', () {
      expect(InputImageFormat.NV21.rawValue, 17);
      expect(InputImageFormat.YV12.rawValue, 842094169);
      expect(InputImageFormat.YUV_420_888.rawValue, 35);
      expect(InputImageFormat.YUV420.rawValue, 875704438);
      expect(InputImageFormat.BGRA8888.rawValue, 1111970369);
    });

    test('round-trips through fromRawValue', () {
      for (final format in InputImageFormat.values) {
        expect(
          InputImageFormatMethods.fromRawValue(format.rawValue),
          format,
        );
      }
    });

    test('returns null for an unknown raw value', () {
      expect(InputImageFormatMethods.fromRawValue(-1), isNull);
    });
  });

  group('InputImageRotation', () {
    test('maps to degrees', () {
      expect(InputImageRotation.Rotation_0deg.rawValue, 0);
      expect(InputImageRotation.Rotation_90deg.rawValue, 90);
      expect(InputImageRotation.Rotation_180deg.rawValue, 180);
      expect(InputImageRotation.Rotation_270deg.rawValue, 270);
    });

    test('round-trips through fromRawValue', () {
      for (final rotation in InputImageRotation.values) {
        expect(
          InputImageRotationMethods.fromRawValue(rotation.rawValue),
          rotation,
        );
      }
    });
  });

  group('FaceDetectorOptions', () {
    test('has sensible defaults', () {
      const options = FaceDetectorOptions();
      expect(options.enableClassification, isFalse);
      expect(options.enableLandmarks, isFalse);
      expect(options.enableContours, isFalse);
      expect(options.enableTracking, isFalse);
      expect(options.minFaceSize, 0.1);
      expect(options.mode, FaceDetectorMode.fast);
    });

    test('asserts minFaceSize is within [0, 1]', () {
      expect(() => FaceDetectorOptions(minFaceSize: -0.1), throwsAssertionError);
      expect(() => FaceDetectorOptions(minFaceSize: 1.1), throwsAssertionError);
    });
  });

  group('InputImageData', () {
    test('serializes its metadata', () {
      final data = InputImageData(
        size: const Size(640, 480),
        imageRotation: InputImageRotation.Rotation_90deg,
        inputImageFormat: InputImageFormat.NV21,
        planeData: [InputImagePlaneMetadata(bytesPerRow: 100)],
      );

      final map = data.getMetaData();

      expect(map['width'], 640.0);
      expect(map['height'], 480.0);
      expect(map['rotation'], 90);
      expect(map['imageFormat'], 17);
      expect((map['planeData'] as List).single['bytesPerRow'], 100);
    });
  });
}
