// Autogenerated from Pigeon (v4.1.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PathMovementType) {
  PathMovementTypeMove = 0,
  PathMovementTypeLine = 1,
  PathMovementTypeQuadratic = 2,
  PathMovementTypeConic = 3,
  PathMovementTypeCubic = 4,
  PathMovementTypeClose = 5,
  PathMovementTypeDone = 6,
};

@class PathSegment;
@class Path;

@interface PathSegment : NSObject
+ (instancetype)makeWithType:(PathMovementType)type
    points:(nullable NSArray<FlutterStandardTypedData *> *)points;
@property(nonatomic, assign) PathMovementType type;
@property(nonatomic, strong, nullable) NSArray<FlutterStandardTypedData *> * points;
@end

@interface Path : NSObject
+ (instancetype)makeWithSegments:(nullable NSArray<PathSegment *> *)segments;
@property(nonatomic, strong, nullable) NSArray<PathSegment *> * segments;
@end

///The codec used by NotchApi.
NSObject<FlutterMessageCodec> *NotchApiGetCodec(void);

@protocol NotchApi
- (nullable Path *)getNotchPathWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)hasNotchWithError:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void NotchApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<NotchApi> *_Nullable api);

NS_ASSUME_NONNULL_END
