
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

typedef enum {
    RWCreated,
    RWPrepared,
    RWStarted,
    RWStopped,
    RWDestroyed
} RecorderState;

@interface RWRecorder : NSObject <RCTBridgeModule>

@property(nonatomic, strong) NSMutableDictionary *recorders;

@end
  
