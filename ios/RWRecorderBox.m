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
    
    return self;
}

@end
