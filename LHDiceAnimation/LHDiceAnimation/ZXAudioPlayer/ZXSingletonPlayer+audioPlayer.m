//
//  ZXSingletonPlayer+audioPlayer.m
//  haibingo
//
//  Created by ma c on 2018/4/17.
//  Copyright © 2018年 innosky. All rights reserved.
//

#import "ZXSingletonPlayer+audioPlayer.h"

static NSString *preAudioPath = @"";

@implementation ZXSingletonPlayer (audioPlayer)

+(void)LHAudioPlay:(NSString *)audioFilePath
{
    BOOL isStop = [[NSUserDefaults standardUserDefaults] boolForKey:@"StopSystemAudio"];
    
    BOOL isStopOpenAudio = [[NSUserDefaults standardUserDefaults] boolForKey:@"StopOpenAudio"];
    
    NSString *openPath = [[NSBundle mainBundle] pathForResource:@"open_sound_effect" ofType:@"mp3"];
    
    NSString *redRainPath = [[NSBundle mainBundle] pathForResource:@"Music_Red_rain" ofType:@"mp3"];
    
    if([openPath isEqualToString:audioFilePath])
    {
        
        if(isStopOpenAudio == NO && ![preAudioPath isEqualToString:redRainPath])
        {
            NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
                NSError *error = nil;
                NSData *data = [[NSFileManager defaultManager] contentsAtPath:audioFilePath];
                [[ZXSingletonPlayer shareInstance] setSourceFromData:data error:error];
                [[ZXSingletonPlayer shareInstance] play];
                if(error)
                {
                    NSLog(@"%@",error);
                }
            }];
            
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            
            [queue addOperation:blockOperation];
        }
        
    }else{
        
        if(isStop == NO){
            NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
                
                NSError *error = nil;
                NSData *data = [[NSFileManager defaultManager] contentsAtPath:audioFilePath];
                [[ZXSingletonPlayer shareInstance] setSourceFromData:data error:error];
                [[ZXSingletonPlayer shareInstance] play];
                if(error)
                {
                    NSLog(@"%@",error);
                }
                
            }];
            
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            
            [queue addOperation:blockOperation];
        }
        
    }
    
    preAudioPath = audioFilePath;
}
#pragma mark - 播放次数
+(void)LHAudioPlay:(NSString *)audioFilePath withNumber:(NSInteger)number
{
    BOOL isStop = [[NSUserDefaults standardUserDefaults] boolForKey:@"StopSystemAudio"];
    
    if(isStop == NO){
        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            NSError *error = nil;
            NSData *data = [[NSFileManager defaultManager] contentsAtPath:audioFilePath];
            [[ZXSingletonPlayer shareInstance] setSourceFromData:data loops:number error:error];
            [[ZXSingletonPlayer shareInstance] play];
            if(error)
            {
                NSLog(@"%@",error);
            }
        }];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [queue addOperation:blockOperation];
    }
    
    preAudioPath = audioFilePath;
}
@end
