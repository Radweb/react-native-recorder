
#import "RWRecorder.h"

@implementation RWRecorder

RCT_EXPORT_MODULE()

- (instancetype) init
{
    NSLog(@"OAISND");
    self = [super init];
    
    self.recorders = [NSMutableDictionary new];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error)
    {
        @throw(error);
    }
    
    [session setActive:YES error:&error];
    if (error)
    {
        @throw(error);
    }
    
    return self;
}

RCT_EXPORT_METHOD(create: (RCTPromiseResolveBlock) resolve
                  reject: (RCTPromiseRejectBlock) reject) {
    
    NSString* uuid = [[NSUUID UUID] UUIDString];
    
    [self.recorders setObject:[[RWRecorderBox alloc] init] forKey:uuid];
    
    resolve(uuid);
}

RCT_EXPORT_METHOD(start: (NSString *) ident
                  withPath: (NSString *) path
                  resolve: (RCTPromiseResolveBlock) resolve
                  reject: (RCTPromiseRejectBlock) reject) {
    
    RWRecorderBox* box = [self.recorders objectForKey:ident];
    
    if (box == nil) {
        resolve(@NO);
    } else {
        NSURL* diskpath = [NSURL fileURLWithPath:path];
        [box start:diskpath];
        resolve(@YES);
    }
    
}

RCT_EXPORT_METHOD(stop: (NSString *) ident
                  resolve: (RCTPromiseResolveBlock) resolve
                  reject: (RCTPromiseRejectBlock) reject) {
    
    RWRecorderBox* box = [self.recorders objectForKey:ident];
    
    if (box == nil) {
        resolve(@NO);
    } else {
        [box stop];
        resolve(@YES);
    }
    
}

RCT_EXPORT_METHOD(release: (NSString *) ident
                  resolve: (RCTPromiseResolveBlock) resolve
                  reject: (RCTPromiseRejectBlock) reject) {
    
    RWRecorderBox* box = [self.recorders objectForKey:ident];
    
    if (box == nil) {
        resolve(@NO);
    } else {
        [box stop];
        [self.recorders removeObjectForKey:ident];
        resolve(@YES);
    }
}

@end

