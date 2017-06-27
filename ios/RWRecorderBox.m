//
//  RWRecorderBox.m
//  RWRecorder
//
//  Created by Louis Capitanchik on 26/06/2017.

#import "RWRecorderBox.h"

@implementation RWRecorderBox

- (instancetype) init
{
    self = [super init];

    self.state = RWCreated;
    self.recorder = nil;
    self.microphone = nil;

    return self;
}

#pragma mark Public Lifecycle

- (void) stop
{
    if (self.recorder == nil) return;

    self.state = RWStopped;

    [self.microphone stopFetchingAudio];
    [self.recorder closeAudioFile];

    self.microphone = nil;
}

- (void) start: (NSURL *) path
{
    if (self.state == RWStopped || self.state == RWCreated) {
        self.microphone = [EZMicrophone microphoneWithDelegate:self];

        NSArray *inputs = [EZAudioDevice inputDevices];
        [self.microphone setDevice:[inputs lastObject]];

        self.recorder = [EZRecorder recorderWithURL:path
                                       clientFormat:[self.microphone audioStreamBasicDescription]
                                           fileType:EZRecorderFileTypeM4A];

        self.recorder.delegate = self;

        self.state = RWStarted;

        [self.microphone startFetchingAudio];
    }
}

#pragma mark Delegates

- (void)  microphone:(EZMicrophone *)microphone
       hasBufferList:(AudioBufferList *)bufferList
      withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels
{
    if (self.state == RWStarted) {
        [self.recorder appendDataFromBufferList:bufferList withBufferSize:bufferSize];
    }
}

- (void) recorderDidClose:(EZRecorder *)recorder
{
    self.recorder = nil;
}

#pragma mark Formats

- (AudioStreamBasicDescription) wavFormat
{
    AudioStreamBasicDescription descriptor = {0};
    descriptor.mSampleRate = 44100.0;
    descriptor.mFormatID = kAudioFormatLinearPCM;
    descriptor.mFramesPerPacket = 1;
    descriptor.mChannelsPerFrame = 2;
    descriptor.mBytesPerFrame = descriptor.mChannelsPerFrame * 2;
    descriptor.mBytesPerPacket = descriptor.mFramesPerPacket * descriptor.mBytesPerFrame;
    descriptor.mBitsPerChannel = 16;
    descriptor.mReserved = 0;
    descriptor.mFormatFlags = kAudioFormatFlagIsSignedInteger |
        kAudioFormatFlagsNativeEndian |
        kLinearPCMFormatFlagIsPacked;

    return descriptor;
}

- (AudioStreamBasicDescription) aacFormat
{
    AudioStreamBasicDescription descriptor = {0};
    descriptor.mSampleRate = 44100.0;
    descriptor.mFormatID = kAudioFormatMPEG4AAC;
    descriptor.mFormatFlags = kMPEG4Object_AAC_Main;
    descriptor.mBytesPerPacket = 0;
    descriptor.mFramesPerPacket = 1024;
    descriptor.mBytesPerFrame = 0;
    descriptor.mChannelsPerFrame = 1;
    descriptor.mBitsPerChannel = 0;
    descriptor.mReserved = 0;

    return descriptor;
}

@end
