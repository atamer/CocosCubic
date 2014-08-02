//
//  GridScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 02/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "GridScene.h"
#import "Constants.h"
#import "ColorBlock.h"
#import "ExtActionCallFunc.h"

@implementation ActionMoveBlock{
}
@end

@implementation GridScene

NSString* image_;
int size_;
NSMutableArray *blockArray;
NSArray *positionArray;

NSArray *borderArray;

BOOL actionActive ;
NSInteger actionDirection;
CGPoint touchStartPoint;
BOOL touchStart ;



+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size
{
    image_ = image;
    size_ = size;
    return [self spriteWithImageNamed:image];
}

- (id) initWithImageNamed:(NSString*)imageName
{
    self = [super initWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:imageName]];
    if(!self)return (nil);
    
    for(int i = 0 ; i < size_ ; i++ ){
        for(int j = 0 ; j < size_ ; j++){
            NSString *image = [NSString stringWithFormat:@"%@%d.png", @"color",i+1];
            ColorBlock *color = [ColorBlock initWithColor:image x:i y:j contentSize:self.contentSize size:size_ updateProtocol:self];
            [self addChild:color];
        }
    }
    return self;
}

- (void) touchEndFunc:(UITouch*)uiTouch x:(int)x y:(int)y{
    if(touchStart == true){
        actionActive = NO;
        touchStart = false;
        // put to first position
        NSMutableArray *actionMoveArray = [NSMutableArray new];
        CCActionMoveTo *actionMove;
        ColorBlock *block;
        CGPoint point;
        
        if(actionDirection == 1){
            //horizontal
            for(int i = 0 ; i < 5 ; i++){
                point = [positionArray[y][i] CGPointValue];
                block = blockArray[y][i];
                actionMove = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(point.x,point.y)];
                
                ActionMoveBlock *actionMoveBlock = [[ActionMoveBlock alloc] init];
                actionMoveBlock.action = actionMove;
                actionMoveBlock.block = block;
                
                [actionMoveArray addObject:actionMoveBlock];
            }
        }else{
            //vertical
            for(int i = 0 ; i < 5 ; i++){
                point = [positionArray[i][x] CGPointValue];
                block = blockArray[i][x];
                actionMove = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(point.x,point.y)];
                
                ActionMoveBlock *actionMoveBlock = [[ActionMoveBlock alloc ]init];
                actionMoveBlock.action = actionMove;
                actionMoveBlock.block = block;
                
                [actionMoveArray addObject:actionMoveBlock];
            }
        }
        
        for(ActionMoveBlock *moveBlock in actionMoveArray){
            CCActionMoveTo *action = moveBlock.action;
            ColorBlock *block = moveBlock.block;
            [block runAction:action];
        }
    }
    
}


- (void) touchBeginFunc:(UITouch*)uiTouch x:(int)x y:(int)y{
    touchStartPoint = [uiTouch locationInNode:self];
    touchStart = true;
    actionActive = NO;
    //  CCLOG(@"Current pos  %f %f ",touchStartPoint.x,touchStartPoint.y);
    
    
}



