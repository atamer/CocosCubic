//
//  SelectLevelScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 27/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "SelectLevelScene.h"
#import "SelectSizeScene.h"
#import "Constants.h"
#import "GameScene.h"
#import "GADHolderView.h"


@implementation SelectLevelScene



+ (SelectLevelScene*)scene:(NSString*)size
{
    return [[self alloc] init:size ];
}


- (id)init:(NSString*)size{
    self = [super init ];
    if (!self) return(nil);
    
    self.size = size;
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
        
    // Create a colored background (Dark Grey)
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
    
    
    

    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Select Level" fontName:@"Chalkboard" fontSize:48.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = RED_COLOR;
    label.position = ccp(0.5f, 0.8f); // Middle of screen
    [self addChild:label];
    
    
   
    for (int i = 0 ; i < 5; i++) {
        NSString* level = [NSString stringWithFormat:@"%d",i+1];
        CCButton *levelButton = [CCButton buttonWithTitle:level spriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"]];
        levelButton.label.fontSize = 20;
        levelButton.anchorPoint = ccp(0.5,0.5);
        levelButton.name = level;
        levelButton.positionType = CCPositionTypeNormalized;
        [levelButton setTarget:self selector:@selector(onLevelSelected:)];
        if(i == 0){
            levelButton.position = ccp(0.2, 0.5 );
        }else{
            levelButton.position = ccp(0.2 + ( i * 0.15 ), 0.5 );
        }
        [self addChild:levelButton];
    }
    

    for (int i = 5 ; i < 10 ; i++) {
        NSString* level = [NSString stringWithFormat:@"%d",i+1];
        CCButton *levelButton = [CCButton buttonWithTitle:level spriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"]];
        levelButton.label.fontSize = 20;
        levelButton.anchorPoint = ccp(0.5,0.5);
        levelButton.positionType = CCPositionTypeNormalized;
        [levelButton setTarget:self selector:@selector(onLevelSelected:)];
        levelButton.name = level;
        if(i == 5){
            levelButton.position = ccp(0.2, 0.4 );
        }else{
            levelButton.position = ccp(0.2 + ( (i-5) * 0.15 ), 0.4);
        }
        [self addChild:levelButton];
    }
    
    
    for (int i = 10 ; i < 15 ; i++) {
        NSString* level = [NSString stringWithFormat:@"%d",i+1];
        CCButton *levelButton = [CCButton buttonWithTitle:level spriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"]];
        levelButton.label.fontSize = 20;
        levelButton.anchorPoint = ccp(0.5,0.5);
        levelButton.positionType = CCPositionTypeNormalized;
        [levelButton setTarget:self selector:@selector(onLevelSelected:)];
        levelButton.name = level;
        if(i == 10){
            levelButton.position = ccp(0.2, 0.3 );
        }else{
            levelButton.position = ccp(0.2 + ( (i - 10) * 0.15 ), 0.3);
        }
        [self addChild:levelButton];
    }

    return self;
}


-(void)onBackClicked{
  
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
}

-(void)onLevelSelected:(id)sender{
    
    [Constants playMenuItem];
    CCButton *button = (CCButton*)sender;
    NSString *level = button.name;

    self.level = level;
    
    GameScene *gameScene = [GameScene scene:self.size level:self.level];
    
    [[CCDirector sharedDirector] pushScene:gameScene withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.6f]];
    
}




@end
