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

NSMutableArray *blockArray;
NSMutableArray *positionArray;

BOOL actionActive ;
NSInteger actionDirection;
CGPoint touchStartPoint;
BOOL touchStart ;

CGFloat borderX1_2;
CGFloat borderX2_3;

CGFloat borderY1_2;
CGFloat borderY2_3;

+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size
{
    return [[self alloc] initWithImageNamed:image size:size];
}

- (id) initWithImageNamed:(NSString*)imageName size:(int)size
{
    self = [super initWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:imageName]];
    if(!self)return (nil);
    
    self.image = imageName;
    self.size = size;
    
    CCSprite *parentNode = [CCSprite node ];
    
    blockArray = [NSMutableArray array];
    positionArray = [NSMutableArray array];
    for(int i = 0 ; i < self.size + 2 ; i++ ){
        NSMutableArray *rowArray = [NSMutableArray array];
        NSMutableArray *rowPositionArray = [NSMutableArray array];
        for(int j = 0 ; j < self.size + 2 ; j++){
            NSString *image = [NSString stringWithFormat:@"%@%d.png", @"color",1];
            ColorBlock *color = [ColorBlock initWithColor:image x:j y:i contentSize:self.contentSize size:self.size updateProtocol:self];
            [rowArray  insertObject:color atIndex:j];
            [rowPositionArray insertObject:[NSValue valueWithCGPoint: color.position] atIndex:j];
            [parentNode addChild:color];
         //   CCLOG(@"*  %f %f ",color.position.x,color.position.y);
        }
        [blockArray insertObject:rowArray atIndex:i];
        [positionArray insertObject:rowPositionArray atIndex:i];
    }
    CGPoint  pointX1 =   [positionArray[1][1] CGPointValue];
    CGPoint  pointX2 =   [positionArray[1][2] CGPointValue];
    CGPoint  pointX3 =   [positionArray[1][3] CGPointValue];
    borderX1_2 = (pointX1.x + pointX2.x)/2;
    borderX2_3 = (pointX2.x + pointX3.x)/2;
    
    CGPoint  pointY1 =   [positionArray[1][1] CGPointValue];
    CGPoint  pointY2 =   [positionArray[2][1] CGPointValue];
    CGPoint  pointY3 =   [positionArray[3][1] CGPointValue];
    borderY1_2 = (pointY1.y + pointY2.y)/2;
    borderY2_3 = (pointY2.y + pointY3.y)/2;
    
    
    
    CGPoint point1 = CGPointMake(3.f, 292.f);
    CGPoint point2 = CGPointMake(3.f, 19.f);
    CGPoint point3 = CGPointMake(306.f, 292.f);
    CGPoint point4 = CGPointMake(306.f, 19.f);

    CGPoint pointArray[] = {point2,point1,point3,point4};
    
    static ccColor4F mask = {0, 0, 0, 1};
    CCColor *color = [CCColor colorWithCcColor4f:mask];
    
    
    CCDrawNode *stencil = [CCDrawNode new];
    [stencil drawPolyWithVerts:pointArray count:4 fillColor:color borderWidth:0.f borderColor:color];
    //    stencil.position = ccp(0.f, 100.f);
    // stencil.contentSize = CGSizeMake(200.f, 60.f);
    stencil.color = color;
    
    CCClippingNode *nodecc = [CCClippingNode new];
    nodecc.anchorPoint = ccp(0.5, 0.5);
    nodecc.position = CGPointMake(0, 0);
    
    nodecc.inverted = false;
    nodecc.stencil = stencil;
    nodecc.visible = true;
    
    [nodecc addChild:parentNode];
    
    [self addChild:nodecc];

    
    return self;
}

