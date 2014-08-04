//
//  SelectSizeScene.h
//  CocosCubic
//
//  Created by Onur Atamer on 26/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "SelectLevelScene.h"


@class SelectLevelScene;

@interface SelectSizeScene : CCScene
    

+ (SelectSizeScene *)scene;
- (id)init;

@property SelectLevelScene* selectLevel;

@end
