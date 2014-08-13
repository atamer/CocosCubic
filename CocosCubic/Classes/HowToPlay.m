//
//  HowToPlay.m
//  CocosCubic
//
//  Created by Onur Atamer on 11/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "HowToPlay.h"
#import "Constants.h"

@implementation HowToPlay

+ (HowToPlay *)scene
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
    [back setTarget:self selector:@selector(howToPlayBackClicked)];
    back.position = ccp(0.12f, 0.96f);
    [self addChild:back];
    
    self.grid = [GridScene spriteWithImageNamed:@"grid3.png" size:3 level:@"1" random:NO gameSceneProtocol:self ];
    self.grid.anchorPoint = ccp(0.5,0.5);
    self.grid.positionType = CCPositionTypeNormalized;
    self.grid.position = ccp(0.5f, 0.59f);
    
    [self addChild:self.grid];
    
    
    return self;
}

-(void)howToPlayBackClicked{
     [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
}

- (void)onEnter
{
    [super onEnter];
    if(self.finger == nil){
        if(self.play == 1){
            CCSprite *finger = [CCSprite spriteWithImageNamed:@"finger.png"];
            self.finger = finger;
            finger.anchorPoint = ccp(0.5,0.5);
            finger.positionType = CCPositionTypeNormalized;
            finger.position = ccp(0.57f, 0.45f);
            [self addChild:finger];
            
            
            CCSprite *fingerUp = [CCSprite spriteWithImageNamed:@"finger_up.png"];
            fingerUp.anchorPoint = ccp(0.5,0.5);
            fingerUp.positionType = CCPositionTypeNormalized;
            fingerUp.position = ccp(0.50f, 0.725f);
            [self addChild:fingerUp];
            
            [self.grid moveDown:2 ];
        }
    }
    
    
}

-(void) updateMove{
    
}
-(void) finishGame{
    self.play = self.play + 1;
    if(self.play == 2){
        [self.grid clean];
        [self removeChild:self.grid];
        self.grid = [GridScene spriteWithImageNamed:@"grid3.png" size:3 level:@"1" random:NO reverse:YES gameSceneProtocol:self ];
        self.grid.anchorPoint = ccp(0.5,0.5);
        self.grid.positionType = CCPositionTypeNormalized;
        self.grid.position = ccp(0.5f, 0.59f);
        [self addChild:self.grid];
        
        CCSprite *finger = [CCSprite spriteWithImageNamed:@"finger.png"];
        self.finger = finger;
        finger.anchorPoint = ccp(0.5,0.5);
        finger.positionType = CCPositionTypeNormalized;
        finger.position = ccp(0.57f, 0.45f);
        [self addChild:finger];
        
        
        CCSprite *fingerUp = [CCSprite spriteWithImageNamed:@"finger_left.png"];
        fingerUp.anchorPoint = ccp(0.5,0.5);
        fingerUp.positionType = CCPositionTypeNormalized;
        fingerUp.position = ccp(0.295f, 0.585f);
        [self addChild:fingerUp];
        
        [self.grid moveRight:2];
        
    }else{
        [self.grid clean];
        NSString *puzzle = [NSString stringWithFormat:@"This Simple , Let's Play"];
        CCLabelTTF *puzzleLabel = [CCLabelTTF labelWithString:puzzle fontName:@"Chalkboard" fontSize:24.0f];
        puzzleLabel.positionType = CCPositionTypeNormalized;
        puzzleLabel.color = RED_COLOR;
        puzzleLabel.anchorPoint = ccp(0.5,0.5);
        puzzleLabel.position = ccp(0.5f, 0.2f); // Middle of screen
        [self addChild:puzzleLabel];
    }
}


@end
