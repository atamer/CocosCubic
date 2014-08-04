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


@interface GameScene : CCScene

+ (GameScene *)scene:(NSString*)size level:(NSString*)level back:(SelectLevelScene*)back;

-(void)gameSceneBackClicked;

@property NSString *size;
@property NSString *level;
@property SelectLevelScene* backScene;

@end