- (void) touchEndFunc:(UITouch*)uiTouch x:(int)x y:(int)y{
    /*
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
            for(int i = 0 ; i < self.size + 2 ; i++){
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
            for(int i = 0 ; i < self.size + 2 ; i++){
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
     */
    
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
        
        CCActionSequence *sequence;
        
       
        ColorBlock *block1;
        
        ColorBlock *selectedBlock;
        selectedBlock = blockArray[y][x];
        
        
        if(actionDirection == 1){
            
            // moves horizontal
            block1 = blockArray[y][1];
           // CCLOG(@"moves horizontal %f %f",block1.position.x,borderX1_2);
            if( (block1.position.x > borderX1_2  ) || (block1.position.x - differX) > borderX1_2 ){
                // slide to right
                // CCLOG(@"slideright %f %f ",differX,block2.position.x);
                touchStart = false;
                NSMutableArray *actionArray = [NSMutableArray array];
                
                for(int i = 0 ; i < self.size + 2 ; i++ ){
                    if( i != 0 ){
                        CGPoint pos = [positionArray[y][i] CGPointValue];
                        CCLOG(@"block %d %f-%f",i,pos.x,pos.y);
                        CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos.x,pos.y)];
                        actionArray[i-1] = actionMove;
                    }
                }
                
                // apply actions to block arrays except first one
                NSMutableArray *horizontalBlockArray = blockArray[y];
                for(int i = 1 ; i < [actionArray count] ; i++){
                    CCActionMoveTo *actionMove =  actionArray[i];
                    ColorBlock *block = horizontalBlockArray[i];
                    [block runAction:actionMove];
                }
                
                // action0 and complete sequencially
                sequence = [CCActionSequence actionOne: actionArray[0] two:[ExtActionCallFunc actionWithTarget:self selector:@selector(rightMoveComplete:) object:[NSNumber numberWithInt:y]]];
                
                
                ColorBlock *firstBlock = horizontalBlockArray[0];
                [firstBlock runAction:sequence];
                touchStart = false;
                
               
                //CCLOG(@"action move %f %f %f %f %f ",pos0.x, pos1.x, pos2.x, pos3.x, pos4.x);
                
            }else if(false){
//                block2.position.x < [borderX1 floatValue] || (block2.position.x + differX) < [borderX1 floatValue]
                //slide to left
               
               /* CGPoint pos0 = [positionArray[y][0] CGPointValue];
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
                */
                
            }else{
                //  CCLOG(@"move right %f %f",differX,block2.position.x );
                CCLOG(@"move**********");
                for(int i = 0 ; i < self.size + 2 ; i++ ){
                    ColorBlock *block = blockArray[y][i];
                    block.position = CGPointMake(block.position.x - differX , block.position.y );
                }
                
                /*
                block0.position = CGPointMake(block0.position.x - differX , block0.position.y );
                block1.position = CGPointMake(block1.position.x - differX , block1.position.y );
                block2.position = CGPointMake(block2.position.x - differX , block2.position.y );
                block3.position = CGPointMake(block3.position.x - differX , block3.position.y );
                block4.position = CGPointMake(block4.position.x - differX , block4.position.y );
                */
            }
            
            /* CCLOG(@"last position %f %f %f %f %f",((MoveBlock*)blockArray[y][0]).position.x,((MoveBlock*)blockArray[y][1]).position.x,
             ((MoveBlock*)blockArray[y][2]).position.x,((MoveBlock*)blockArray[y][3]).position.x,((MoveBlock*)blockArray[y][4]).position.x);
             */
        }else{
            // moves vertical
            CCLOG(@"moves vertical ");
            /*
            block0 = blockArray[0][x];
            block1 = blockArray[1][x];
            block2 = blockArray[2][x];
            block3 = blockArray[3][x];
            block4 = blockArray[4][x];*/
         /*
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
            */
        }
    }
}


-(void) reflectFirstLastColors{
    
 /*   for(int y = 0 ; y < size_ + 2 ; y++  ){
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
    */
    
}

- (void) rightMoveComplete:(id)obj{
    int row = [((NSNumber*)obj)intValue];
    
    // change last node position manually
    ColorBlock *lastBlock = blockArray[row][self.size + 1];
    
    // now change positions in blockarray slide right
    for(int i =  self.size + 1 ; i > 0 ; i--){
        blockArray[row][i] = blockArray[row][i-1];
    }
    
    blockArray[row][0] = lastBlock;
    CGPoint firstPosition = [positionArray[row][0] CGPointValue];
    lastBlock.position = CGPointMake(firstPosition.x , firstPosition.y);
    
    // switch colors
    [self reflectFirstLastColors];
    
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
