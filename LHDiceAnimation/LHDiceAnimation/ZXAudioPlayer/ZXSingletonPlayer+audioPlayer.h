//
//  ZXSingletonPlayer+audioPlayer.h
//  haibingo
//
//  Created by ma c on 2018/4/17.
//  Copyright © 2018年 innosky. All rights reserved.
//

#import "ZXSingletonPlayer.h"

@interface ZXSingletonPlayer (audioPlayer)
+(void)LHAudioPlay:(NSString *)audioFilePath;
+(void)LHAudioPlay:(NSString *)audioFilePath withNumber:(NSInteger)number;
@end
