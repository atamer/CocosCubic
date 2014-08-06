//
//  GridScene.h
//  CocosCubic
//
//  Created by Onur Atamer on 02/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "ColorBlock.h"
#import "CCSprite.h"
#import "GridSceneProtocol.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"


@interface GridScene : CCSprite<GridSceneProtocol>
+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size level:(NSString*)level;
- (void) restart;
@property NSString* image;
@property int level;
@property  int size;

@property  int hoverX;
@property  int hoverY;

@end

@interface ActionMoveBlock:NSObject{
}
@property CCActionMoveTo *action;
@property ColorBlock *block;
@end