- (void) updateFunc:(float)differX differY:(float)differY x:(int)x y:(int)y{
    
    if(touchStart == true){

        float differX_abs = fabsf(differX);
        float differY_abs = fabsf(differY);
        
        
        if(actionActive == NO){
            // if movement is active do not change direction
            if(differX_abs > differY_abs){
                actionDirection = 1;
            }else{
                actionDirection = -1;
            }
            actionActive = YES;
        }
        
        CCActionMoveTo *actionMove0;
        CCActionMoveTo *actionMove1;
        CCActionMoveTo *actionMove2;
        CCActionMoveTo *actionMove3;
        CCActionMoveTo *actionMove4;
        CCActionSequence *sequence;
        
        
        ColorBlock *block0;
        ColorBlock *block1;
        ColorBlock *block2;
        ColorBlock *block3;
        ColorBlock *block4;
        
        ColorBlock *selectedBlock;
        selectedBlock = blockArray[y][x];
        
        
        if(actionDirection == 1){
            CCLOG(@"moves horizontal ");
            // moves horizontal
            block0 = blockArray[y][0];
            block1 = blockArray[y][1];
            block2 = blockArray[y][2];
            block3 = blockArray[y][3];
            block4 = blockArray[y][4];
            
            NSNumber *borderX1 = borderArray[0][0] ;
            NSNumber *borderX2 = borderArray[0][1] ;
            
            if( (block2.position.x > [borderX2 floatValue] ) || (block2.position.x - differX) > [borderX2 floatValue] ){
                // slide to right
                // CCLOG(@"slideright %f %f ",differX,block2.position.x);
                CGPoint pos0 = [positionArray[y][0] CGPointValue];
                
                CGPoint pos1 = [positionArray[y][1] CGPointValue];
                actionMove0 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos1.x,pos1.y)];
                
                
                CGPoint pos2 = [positionArray[y][2] CGPointValue];
                actionMove1 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos2.x,pos2.y)];
                
                CGPoint pos3 = [positionArray[y][3] CGPointValue];
                actionMove2 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos3.x,pos3.y)];
                
                CGPoint pos4 = [positionArray[y][4] CGPointValue];
                actionMove3 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos4.x,pos4.y)];
                
                // put begin
                block4.position = CGPointMake(pos0.x , pos0.y);
                
                touchStart = false;
                
                ColorBlock *temp = blockArray[y][0];
                
                NSMutableArray *arr = blockArray[y];
                
                
                [arr setObject:blockArray[y][4] atIndexedSubscript:0];
                [arr setObject:blockArray[y][3] atIndexedSubscript:4];
                [arr setObject:blockArray[y][2] atIndexedSubscript:3];
                [arr setObject:blockArray[y][1] atIndexedSubscript:2];
                [arr setObject:temp atIndexedSubscript:1];
                
                
                ((ColorBlock*)blockArray[y][0]).prop_x = 0;
                ((ColorBlock*)blockArray[y][1]).prop_x = 1;
                ((ColorBlock*)blockArray[y][2]).prop_x = 2;
                ((ColorBlock*)blockArray[y][3]).prop_x = 3;
                ((ColorBlock*)blockArray[y][4]).prop_x = 4;
                
                
                [block3 runAction:actionMove3];
                [block2 runAction:actionMove2];
                [block1 runAction:actionMove1];
                
                
                //CCLOG(@"action move %f %f %f %f %f ",pos0.x, pos1.x, pos2.x, pos3.x, pos4.x);
                
                sequence = [CCActionSequence actionOne: actionMove0 two:[ExtActionCallFunc actionWithTarget:self selector:@selector(rightMoveComplete:) object:[NSNumber numberWithInt:y]]];
                
                [block0 runAction:sequence];
                
                
            }else if(block2.position.x < [borderX1 floatValue] || (block2.position.x + differX) < [borderX1 floatValue] ){
                //slide to left
                CGPoint pos0 = [positionArray[y][0] CGPointValue];
                actionMove1 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos0.x, pos0.y)];
                
                CGPoint pos1 = [positionArray[y][1] CGPointValue];
                actionMove2 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos1.x,pos1.y)];
                
                CGPoint pos2 = [positionArray[y][2] CGPointValue];
                actionMove3 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos2.x,pos2.y)];
                
                CGPoint pos3 = [positionArray[y][3] CGPointValue];
                actionMove4 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos3.x,pos3.y)];
                
                CGPoint pos4 = [positionArray[y][4] CGPointValue];
                
                block0.position = CGPointMake(pos4.x , pos4.y);
                
                
                touchStart = false;
                
                NSMutableArray *arr = blockArray[y];
                ColorBlock *temp = blockArray[y][4];
                
                
                [arr setObject:blockArray[y][0] atIndexedSubscript:4];
                [arr setObject:blockArray[y][1] atIndexedSubscript:0];
                [arr setObject:blockArray[y][2] atIndexedSubscript:1];
                [arr setObject:blockArray[y][3] atIndexedSubscript:2];
                [arr setObject:temp atIndexedSubscript:3];
                
                
                ((ColorBlock*)blockArray[y][0]).prop_x = 0;
                ((ColorBlock*)blockArray[y][1]).prop_x = 1;
                ((ColorBlock*)blockArray[y][2]).prop_x = 2;
                ((ColorBlock*)blockArray[y][3]).prop_x = 3;
                ((ColorBlock*)blockArray[y][4]).prop_x = 4;
                
                
                [block1 runAction:actionMove1];
                [block2 runAction:actionMove2];
                [block3 runAction:actionMove3];
                
                CCActionCallFunc *callFunc = [ExtActionCallFunc actionWithTarget:self selector:@selector(leftMoveComplete:) object:[NSNumber numberWithInt:y]];
                sequence = [CCActionSequence actionOne: actionMove4 two:callFunc];
                [block4 runAction:sequence];
                
                
            }else{
                //  CCLOG(@"move right %f %f",differX,block2.position.x );
                block0.position = CGPointMake(block0.position.x - differX , block0.position.y );
                block1.position = CGPointMake(block1.position.x - differX , block1.position.y );
                block2.position = CGPointMake(block2.position.x - differX , block2.position.y );
                block3.position = CGPointMake(block3.position.x - differX , block3.position.y );
                block4.position = CGPointMake(block4.position.x - differX , block4.position.y );
                
            }
            
            /* CCLOG(@"last position %f %f %f %f %f",((MoveBlock*)blockArray[y][0]).position.x,((MoveBlock*)blockArray[y][1]).position.x,
             ((MoveBlock*)blockArray[y][2]).position.x,((MoveBlock*)blockArray[y][3]).position.x,((MoveBlock*)blockArray[y][4]).position.x);
             */
        }else{
            // moves vertical
            CCLOG(@"moves vertical ");
            block0 = blockArray[0][x];
            block1 = blockArray[1][x];
            block2 = blockArray[2][x];
            block3 = blockArray[3][x];
            block4 = blockArray[4][x];
            
            NSNumber *borderY1 = borderArray[1][0] ;
            NSNumber *borderY2 = borderArray[1][1] ;
            
            if( block2.position.y > [borderY1 floatValue] || (block2.position.y - differY)  > [borderY1 floatValue] ){
                //move up
                CGPoint pos0 = [positionArray[0][x] CGPointValue];
                actionMove1 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos0.x,pos0.y)];
                
                CGPoint pos1 = [positionArray[1][x] CGPointValue];
                actionMove2 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos1.x,pos1.y)];
                
                CGPoint pos2 = [positionArray[2][x] CGPointValue];
                actionMove3 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos2.x,pos2.y)];
                
                CGPoint pos3 = [positionArray[3][x] CGPointValue];
                actionMove4 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos3.x,pos3.y)];
                
                CGPoint pos4 = [positionArray[4][x] CGPointValue];
                block0.position = CGPointMake(pos4.x, pos4.y);
                
                touchStart = false;
                
                ColorBlock *temp = blockArray[0][x];
                
                NSMutableArray *arr = blockArray[0];
                [arr setObject:blockArray[1][x] atIndexedSubscript:x];
                
                arr = blockArray[1];
                [arr setObject:blockArray[2][x] atIndexedSubscript:x];
                
                arr = blockArray[2];
                [arr setObject:blockArray[3][x] atIndexedSubscript:x];
                
                arr = blockArray[3];
                [arr setObject:blockArray[4][x] atIndexedSubscript:x];
                
                arr = blockArray[4];
                [arr setObject:temp atIndexedSubscript:x];
                
                ((ColorBlock*)blockArray[0][x]).prop_y = 0;
                ((ColorBlock*)blockArray[1][x]).prop_y = 1;
                ((ColorBlock*)blockArray[2][x]).prop_y = 2;
                ((ColorBlock*)blockArray[3][x]).prop_y = 3;
                ((ColorBlock*)blockArray[4][x]).prop_y = 4;
                
                [block1 runAction:actionMove1];
                [block2 runAction:actionMove2];
                [block3 runAction:actionMove3];
                
                sequence = [CCActionSequence actionOne: actionMove4 two:[ExtActionCallFunc actionWithTarget:self selector:@selector(upMoveComplete:)object:[NSNumber numberWithInt:x]]];
                [block4 runAction:sequence];
                
                
            }else if(block2.position.y < [borderY2 floatValue] ||  (block2.position.y - differY) < [borderY2 floatValue]  ){
                //move down
                CGPoint pos4 = [positionArray[4][x] CGPointValue];
                actionMove3 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos4.x,pos4.y)];
                
                CGPoint pos3 = [positionArray[3][x] CGPointValue];
                actionMove2 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos3.x,pos3.y)];
                
                CGPoint pos2 = [positionArray[2][x] CGPointValue];
                actionMove1 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos2.x,pos2.y)];
                
                CGPoint pos1 = [positionArray[1][x] CGPointValue];
                actionMove0 = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos1.x,pos1.y)];
                
                
                CGPoint pos0 = [positionArray[0][x] CGPointValue];
                block4.position = CGPointMake(pos0.x, pos0.y);
                
                touchStart = false;
                ColorBlock *temp = blockArray[4][x];
                
                NSMutableArray *arr = blockArray[4];
                [arr setObject:blockArray[3][x] atIndexedSubscript:x ];
                
                arr = blockArray[3];
                [arr setObject:blockArray[2][x] atIndexedSubscript:x ];
                
                arr = blockArray[2];
                [arr setObject:blockArray[1][x] atIndexedSubscript:x ];
                
                arr = blockArray[1];
                [arr setObject:blockArray[0][x] atIndexedSubscript:x ];
                
                arr = blockArray[0];
                [arr setObject:temp atIndexedSubscript:x ];
                
                
                ((ColorBlock*)blockArray[0][x]).prop_y = 0;
                ((ColorBlock*)blockArray[1][x]).prop_y = 1;
                ((ColorBlock*)blockArray[2][x]).prop_y = 2;
                ((ColorBlock*)blockArray[3][x]).prop_y = 3;
                ((ColorBlock*)blockArray[4][x]).prop_y = 4;
                
                [block2 runAction:actionMove2];
                [block1 runAction:actionMove1];
                [block0 runAction:actionMove0];
                
                
                sequence = [CCActionSequence actionOne: actionMove3 two:[ExtActionCallFunc actionWithTarget:self selector:@selector(downMoveComplete:) object:[NSNumber numberWithInt:x]]];
                [block3 runAction:sequence];
                
                
            }else{
                //                CCLOG(@"moves little %f",differY);
                block0.position = CGPointMake(block0.position.x , block0.position.y - differY);
                block1.position = CGPointMake(block1.position.x , block1.position.y - differY);
                block2.position =CGPointMake(block2.position.x , block2.position.y - differY);
                block3.position =CGPointMake(block3.position.x , block3.position.y - differY);
                block4.position = CGPointMake(block4.position.x , block4.position.y - differY);
            }
        }
    }
}


