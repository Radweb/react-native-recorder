
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
    
    [self.recorders setObject:[[RWRecorderBox alloc] init] withKey:uuid];
    
    resolve(uuid);
}

RCT_EXPORT_METHOD(release: (NSString) ident
                  resolve: (RCTPromiseResolveBlock) resolve
                  reject: (RCTPromiseRejectBlock) reject) {
    
    RWRecorderBox* box = [self.recorders getObject: ident];
    
    if (box == nil) {
        resolve(FALSE);
    } else {
        resolve(TRUE);
    }
}

@end
