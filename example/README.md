# camera_process_example

Demonstrates the [`camera_process`](https://pub.dev/packages/camera_process)
plugin: on-device **face detection** and **text recognition** on a live camera
stream and on images picked from the gallery.

## What it shows

- A live camera feed processed frame-by-frame.
- Face detection with contours, drawn over the preview with a `CustomPainter`.
- Text recognition with per-block bounding boxes.
- Switching between the front/back camera and the gallery.

## Run it

```bash
cd example
flutter pub get
flutter run
```

Grant camera (and, for the gallery, photo library) permission when prompted.
The manifest / Info.plist entries the plugin needs are documented in the
[package README](../README.md#permissions).
