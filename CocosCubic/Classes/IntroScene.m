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
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Helloworld scene button
    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    helloWorldButton.positionType = CCPositionTypeNormalized;
    helloWorldButton.position = ccp(0.5f, 0.35f);
    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:helloWorldButton];
    
    
    
    CCSpriteBatchNode *spritesBgNode;
    spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"rounded-sprite.pvr.ccz"];
    [self addChild:spritesBgNode];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"rounded-sprite.plist"];
    
    CGPoint spriteOffset = ccp(100, 100);
    CCSprite *sprite = [CCSprite spriteWithImageNamed:@"rounded_1.png"];
    sprite.position = spriteOffset;
    [spritesBgNode addChild:sprite];
    
    
    CCSpriteBatchNode *backgroundBgNode;
    backgroundBgNode = [CCSpriteBatchNode batchNodeWithFile:@"background.pvr.ccz"];
    [self addChild:backgroundBgNode];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background.plist"];
    CCSprite *background1 = [CCSprite spriteWithImageNamed:@"background.png"];
    background1.anchorPoint = ccp(0,0);
    [backgroundBgNode addChild:background1];
    
    
    

    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[HelloWorldScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