-(void) reflectFirstLastColors{
    
    for(int y = 0 ; y < size_ + 2 ; y++  ){
        for(int x = 0 ; x < size_ + 2 ; x++ ){
            if(y == 0 && x != 0 && x != (size_+1)){
                ColorBlock *blockFirst = blockArray[0][x];
                ColorBlock *blockLast = blockArray[size_][x];
                //  CCLOG(@"%d%d --> %d%d\n",rowCount,x,0,x);
                [blockFirst changeImage:blockLast.image];
                
            }
            if(x == 0 && y != 0 && y != (size_+1)){
                ColorBlock *blockFirst = blockArray[y][0];
                ColorBlock *blockLast = blockArray[y][size_];
                [blockFirst changeImage:blockLast.image];
                //CCLOG(@"%d%d --> %d%d\n",y,columnCount,y,0);
            }
            
            if( y == (size_ + 1) && x != (size_ + 1) && x != 0 ){
                ColorBlock *blockLast = blockArray[y][x];
                ColorBlock *blockFirst = blockArray[1][x];
                [blockLast changeImage:blockFirst.image];
            }
            
            if( y != (size_ + 1) && x == (size_ + 1) && y != 0 ){
                ColorBlock *blockLast = blockArray[y][x];
                ColorBlock *blockFirst = blockArray[y][1];
                [blockLast changeImage:blockFirst.image];
            }
            
        }
    }
    
    
}

- (void) rightMoveComplete:(id)obj{
    // switch colors
    
    [self reflectFirstLastColors];
    
    
    
    //    CCLOG(@"slide position %f %f %f %f %f",block0.position.x,block1.position.x,
    //         block2.position.x,block3.position.x,block4.position.x);
}

- (void) leftMoveComplete:(id)obj{
    [self reflectFirstLastColors];
}

- (void) upMoveComplete:(id)obj{
    [self reflectFirstLastColors];
}

- (void) downMoveComplete:(id)obj{
    [self reflectFirstLastColors];
}





@end
