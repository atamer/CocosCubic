//
//  AboutScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 11/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "AboutScene.h"
#import "Constants.h"


@implementation AboutScene


+ (AboutScene *)scene
{
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
    [back setTarget:self selector:@selector(aboutSceneBackClicked)];
    back.position = ccp(0.12f, 0.96f);
    [self addChild:back];

    
    NSString *puzzle = [NSString stringWithFormat:@"This is a simple version of Rubic Cube"];
    CCLabelTTF *puzzleLabel = [CCLabelTTF labelWithString:puzzle fontName:@"Chalkboard" fontSize:18.0f];
    puzzleLabel.positionType = CCPositionTypeNormalized;
    puzzleLabel.color = RED_COLOR;
    puzzleLabel.anchorPoint = ccp(0.5,0.5);
    puzzleLabel.position = ccp(0.5f, 0.8f); // Middle of screen
    [self addChild:puzzleLabel];

    
    NSString *puzzle1 = [NSString stringWithFormat:@"Here are some amazing tools  used "];
    CCLabelTTF *puzzleLabel1 = [CCLabelTTF labelWithString:puzzle1 fontName:@"Chalkboard" fontSize:18.0f];
    puzzleLabel1.positionType = CCPositionTypeNormalized;
    puzzleLabel1.color = RED_COLOR;
    puzzleLabel1.anchorPoint = ccp(0.5,0.5);
    puzzleLabel1.position = ccp(0.5f, 0.7f); // Middle of screen
    [self addChild:puzzleLabel1];
    
    
    
    CCSprite *cocosImage = [CCSprite spriteWithImageNamed:@"cocos2d.png"];
    cocosImage.positionType = CCPositionTypeNormalized;
    cocosImage.anchorPoint = ccp(0.5,0.5);
    cocosImage.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:cocosImage];

    
    CCSprite *textureImage = [CCSprite spriteWithImageNamed:@"texturepacker.jpg"];
    textureImage.positionType = CCPositionTypeNormalized;
    textureImage.anchorPoint = ccp(0.5,0.5);
    textureImage.position = ccp(0.5f, 0.3f); // Middle of screen

    [self addChild:textureImage];

    
    return self;
}


-(void)aboutSceneBackClicked{
     [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
}

@end
