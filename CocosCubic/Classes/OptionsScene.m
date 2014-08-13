//
//  OptionsScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 11/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "OptionsScene.h"
#import "Constants.h"
#import "HowToPlay.h"
#import  "AboutScene.h"

@implementation OptionsScene

+ (OptionsScene *)scene
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
    [back setTarget:self selector:@selector(backClicked)];
    back.position = ccp(0.12f, 0.96f);
    [self addChild:back];
    
    NSString *soundStr ;
    if([Constants getSound ] == YES){
        soundStr = @"Sound On";
    }else{
        soundStr = @"Sound Off";
    }
    
    self.sound = [CCButton buttonWithTitle:soundStr spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    self.sound.label.fontSize = 20;
    self.sound.anchorPoint = ccp(0.5,0.5);
    self.sound.name = @"size3";
    self.sound.positionType = CCPositionTypeNormalized;
    [self.sound setTarget:self selector:@selector(soundClick)];
    self.sound.position = ccp(0.5f, 0.6f); // Middle of screen
    [self addChild:self.sound];

    
   
    CCButton *howToPlay = [CCButton buttonWithTitle:@"How To Play" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    howToPlay.label.fontSize = 20;
    howToPlay.anchorPoint = ccp(0.5,0.5);
    howToPlay.name = @"size3";
    howToPlay.positionType = CCPositionTypeNormalized;
    [howToPlay setTarget:self selector:@selector(howToPlayClick)];
    howToPlay.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:howToPlay];


    CCButton *about = [CCButton buttonWithTitle:@"About" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"button_highlight.png"]];
    about.label.fontSize = 20;
    about.anchorPoint = ccp(0.5,0.5);
    about.name = @"size3";
    about.positionType = CCPositionTypeNormalized;
    [about setTarget:self selector:@selector(aboutClick)];
    about.position = ccp(0.5f, 0.4f); // Middle of screen
    [self addChild:about];
    
    
    
    return self;
}


-(void) soundClick{
    
    [Constants switchSound];
    if([Constants getSound] == YES){
        [self.sound.label setString:@"Sound On"];
        [Constants playMenuItem];
    }else{
        [self.sound.label setString:@"Sound Off"];

    }
}

-(void) howToPlayClick{
    [Constants playMenuItem];
    HowToPlay *howToPlay = [HowToPlay scene];
    howToPlay.play = 1;
    [[CCDirector sharedDirector] pushScene:howToPlay withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.6f]];
    
}

-(void) aboutClick{
    [Constants playMenuItem];
    [[CCDirector sharedDirector] pushScene:[AboutScene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.6f]];
}

-(void) backClicked{
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
}




@end
