// Autogenerated from Pigeon (v4.1.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "dart_api.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ?: [NSNull null]),
        @"message": (error.message ?: [NSNull null]),
        @"details": (error.details ?: [NSNull null]),
        };
  }
  return @{
      @"result": (result ?: [NSNull null]),
      @"error": errorDict,
      };
}
static id GetNullableObject(NSDictionary* dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}
static id GetNullableObjectAtIndex(NSArray* array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}


@interface PathSegment ()
+ (PathSegment *)fromMap:(NSDictionary *)dict;
+ (nullable PathSegment *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface Path ()
+ (Path *)fromMap:(NSDictionary *)dict;
+ (nullable Path *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end

@implementation PathSegment
+ (instancetype)makeWithType:(PathMovementType)type
    points:(nullable NSArray<FlutterStandardTypedData *> *)points {
  PathSegment* pigeonResult = [[PathSegment alloc] init];
  pigeonResult.type = type;
  pigeonResult.points = points;
  return pigeonResult;
}
+ (PathSegment *)fromMap:(NSDictionary *)dict {
  PathSegment *pigeonResult = [[PathSegment alloc] init];
  pigeonResult.type = [GetNullableObject(dict, @"type") integerValue];
  pigeonResult.points = GetNullableObject(dict, @"points");
  return pigeonResult;
}
+ (nullable PathSegment *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [PathSegment fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"type" : @(self.type),
    @"points" : (self.points ?: [NSNull null]),
  };
}
@end

@implementation Path
+ (instancetype)makeWithSegments:(nullable NSArray<PathSegment *> *)segments {
  Path* pigeonResult = [[Path alloc] init];
  pigeonResult.segments = segments;
  return pigeonResult;
}
+ (Path *)fromMap:(NSDictionary *)dict {
  Path *pigeonResult = [[Path alloc] init];
  pigeonResult.segments = GetNullableObject(dict, @"segments");
  return pigeonResult;
}
+ (nullable Path *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [Path fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"segments" : (self.segments ?: [NSNull null]),
  };
}
@end

@interface NotchApiCodecReader : FlutterStandardReader
@end
@implementation NotchApiCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [Path fromMap:[self readValue]];
    
    case 129:     
      return [PathSegment fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface NotchApiCodecWriter : FlutterStandardWriter
@end
@implementation NotchApiCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[Path class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[PathSegment class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface NotchApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation NotchApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[NotchApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[NotchApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *NotchApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    NotchApiCodecReaderWriter *readerWriter = [[NotchApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void NotchApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<NotchApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.NotchApi.getNotchPath"
        binaryMessenger:binaryMessenger
        codec:NotchApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getNotchPathWithError:)], @"NotchApi api (%@) doesn't respond to @selector(getNotchPathWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        Path *output = [api getNotchPathWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.NotchApi.hasNotch"
        binaryMessenger:binaryMessenger
        codec:NotchApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(hasNotchWithError:)], @"NotchApi api (%@) doesn't respond to @selector(hasNotchWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api hasNotchWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
