//
//  GameScene.h
//  CocosCubic
//
//  Created by Onur Atamer on 28/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "SelectLevelScene.h"
#import "GridScene.h"
#import "GameSceneProtocol.h"


@interface GameScene : CCScene<GameSceneProtocol>

+ (GameScene *)scene:(NSString*)size level:(NSString*)level ;

-(void)gameSceneBackClicked;


@property NSString *size;
@property NSString *level;
@property GridScene* grid;
@property int move;

@property CCLabelTTF* moveLabel;
@property CCLabelTTF* recordLabel;

@property CCButton *restart;
@property CCButton *revert;
@property CCButton *next;
@property CCButton *previous;
@property CCLabelTTF *puzzleLabel;
@end
