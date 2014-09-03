//
//  GameOverScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 17/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "GameOverScene.h"
#import "Constants.h"

@implementation GameOverScene



+ (GameOverScene *)scene:(NSString*)size level:(NSString*)level record:(int)record
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

    
    CCButton *back = [CCButton buttonWithTitle:@"Back" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button_highlight.png"]];
    back.label.fontSize = 20;
    back.anchorPoint = ccp(0.5,0.5);
    back.name = @"size3";
    back.positionType = CCPositionTypeNormalized;
    [back setTarget:self selector:@selector(onBackClicked)];
    back.position = ccp(0.12f, 0.96f);
    [self addChild:back];
    
    
    
    
    NSString *congrulationStr = [NSString stringWithFormat:@"Game Over"];
    CCLabelTTF *congrulation = [CCLabelTTF labelWithString:congrulationStr fontName:@"Chalkboard" fontSize:35.0f];
    congrulation.positionType = CCPositionTypeNormalized;
    congrulation.color = RED_COLOR;
    congrulation.anchorPoint = ccp(0.5,0.5);
    congrulation.position = ccp(0.50f, 0.76f); // Middle of screen
    [self addChild:congrulation];

    
    

    NSString *newRecordStr = [NSString stringWithFormat:@"Total Move: %d",record];
    CCLabelTTF *newRecordLabel= [CCLabelTTF labelWithString:newRecordStr fontName:@"Chalkboard" fontSize:30.0f];
    newRecordLabel.positionType = CCPositionTypeNormalized;
    newRecordLabel.color = RED_COLOR;
    newRecordLabel.anchorPoint = ccp(0.5,0.5);
    newRecordLabel.position = ccp(0.50f, 0.46f); // Middle of screen
    [self addChild:newRecordLabel];
    
    
    
    NSString *sizeStr = [NSString stringWithFormat:@"Size: %@X%@",[size substringFromIndex:4],[size substringFromIndex:4]];
    CCLabelTTF *sizeLabel = [CCLabelTTF labelWithString:sizeStr fontName:@"Chalkboard" fontSize:20.0f];
    sizeLabel.positionType = CCPositionTypeNormalized;
    sizeLabel.color = RED_COLOR;
    sizeLabel.anchorPoint = ccp(0.5,0.5);
    sizeLabel.position = ccp(0.50f, 0.36f); // Middle of screen
    [self addChild:sizeLabel];

    
    
    
    return self;
}

-(void) onBackClicked{
    [[CCDirector sharedDirector] popScene];
    
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.3f]];
    
}



@end
