//
//  Constants.m
//  CocosCubic
//
//  Created by Onur Atamer on 27/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "Constants.h"
#import "OALSimpleAudio.h"

@implementation Constants


+(int) getScore:(int)size level:(int)level{
    NSNumber *num = (NSNumber*)SCORE_TABLE[size-3][level];
    return [num intValue];
}


+(BOOL) setScore:(int)size level:(int)level score:(int)score{
    if( [self getScore:size level:level] > score){
        SCORE_TABLE[size-3][level] = [NSNumber numberWithInt:score];
        [self saveScore];
        return YES;
    }else{
        return NO;
    }
}

+(void)saveScore{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"cocoscube.score"];
    
    NSString *scoreFile = @"" ;
    for(int i = 0 ; i < 4 ; i++ ){
        NSMutableArray *levelScore =  [NSMutableArray array];
        for(int j = 0 ; j < 15 ; j++){
            NSNumber *num = (NSNumber*)SCORE_TABLE[i][j];
            NSString *line = [NSString stringWithFormat:@"%d:%d:%d\n",i,j,[num intValue]];
            scoreFile = [scoreFile stringByAppendingString:line];
            levelScore[j] = [NSNumber numberWithInt:0];
        }
        SCORE_TABLE[i] = [NSNumber numberWithInt:i];
    }
    NSError *error;
    [scoreFile writeToFile:filePath atomically:YES
                  encoding:NSUTF8StringEncoding error:&error];
}

+(void)playMenuItem{
    if(SOUND == YES){
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"menuitem.mp3"];
    }
}

+(void)playMoveItem{
    if(SOUND == YES){
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"moveitem.mp3"];
    }
}

+(void)playEndItem{
    if(SOUND == YES){
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"endgame.mp3"];
    }
}

+(BOOL)getSound{
    return SOUND;
}


+(void)setSound:(BOOL)sound{
    SOUND = sound;
}

+(void)switchSound{
    SOUND = !SOUND;
}





@end
