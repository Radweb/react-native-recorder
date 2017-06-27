//
//  RWRecorderBox.h
//  RWRecorder
//
//  Created by Louis Capitanchik on 26/06/2017.
//

#import <Foundation/Foundation.h>
#import <EZAudio/EZRecorder.h>
#import "RWRecorder.h"

@interface RWRecorderBox : NSObject

@property (nonatomic, nonnull, strong) RecorderState state;
@property (nonatomic, strong) EZRecorder* recorder;

@end
