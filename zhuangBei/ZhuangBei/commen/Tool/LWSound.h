//
//  LWSound.h
//  ZhuangBei
//
//  Created by LWQ on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

static AVAudioPlayer* staticAudioPlayer;

@interface LWSound : NSObject
{
    AVAudioSession* _audioSession;
}

+(instancetype)sharedInstance;

-(void)play;

-(void)stop;

@end
