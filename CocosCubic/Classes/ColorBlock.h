//
//  ColorBlock.h
//  CocosCubic
//
//  Created by Onur Atamer on 02/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "CCSprite.h"
#import "GridSceneProtocol.h"
#import <UIKit/UIKit.h>

@interface ColorBlock : CCSprite

+(id)initWithColor:(NSString*)color x:(int)_x y:(int)_y contentSize:(CGSize)contentSize size:(int)size  updateProtocol:(id<GridSceneProtocol>)updateProtocol;


- (id) initWithImageNamed:(NSString*)imageName x:(int)_x y:(int)_y contentSize:(CGSize)contentSize size:(int)size updateProtocol:(id<GridSceneProtocol>)updateProtocol;


-(void) changeImage:(NSString*) image;
-(CGFloat) width;
-(CGFloat) height;

@property int prop_x;
@property int prop_y;
@property NSString* image;
@property id<GridSceneProtocol> updateProtocol;
@property int size;
@property CGSize parentContentSize;
@end
