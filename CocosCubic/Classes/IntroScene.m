//
//  IntroScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 23/07/14.
//  Copyright Onur Atamer 2014. All rights reserved.
//
// -----------------------------------------------------------------------



// Import the interfaces
#import "IntroScene.h"
#import "HelloWorldScene.h"
#import "Constants.h"
#import "SelectSizeScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor: BACKGROUND_COLOR ];
    [self addChild:background];

    
    CCSpriteBatchNode *backgroundBgNode;
    backgroundBgNode = [CCSpriteBatchNode batchNodeWithFile:@"background.pvr.ccz"];
    [self addChild:backgroundBgNode];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background.plist"];
    
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Coco's Cubic" fontName:@"Chalkboard" fontSize:48.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = RED_COLOR;
    label.position = ccp(0.5f, 0.8f); // Middle of screen
    [self addChild:label];
    


    CCButton *playButton = [CCButton buttonWithTitle:@"Play" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    playButton.label.fontSize = 20;
    playButton.anchorPoint = ccp(0,0);

    CGFloat buttonWidth =  playButton.boundingBox.size.width;
    playButton.position = ccp((screenWidth - buttonWidth) /2, 200.0f); // Middle of screen
    [self addChild:playButton];
    [playButton setTarget:self selector:@selector(onPlayClicked:)];
    
    
    CCButton *optionsButton = [CCButton buttonWithTitle:@"Options" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    optionsButton.label.fontSize = 20;
    optionsButton.anchorPoint = ccp(0,0);
    optionsButton.position = ccp((screenWidth - buttonWidth) /2, 150.0f); // Middle of screen
    [self addChild:optionsButton];
    [optionsButton setTarget:self selector:@selector(onOptionsClicked:)];
    


	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onPlayClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[SelectSizeScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}


- (void)onOptionsClicked:(id)sender
{
}

- (void)onPuzzleClicked:(id)sender
{
    
}


// -----------------------------------------------------------------------
@end
