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



@implementation ColorBlock

CGPoint lastTouchLocation;
BOOL firstTouch = YES;
BOOL firstMove = YES;
int size_;


id<GridSceneProtocol> prop_updateProtocol;
NSString* image;
CGSize contentsize;

+(id)initWithColor:(NSString*)color x:(int)_x y:(int)_y  contentSize:(CGSize)contentSize size:(int)size updateProtocol:(id<GridSceneProtocol>)updateProtocol
{
    size_ = size;
    prop_updateProtocol = updateProtocol;
    contentsize = contentSize;
    return [[self alloc] initWithImageNamed:color x:_x y:_y];
   
}



- (id) initWithImageNamed:(NSString*)imageName x:(int)_x y:(int)_y
{
    self = [self initWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:imageName]];
    if(!self)return (nil);
    
    self.prop_y = _y;
    self.prop_x = _x;
    
    float pos_x ;
    float pos_y ;

/*    if(size_ == 3){
        
    
    }else if(size_ == 4){
        
    
    }else if(size_ == 5){
        
    
    }else if(size_ == 6){
        
    }
  */
    
    if(self.prop_x == 0){
        pos_x = 0 ;
    }else if(self.prop_x == 1){
        pos_x = (contentsize.width/size_)  ;
    }else if(self.prop_x == 2){
        pos_x = (contentsize.width * 2/size_) ;
    }else if(self.prop_x == 3){
        pos_x = (contentsize.width * 3/size_) ;
    }else if(self.prop_x == 4){
        pos_x = (contentsize.width * 4/size_) ;
    }else if(self.prop_x == 5) {
        pos_x = (contentsize.width * 5/size_) ;
    }
    
    pos_x = pos_x + 50;

    int revy = size_ - self.prop_y;
    
    if(revy == 0){
        pos_y = 0 ;
    }else if(revy == 1){
        pos_y = (contentsize.height/size_)  ;
    }else if(revy == 2){
        pos_y = (contentsize.height * 2/size_)  ;
    }else if(revy == 3){
        pos_y = (contentsize.height * 3/size_)  ;
    }else if(revy == 4){
        pos_y = (contentsize.height * 4/size_)  ;
    }else if(revy == 5){
        pos_y = (contentsize.height * 5/size_)  ;
    }
    pos_y-=50;
    self.zOrder = 9;
    self.position = ccp(pos_x , pos_y);
    self.anchorPoint = CGPointMake(0.5f, 0.5f);
    
    self.userInteractionEnabled = true;
    
    return self;
}

-(void) changeImage:(NSString*) newimage{
    self.image = newimage;
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed:newimage]];
}

-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
   }

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
   
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
