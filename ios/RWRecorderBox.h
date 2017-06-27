//
//  RWRecorderBox.h
//  RWRecorder
//
//  Created by Louis Capitanchik on 26/06/2017.
//

#import <Foundation/Foundation.h>
#import <EZAudio/EZAudio.h>
#import "RWRecorder.h"

typedef NS_ENUM(NSInteger, RecorderState) {
    RWCreated,
    RWPrepared,
    RWStarted,
    RWStopped,
    RWDestroyed
};

@interface RWRecorderBox : NSObject <EZRecorderDelegate, EZMicrophoneDelegate>

@property (nonatomic, assign) RecorderState state;
@property (nonatomic, nullable, strong) EZRecorder* recorder;
@property (nonatomic, nullable, strong) EZMicrophone* microphone;

- (void) start: (NSString *) path;
- (void) stop;

@end
