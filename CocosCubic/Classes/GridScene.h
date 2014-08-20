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
#import "GameSceneProtocol.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"


@interface GridScene : CCSprite
+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size level:(NSString*)level gameSceneProtocol:(id<GameSceneProtocol>)gameSceneProtocol;
+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size level:(NSString*)level random:(BOOL)random gameSceneProtocol:(id<GameSceneProtocol>)gameSceneProtocol;
+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size level:(NSString*)level random:(BOOL)random  reverse:(BOOL)reverse gameSceneProtocol:(id<GameSceneProtocol>)gameSceneProtocol;


- (void) clean;
-(void) moveDown:(int)x;
-(void) moveRight:(int)y;
-(void)revert;

@property NSString* image;
@property int level;
@property  int size;

@property  int hoverX;
@property  int hoverY;
@property id<GameSceneProtocol>gameSceneProtocol;

@end

@interface ActionMoveBlock:NSObject{
}
@property CCActionMoveTo *action;
@property ColorBlock *block;
@end