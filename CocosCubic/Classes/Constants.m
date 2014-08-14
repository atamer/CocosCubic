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
    NSNumber *num = (NSNumber*)SCORE_TABLE[size-3][level-1];
    return [num intValue];
}

+(void)createScoreFile:(NSString*)filePath{
    SCORE_TABLE = [NSMutableArray array];
    NSString *scoreFile = @"" ;
    for(int i = 0 ; i < 4 ; i++ ){
        NSMutableArray *levelScore =  [NSMutableArray array];
        for(int j = 0 ; j < 15 ; j++){
            NSString *line = [NSString stringWithFormat:@"%d:%d:0\n",i,j];
            scoreFile = [scoreFile stringByAppendingString:line];
            levelScore[j] = [NSNumber numberWithInt:0];
        }
        SCORE_TABLE[i] = [NSNumber numberWithInt:i];
    }
    NSError *error;
    [scoreFile writeToFile:filePath atomically:YES
                  encoding:NSUTF8StringEncoding error:&error];
}



+(void)readScoreFile:(NSString*)filePath{
    SCORE_TABLE = [NSMutableArray array];
    
    for(int i = 0 ; i<15 ; i++){
        SCORE_TABLE[i] = [NSMutableArray array];
    }
    
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSArray *scoreLines = [content componentsSeparatedByString:@"\n"];
    for(int i = 0 ; i < [scoreLines count] - 1 ; i++){
        NSString *line = scoreLines[i];
        NSArray *score = [line componentsSeparatedByString:@":"];
        
        int size = [((NSString*)(score[0])) intValue];
        int level = [((NSString*)(score[1])) intValue];
        int record = [((NSString*)(score[2])) intValue];
        
        SCORE_TABLE[size][level] = [NSNumber numberWithInt:record];
    }
    
}



+(BOOL) setScore:(int)size level:(int)level score:(int)score{
    if( [self getScore:size level:level] > score || [self getScore:size level:level] == 0){
        SCORE_TABLE[size-3][level-1] = [NSNumber numberWithInt:score];
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
