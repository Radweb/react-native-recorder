
#import "RWRecorder.h"

@implementation RWRecorder

RCT_EXPORT_MODULE()

- (instancetype) init
{
    self = [super init];
    self.recorders = [NSMutableDictionary new];
    return self;
}

RCT_EXPORT_METHOD(create: (RCTPromiseResolveBlock) resolve
                  reject: (RCTPromiseRejectBlock) reject) {
    
    NSString* uuid = [[NSUUID UUID] UUIDString];
    
    resolve(uuid);
}

@end
