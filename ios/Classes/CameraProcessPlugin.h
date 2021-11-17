#import <Flutter/Flutter.h>

@interface CameraProcessPlugin : NSObject<FlutterPlugin>
@property(nonatomic, readwrite) NSMutableDictionary *handlers;
@end



@interface CameraProcessVisionImage(FlutterPlugin)
+ (CameraProcessVisionImage *)visionImageFromData:(NSDictionary *)imageData;
@end

@protocol Handler
@required
- (NSArray*)getMethodsKeys;
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;
@optional
@end

@interface FaceDetector : NSObject <Handler>
@end

@interface TextRecognizer : NSObject <Handler>
@end


static FlutterError *getFlutterError(NSError *error) {
    return [FlutterError errorWithCode:[NSString stringWithFormat:@"Error %d", (int)error.code]
                               message:error.domain
                               details:error.localizedDescription];
}
