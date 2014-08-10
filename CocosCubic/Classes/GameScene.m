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
#import "GridScene.h"
#import "RecordScene.h"

@implementation GameScene


+ (GameScene *)scene:(NSString*)size level:(NSString*)level back:(SelectLevelScene*)back
{
    return [[self alloc] init:size level:level back:back];
}

- (id)init:(NSString*)size level:(NSString*)level back:(SelectLevelScene*)backScene{
    self = [super init ];
    if (!self) return(nil);
    
    self.backScene = backScene;
    self.level = level;
    self.size = size;
    self.move = 1;
    
    CCNodeColor *background = [CCNodeColor nodeWithColor: BACKGROUND_COLOR ];
    [self addChild:background];
    
    CCButton *back = [CCButton buttonWithTitle:@"Back" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button_highlight.png"]];
    back.label.fontSize = 20;
    back.anchorPoint = ccp(0.5,0.5);
    back.name = @"size3";
    back.positionType = CCPositionTypeNormalized;
    [back setTarget:self selector:@selector(gameSceneBackClicked)];
    back.position = ccp(0.12f, 0.96f);
    [self addChild:back];
    
    

    if( [size isEqual: @"size3"]){
        self.grid = [GridScene spriteWithImageNamed:@"grid3.png" size:3 level:self.level gameSceneProtocol:self ];
    }else if([size isEqual: @"size4"]){
        self.grid = [GridScene spriteWithImageNamed:@"grid4.png" size:4 level:self.level gameSceneProtocol:self];
    }else if([size isEqual: @"size5"]){
        self.grid = [GridScene spriteWithImageNamed:@"grid5.png" size:5 level:self.level gameSceneProtocol:self];
    }else if([size isEqual: @"size6"]){
        self.grid = [GridScene spriteWithImageNamed:@"grid6.png" size:6 level:self.level gameSceneProtocol:self];
    }

    self.grid.anchorPoint = ccp(0.5,0.5);
    self.grid.positionType = CCPositionTypeNormalized;
    self.grid.position = ccp(0.5f, 0.59f);
    [self addChild:self.grid];
    
    
    NSString *moveStr = [NSString stringWithFormat:@"Move: %d",1];
    self.moveLabel = [CCLabelTTF labelWithString:moveStr fontName:@"Chalkboard" fontSize:24.0f];
    self.moveLabel.positionType = CCPositionTypeNormalized;
    self.moveLabel.color = RED_COLOR;
    self.moveLabel.anchorPoint = ccp(0.5,0.5);
    self.moveLabel.position = ccp(0.78f, 0.96f); // Middle of screen
    [self addChild:self.moveLabel];

    
    
    NSString *puzzle = [NSString stringWithFormat:@"%@ %@", @"Puzzle", level];
    CCLabelTTF *puzzleLabel = [CCLabelTTF labelWithString:puzzle fontName:@"Chalkboard" fontSize:24.0f];
    puzzleLabel.positionType = CCPositionTypeNormalized;
    puzzleLabel.color = RED_COLOR;
    puzzleLabel.anchorPoint = ccp(0.5,0.5);
    puzzleLabel.position = ccp(0.5f, 0.06f); // Middle of screen
    [self addChild:puzzleLabel];
    
    
     CCButton *next = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"next.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"next_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"next_disabled.png"]];
    next.label.fontSize = 20;
    next.anchorPoint = ccp(0.5,0.5);
    next.positionType = CCPositionTypeNormalized;
    [next setTarget:self selector:@selector(gameSceneBackClicked)];
    next.position = ccp(0.9f, 0.06f);
    [self addChild:next];


    CCButton *previous = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_disabled.png"]];
    previous.label.fontSize = 20;
    previous.anchorPoint = ccp(0.5,0.5);
    previous.positionType = CCPositionTypeNormalized;
    [previous setTarget:self selector:@selector(gameSceneBackClicked)];
    previous.position = ccp(0.1f, 0.06f);
    [self addChild:previous];
    

    CCButton *restart = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"restart.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"restart_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"restart_disabled.png"]];
    restart.label.fontSize = 20;
    restart.anchorPoint = ccp(0.5,0.5);
    restart.positionType = CCPositionTypeNormalized;
    [restart setTarget:self selector:@selector(restartClicked)];
    restart.position = ccp(0.40f, 0.20f);
    [self addChild:restart];
    
    
    CCButton *revert = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"revert.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"revert_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"revert_disabled.png"]];
    revert.label.fontSize = 20;
    revert.anchorPoint = ccp(0.5,0.5);
    revert.positionType = CCPositionTypeNormalized;
    [revert setTarget:self selector:@selector(gameSceneBackClicked)];
    revert.position = ccp(0.6f, 0.20f);
    [self addChild:revert];

    return self;
}


-(void) updateMove{
    self.move = self.move + 1;
    [self.moveLabel setString:[NSString stringWithFormat:@"Move: %d",self.move]];
}


-(void) finishGame{
    int bestScore = [Constants getScore:self.size level:self.level];
    if(self.move < bestScore || bestScore == 0 ){
        RecordScene *recordScene = [RecordScene scene:self.size level:self.level record:self.move];
        [[CCDirector sharedDirector] replaceScene:recordScene
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
    }
}



-(void)gameSceneBackClicked{
    [self.grid clean] ;
    [[CCDirector sharedDirector] replaceScene:self.backScene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
}

-(void)restartClicked{
    [self.grid restart];
}

@end
