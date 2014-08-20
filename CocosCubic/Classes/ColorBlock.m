//
//  ColorBlock.m
//  CocosCubic
//
//  Created by Onur Atamer on 02/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "ColorBlock.h"
#import "CCSpriteFrame.h"
#import "GridSceneProtocol.h"
#import "UITouch+CC.h"


@implementation ColorBlock

CGPoint lastTouchLocation;
BOOL firstTouch = YES;
BOOL firstMove = YES;


+(id)initWithColor:(NSString*)color x:(int)_x y:(int)_y  contentSize:(CGSize)contentSize size:(int)size
{
    return [[self alloc] initWithImageNamed:color x:_x y:_y contentSize:contentSize size:size];
   
}



- (id) initWithImageNamed:(NSString*)imageName x:(int)_x y:(int)_y contentSize:(CGSize)parentContentSize size:(int)size
{
    self = [self initWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:imageName]];
    if(!self)return (nil);
    
    self.prop_y = _y;
    self.prop_x = _x;
    self.parentContentSize  = parentContentSize;
    self.size = size;
    self.image = imageName;
    
    float pos_x ;
    float pos_y ;
    
    if(self.prop_x == 0){
        pos_x = - (self.parentContentSize.width/size)  ;
    }else if(self.prop_x == 1){
        pos_x = 0 ;
    }else if(self.prop_x == 2){
        pos_x = (self.parentContentSize.width/size)  ;
    }else if(self.prop_x == 3){
        pos_x = (self.parentContentSize.width * 2/size) ;
    }else if(self.prop_x == 4){
        pos_x = (self.parentContentSize.width * 3/size) ;
    }else if(self.prop_x == 5) {
        pos_x = (self.parentContentSize.width * 4/size) ;
    }else if(self.prop_x == 6) {
        pos_x = (self.parentContentSize.width * 5/size) ;
    }else if(self.prop_x == 7) {
        pos_x = (self.parentContentSize.width * 6 /size) ;
    }

    int revy = (size + 1 ) - self.prop_y;
    
    if(revy == 0){
        pos_y = -(self.parentContentSize.height/size)  ;
    }else if(revy == 1){
        pos_y = 0 ;
    }else if(revy == 2){
        pos_y = (self.parentContentSize.height/size)  ;
    }else if(revy == 3){
        pos_y = (self.parentContentSize.height * 2/size)  ;
    }else if(revy == 4){
        pos_y = (self.parentContentSize.height * 3/size)  ;
    }else if(revy == 5){
        pos_y = (self.parentContentSize.height * 4/size)  ;
    }else if(revy == 6){
        pos_y = (self.parentContentSize.height * 5/size)  ;
    }else if(revy == 7){
        pos_y = (self.parentContentSize.height * 6/size)  ;
    }
    
    if(size == 3){
        pos_x = pos_x + 50;
        pos_y = pos_y + 50;
    }
    
    if(size == 4 ){
        self.scale = 0.75;
        
        pos_x = pos_x + 40;
        pos_y = pos_y + 40;
    }
    
    if(size == 5){
        self.scale = 0.6;
        pos_x = pos_x + 29;
        pos_y = pos_y + 28;
    }

    if(size == 6){
        self.scale = 0.5;
        pos_x = pos_x + 25;
        pos_y = pos_y + 25 ;
    }
    
    self.anchorPoint = CGPointMake(0.5f, 0.5f);
    self.userInteractionEnabled = false;
    
    self.zOrder = 9;

    self.position = ccp(pos_x , pos_y);

    
    return self;
}

-(void) changeImage:(NSString*) newimage{
    self.image = newimage;
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed:newimage]];

}

-(CGFloat) width
{
    return [self boundingBox].size.width;
}

-(CGFloat) height
{
    return [self boundingBox].size.height;
}


@end
