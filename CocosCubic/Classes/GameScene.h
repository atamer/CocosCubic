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

+ (GameScene *)scene:(NSString*)size level:(NSString*)level back:(SelectLevelScene*)back;

-(void)gameSceneBackClicked;

@property NSString *size;
@property NSString *level;
@property SelectLevelScene* backScene;
@property GridScene* grid;
@property int move;
@property CCLabelTTF* moveLabel;
@end
