//
//  GameScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 28/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "GameScene.h"
#import "Constants.h"
#import "SelectLevelScene.h"

@implementation GameScene

NSString *size_;
NSString *level_;

+ (GameScene *)scene:(NSString*)size level:(NSString*)level
{
    size_ = size;
    level_ = level;
    return [[self alloc] init];
}

- (id)init{
    self = [super init ];
    if (!self) return(nil);
    
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
    
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Move: 1" fontName:@"Chalkboard" fontSize:24.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = RED_COLOR;
    label.anchorPoint = ccp(0.5,0.5);
    label.position = ccp(0.78f, 0.96f); // Middle of screen
    [self addChild:label];

    
    
   CCSprite *grid = [CCSprite spriteWithImageNamed:@"grid5.png"];
    grid.anchorPoint = ccp(0.5,0.5);
    grid.name = @"size3";
    grid.positionType = CCPositionTypeNormalized;
    grid.position = ccp(0.5f, 0.57f);
    [self addChild:grid];
    

   /*
    CCSprite *grid1 = [CCSprite spriteWithImageNamed:@"grid4.png"];
    grid1.anchorPoint = ccp(0.5,0.5);
    grid1.name = @"size3";
    grid1.positionType = CCPositionTypeNormalized;
    grid1.position = ccp(0.5f, 0.57f);
    [self addChild:grid1];
    
    CCSprite *grid2 = [CCSprite spriteWithImageNamed:@"grid5.png"];
    grid2.anchorPoint = ccp(0.5,0.5);
    grid2.name = @"size3";
    grid2.positionType = CCPositionTypeNormalized;
    grid2.position = ccp(0.5f, 0.57f);
    [self addChild:grid2];
    
    
    CCSprite *grid3 = [CCSprite spriteWithImageNamed:@"grid6.png"];
    grid3.anchorPoint = ccp(0.5,0.5);
    grid3.name = @"size3";
    grid3.positionType = CCPositionTypeNormalized;
    grid3.position = ccp(0.5f, 0.57f);
    [self addChild:grid3];
*/
    
    
    return self;
}


-(void)onBackClicked{
    
    [[CCDirector sharedDirector] replaceScene:[SelectLevelScene scene:size_]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
}

@end
