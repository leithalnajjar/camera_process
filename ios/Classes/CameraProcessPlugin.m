#import "CameraProcessPlugin.h"

@implementation CameraProcessPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"camera_process"
                                     binaryMessenger:[registrar messenger]];
    CameraProcessPlugin* instance = [[CameraProcessPlugin alloc] init];

    // Add vision detectors
    [handlers addObject:[[FaceDetector alloc] init]];
    [handlers addObject:[[TextRecognizer alloc] init]];

    instance.handlers = [NSMutableDictionary new];
    for (id<Handler> detector in handlers) {
        for (NSString *key in detector.getMethodsKeys) {
            instance.handlers[key] = detector;
        }
    }

    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    id<Handler> handler = self.handlers[call.method];
    if (handler != NULL) {
        [handler handleMethodCall:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
