//
//  SelectLevelScene.h
//  CocosCubic
//
//  Created by Onur Atamer on 27/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "SelectSizeScene.h"

@class GameScene;
@class SelectSizeScene;

@interface SelectLevelScene : CCScene

+ (SelectLevelScene *)scene:(NSString*)size ;
- (id)init:(NSString*)size;

@property NSString* size;
@property NSString* level;
@property NSTimer *timer;


@end
