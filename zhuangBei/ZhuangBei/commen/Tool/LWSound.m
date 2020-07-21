//
//  LWSound.m
//  ZhuangBei
//
//  Created by LWQ on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWSound.h"

@implementation LWSound
- (instancetype)init{
    if (self = [super init]) {
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        /*
         Adding the above line of code made it so my audio would start even if the app was in the background.
         */
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"soundSrource" ofType:@"mp3"];
        if (filePath) {
            NSURL* url = [NSURL fileURLWithPath:filePath];
            _audioSession = [AVAudioSession sharedInstance];
            [_audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
            [_audioSession setActive:YES error:nil];
            
            if(!staticAudioPlayer){
                staticAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                [staticAudioPlayer prepareToPlay];
            }
        }
    }
    return self;
}

+(instancetype)sharedInstance{
    static LWSound *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)play{
    staticAudioPlayer.volume = 10;
    if (!staticAudioPlayer.isPlaying) {
        [staticAudioPlayer play];
    }
}

-(void)stop{
    staticAudioPlayer.currentTime = 0;
    [staticAudioPlayer stop];
}

@end

