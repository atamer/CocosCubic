//
//  GameOverScene.h
//  CocosCubic
//
//  Created by Onur Atamer on 17/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"


@interface GameOverScene : CCScene

@property NSString* size;
@property NSString* level;
@property int record;


+ (GameOverScene *)scene:(NSString*)size level:(NSString*)level record:(int)record;

@end
