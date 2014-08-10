//
//  RecordScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 10/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "RecordScene.h"
#import "Constants.h"

@implementation RecordScene


+ (RecordScene *)scene:(NSString*)size level:(NSString*)level record:(int)record
{
    return [[self alloc] initRecordScene:size level:level record:record];
}

- (id) initRecordScene:(NSString*)size level:(NSString*)level record:(int)record
{
    self = [super init ];
    if (!self) return(nil);
    
    self.level = level;
    self.size = size;
    self.record = record;
    
    CCNodeColor *background = [CCNodeColor nodeWithColor: BACKGROUND_COLOR ];
    [self addChild:background];
    
    NSString *congrulationStr = [NSString stringWithFormat:@"CONGRATULATIONS"];
    CCLabelTTF *congrulation = [CCLabelTTF labelWithString:congrulationStr fontName:@"Chalkboard" fontSize:35.0f];
    congrulation.positionType = CCPositionTypeNormalized;
    congrulation.color = RED_COLOR;
    congrulation.anchorPoint = ccp(0.5,0.5);
    congrulation.position = ccp(0.50f, 0.76f); // Middle of screen
    [self addChild:congrulation];
    
    NSString *newRecordStr = [NSString stringWithFormat:@"New Record: %d",record];
    CCLabelTTF *newRecordLabel= [CCLabelTTF labelWithString:newRecordStr fontName:@"Chalkboard" fontSize:30.0f];
    newRecordLabel.positionType = CCPositionTypeNormalized;
    newRecordLabel.color = RED_COLOR;
    newRecordLabel.anchorPoint = ccp(0.5,0.5);
    newRecordLabel.position = ccp(0.50f, 0.46f); // Middle of screen
    [self addChild:newRecordLabel];
    
    
    NSString *levelStr = [NSString stringWithFormat:@"Level: %@",level];
    CCLabelTTF *levelLabel = [CCLabelTTF labelWithString:levelStr fontName:@"Chalkboard" fontSize:20.0f];
    levelLabel.positionType = CCPositionTypeNormalized;
    levelLabel.color = RED_COLOR;
    levelLabel.anchorPoint = ccp(0.5,0.5);
    levelLabel.position = ccp(0.50f, 0.36f); // Middle of screen
    [self addChild:levelLabel];
    
    
    NSString *sizeStr = [NSString stringWithFormat:@"Size: %@",size];
    CCLabelTTF *sizeLabel = [CCLabelTTF labelWithString:sizeStr fontName:@"Chalkboard" fontSize:20.0f];
    sizeLabel.positionType = CCPositionTypeNormalized;
    sizeLabel.color = RED_COLOR;
    sizeLabel.anchorPoint = ccp(0.5,0.5);
    sizeLabel.position = ccp(0.50f, 0.26f); // Middle of screen
    [self addChild:sizeLabel];
    
    return self;
    
}
    

@end
