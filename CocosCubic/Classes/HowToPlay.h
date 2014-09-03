//
//  HowToPlay.h
//  CocosCubic
//
//  Created by Onur Atamer on 11/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "GameSceneProtocol.h"

@class GridScene;

@interface HowToPlay : CCScene<GameSceneProtocol>

+ (HowToPlay *)scene;

@property GridScene* grid;
@property int play ;
@property CCSprite *finger;

@end
