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
#import "OptionsScene.h"
#import "Constants.h"
#import "SelectSizeScene.h"
#import "RecordScene.h"

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

    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor: BACKGROUND_COLOR ];

    [self addChild:background];

    // file operations
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"cocoscube.score"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath: filePath] == YES){
        [Constants readScoreFile:filePath];
    }else{
        [Constants createScoreFile:filePath];
    }
        
    //load audios
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio preloadEffect:@"endgame.mp3"];
    [audio preloadEffect:@"menuitem.mp3"];
    [audio preloadEffect:@"moveitem.mp3"];
    
    
    
    CCSpriteBatchNode *buttonsNode;
    buttonsNode = [CCSpriteBatchNode batchNodeWithFile:@"buttons.pvr.ccz"];
    [self addChild:buttonsNode];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"buttons.plist"];

    CCSpriteBatchNode *grid3_4;
    grid3_4 = [CCSpriteBatchNode batchNodeWithFile:@"grid_3_4.pvr.ccz"];
    [self addChild:grid3_4];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"grid_3_4.plist"];
    
   
    CCSpriteBatchNode *grid5_6;
    grid5_6 = [CCSpriteBatchNode batchNodeWithFile:@"grid_5_6.pvr.ccz"];
    [self addChild:grid5_6];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"grid_5_6.plist"];
    

    CCSpriteBatchNode *colors;
    colors = [CCSpriteBatchNode batchNodeWithFile:@"colors.pvr.ccz"];
    [self addChild:colors];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"colors.plist"];
    

    
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Coco's Cubic" fontName:@"Chalkboard" fontSize:48.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = RED_COLOR;
    label.position = ccp(0.5f, 0.8f);
    [self addChild:label];
    


    CCButton *playButton = [CCButton buttonWithTitle:@"Play" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    playButton.label.fontSize = 20;
    playButton.anchorPoint = ccp(0.5,0.5);
    playButton.positionType = CCPositionTypeNormalized;
    playButton.position = ccp(0.5f, 0.5f);
    [self addChild:playButton];
    [playButton setTarget:self selector:@selector(onPlayClicked:)];
    
    
    CCButton *optionsButton = [CCButton buttonWithTitle:@"Options" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    optionsButton.label.fontSize = 20;
    optionsButton.anchorPoint = ccp(0.5,0.5);
    optionsButton.positionType = CCPositionTypeNormalized;
    optionsButton.position = ccp(0.5f, 0.4f);
    [self addChild:optionsButton];
    [optionsButton setTarget:self selector:@selector(onOptionsClicked:)];
    


	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onPlayClicked:(id)sender
{
	[Constants playMenuItem];
    // start spinning scene with transition
     [[CCDirector sharedDirector] pushScene:[SelectSizeScene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.6f]];
    
}


- (void)onOptionsClicked:(id)sender
{
    [Constants playMenuItem];
    [[CCDirector sharedDirector] pushScene:[OptionsScene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.6f]];
    
}




// -----------------------------------------------------------------------
@end
