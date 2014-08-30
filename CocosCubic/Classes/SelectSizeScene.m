//
//  SelectSizeScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 26/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "SelectSizeScene.h"
#import "Constants.h"
#import "SelectLevelScene.h"
#import "IntroScene.h"

@implementation SelectSizeScene

+ (SelectSizeScene *)scene
{
    return [[self alloc] init];
}

- (id)init{
    self = [super init ];
    if (!self) return(nil);
    
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
    
    
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Select Size" fontName:@"Chalkboard" fontSize:48.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = RED_COLOR;
    label.position = ccp(0.5f, 0.8f); // Middle of screen
    [self addChild:label];
    

    CCButton *size3 = [CCButton buttonWithTitle:@"3 X 3" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    size3.label.fontSize = 20;
    size3.anchorPoint = ccp(0.5,0.5);
    size3.name = @"size3";
    size3.positionType = CCPositionTypeNormalized;
    [size3 setTarget:self selector:@selector(onSizeSelected:)];
    size3.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:size3];


    CCButton *size4 = [CCButton buttonWithTitle:@"4 X 4" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    size4.label.fontSize = 20;
    size4.anchorPoint = ccp(0.5,0.5);
    size4.name = @"size4";
    size4.positionType = CCPositionTypeNormalized;
    [size4 setTarget:self selector:@selector(onSizeSelected:)];
    size4.position = ccp(0.5f, 0.4); // Middle of screen
    [self addChild:size4];


    CCButton *size5 = [CCButton buttonWithTitle:@"5 X 5" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    size5.label.fontSize = 20;
    size5.anchorPoint = ccp(0.5,0.5);
    size5.name = @"size5";
    size5.positionType = CCPositionTypeNormalized;
    [size5 setTarget:self selector:@selector(onSizeSelected:)];
    size5.position = ccp(0.5f, 0.3); // Middle of screen
    [self addChild:size5];
    

    CCButton *size6 = [CCButton buttonWithTitle:@"6 X 6" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    size6.label.fontSize = 20;
    size6.anchorPoint = ccp(0.5,0.5);
    size6.name = @"size6";
    size6.positionType = CCPositionTypeNormalized;
    [size6 setTarget:self selector:@selector(onSizeSelected:)];
    size6.position = ccp(0.5f, 0.2); // Middle of screen
    [self addChild:size6];
    
    
    return self;
}

-(void)onSizeSelected:(id)sender
{
    [Constants playMenuItem];
    CCButton *button = (CCButton*)sender;
    NSString *name = button.name;
    
    GameScene *gameScene = [GameScene scene:name level:@"6"];
    
    [[CCDirector sharedDirector] pushScene:gameScene withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.6f]];
    
    
}

-(void)onBackClicked{
    
     [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
}

@end
