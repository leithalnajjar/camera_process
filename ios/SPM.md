# Swift Package Manager (SPM) support

## Status: blocked by Google ML Kit

Flutter supports building iOS plugins with Swift Package Manager, but this plugin
cannot fully adopt SPM yet.

**Reason:** the native implementation depends on `GoogleMLKit/FaceDetection` and
`GoogleMLKit/TextRecognition`. Google distributes ML Kit through **CocoaPods
only** — there is no official Swift Package for it. An SPM manifest that declares
those products would fail to resolve, so the iOS side must keep using CocoaPods
(`ios/camera_process.podspec`) for now.

## What ships today

- `ios/camera_process.podspec` — the working CocoaPods integration.
- `ios/camera_process/Package.swift.template` — an inactive SPM scaffold. It is
  deliberately not named `Package.swift`, so Flutter's SPM detection ignores it
  and continues to use CocoaPods.

## Migration checklist (when ML Kit ships SPM)

1. Rename `ios/camera_process/Package.swift.template` to
   `ios/camera_process/Package.swift`.
2. Add the Google ML Kit SPM package to the `dependencies` array.
3. Link the `FaceDetection` and `TextRecognition` products in the target.
4. Move the public headers under `Classes/include/camera_process/` (SPM expects a
   `publicHeadersPath`), or migrate the ObjC sources to a modular layout.
5. Run `flutter build ios` with SPM enabled and `pod lib lint` to confirm both
   integrations still work.
6. Update `README.md` to remove the SPM limitation note.

Track ML Kit SPM support upstream before starting this migration.
