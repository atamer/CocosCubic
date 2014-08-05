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
            NSString *image ;
            if(i - 1 <= 0){
                image = [NSString stringWithFormat:@"%@%d.png", @"color",1];
            }else if(i < 7){
                image = [NSString stringWithFormat:@"%@%d.png", @"color",i];
            }else{
                image = [NSString stringWithFormat:@"%@%d.png", @"color",6];
            }
            
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
    

    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    CGPoint point4;
    
    if(self.size == 3 || self.size == 4){
        point1 = CGPointMake(3.f, 305.f);
        point2 = CGPointMake(3.f, 3.f);
        point3 = CGPointMake(306.f, 305.f);
        point4 = CGPointMake(306.f, 3.f);
    }else if(self.size == 5){
        point1 = CGPointMake(3.f, 305.f);
        point2 = CGPointMake(3.f, 2.f);
        point3 = CGPointMake(305.f, 305.f);
        point4 = CGPointMake(305.f, 2.f);
    }else if(self.size == 6){
        point1 = CGPointMake(3.f, 305.f);
        point2 = CGPointMake(3.f, 3.f);
        point3 = CGPointMake(306.f, 305.f);
        point4 = CGPointMake(306.f, 3.f);
    }
    
    CGPoint pointArray[] = {point2,point1,point3,point4};
    
    static ccColor4F mask = {0, 0, 0, 1};
    CCColor *color = [CCColor colorWithCcColor4f:mask];
    
    
    CCDrawNode *stencil = [CCDrawNode new];
    [stencil drawPolyWithVerts:pointArray count:4 fillColor:color borderWidth:0.f borderColor:color];
    stencil.color = color;
    
    CCClippingNode *nodecc = [CCClippingNode new];
    nodecc.anchorPoint = ccp(0.5, 0.5);
    nodecc.position = CGPointMake(0, 0);
    
    nodecc.inverted = false;
    nodecc.stencil = stencil;
    nodecc.visible = true;
    
    [nodecc addChild:parentNode];
    
    [self addChild:nodecc];
 //   [self reflectFirstLastColors];
    
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
        ColorBlock *block2;
        
        ColorBlock *selectedBlock;
        selectedBlock = blockArray[y][x];
        
        
        if(actionDirection == 1){
            
            // moves horizontal
            block1 = blockArray[y][1];
            block2 = blockArray[y][2];
            if( (block1.position.x > borderX1_2  ) || (block1.position.x - differX) > borderX1_2 ){
                //move right
                touchStart = false;
                NSMutableArray *actionArray = [NSMutableArray array];
                
                for(int i = 0 ; i < self.size + 2 ; i++ ){
                    if( i != 0 ){
                        CGPoint pos = [positionArray[y][i] CGPointValue];

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
               
                //CCLOG(@"action move %f %f %f %f %f ",pos0.x, pos1.x, pos2.x, pos3.x, pos4.x);
                
            }else if( block2.position.x < borderX1_2 || (block2.position.x + differX) < borderX1_2){
                //move left
                touchStart = false;
                NSMutableArray *actionArray = [NSMutableArray array];
                
                for(int i = 0 ; i < self.size + 2 ; i++ ){
                    if( i != self.size + 1  ){
                        CGPoint pos = [positionArray[y][i] CGPointValue];
                        CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos.x,pos.y)];
                        actionArray[i] = actionMove;
                    }
                }
                
                // apply actions to block arrays except first one
                NSMutableArray *horizontalBlockArray = blockArray[y];
                for(int i = 1 ; i < [actionArray count] ; i++){
                    CCActionMoveTo *actionMove =  actionArray[i];
                    ColorBlock *block = horizontalBlockArray[i+1];
                    [block runAction:actionMove];
                }
                
                // action0 and complete sequencially
                sequence = [CCActionSequence actionOne: actionArray[0] two:[ExtActionCallFunc actionWithTarget:self selector:@selector(leftMoveComplete:) object:[NSNumber numberWithInt:y]]];
                
                ColorBlock *firstBlock = horizontalBlockArray[1];
                [firstBlock runAction:sequence];

                
            }else{
                //  CCLOG(@"move right %f %f",differX,block2.position.x );
                for(int i = 0 ; i < self.size + 2 ; i++ ){
                    ColorBlock *block = blockArray[y][i];
                    block.position = CGPointMake(block.position.x - differX , block.position.y );
                }
            }
        }else{
            // moves vertical
            block1 = blockArray[1][x];
            block2 = blockArray[2][x];
            
            if( block2.position.y > borderY1_2 || (block2.position.y - differY)  > borderY1_2 ){
                //move up
                touchStart = false;
                NSMutableArray *actionArray = [NSMutableArray array];
                
                for(int i = 0 ; i < self.size + 2 ; i++ ){
                    if( i != self.size + 1  ){
                        CGPoint pos = [positionArray[i][x] CGPointValue];
                        CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos.x,pos.y)];
                        actionArray[i] = actionMove;
                    }

                }
                
                // apply actions to block arrays except first one
                for(int i = 1 ; i < [actionArray count] ; i++){
                    CCActionMoveTo *actionMove =  actionArray[i];
                    ColorBlock *block = blockArray[i+1][x];
                    [block runAction:actionMove];
                }
           
                // action0 and complete sequencially
                sequence = [CCActionSequence actionOne: actionArray[0] two:[ExtActionCallFunc actionWithTarget:self selector:@selector(upMoveComplete:) object:[NSNumber numberWithInt:x]]];
                
                ColorBlock *firstBlock = blockArray[1][x];
                [firstBlock runAction:sequence];
           
          
            }else if( block1.position.y < borderY1_2 || (block1.position.y - differY)  < borderY1_2 ){
                //move down
                touchStart = false;
                
                NSMutableArray *actionArray = [NSMutableArray array];
                
                for(int i = 0 ; i < self.size + 2 ; i++ ){
                    if( i != 0 ){
                        CGPoint pos = [positionArray[i][x] CGPointValue];
                        CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:0.1 position:CGPointMake(pos.x,pos.y)];
                        actionArray[i-1] = actionMove;
                    }
                    
                }
                
                // apply actions to block arrays except first one
                for(int i = 1 ; i < [actionArray count] ; i++){
                    CCActionMoveTo *actionMove =  actionArray[i];
                    ColorBlock *block = blockArray[i][x];
                    [block runAction:actionMove];
                }
                
                // action0 and complete sequencially
                sequence = [CCActionSequence actionOne: actionArray[0] two:[ExtActionCallFunc actionWithTarget:self selector:@selector(downMoveComplete:) object:[NSNumber numberWithInt:x]]];
                
                ColorBlock *firstBlock = blockArray[0][x];
                [firstBlock runAction:sequence];
                
            }else{
                for(int i = 0 ; i < self.size + 2 ; i++ ){
                    ColorBlock *block = blockArray[i][x];
                    block.position = CGPointMake(block.position.x , block.position.y - differY);
                }
                
            }
            
        }
    }
}


-(void) reflectFirstLastColors{
    
    for(int y = 0 ; y < self.size + 2 ; y++  ){
        for(int x = 0 ; x < self.size + 2 ; x++ ){
            ColorBlock *block =  blockArray[y][x];
            block.prop_y = y;
            block.prop_x = x;
            
            if(y == 0 && x != 0 && x != (self.size+1)){
                ColorBlock *blockFirst = blockArray[0][x];
                ColorBlock *blockLast = blockArray[self.size][x];
                [blockFirst changeImage:blockLast.image];
            }
            if(x == 0 && y != 0 && y != (self.size+1)){
                ColorBlock *blockFirst = blockArray[y][0];
                ColorBlock *blockLast = blockArray[y][self.size];
                [blockFirst changeImage:blockLast.image];

            }
            
            if( y == (self.size + 1) && x != (self.size + 1) && x != 0 ){
                ColorBlock *blockLast = blockArray[y][x];
                ColorBlock *blockFirst = blockArray[1][x];
                [blockLast changeImage:blockFirst.image];
            }
            
            if( y != (self.size + 1) && x == (self.size + 1) && y != 0 ){
                ColorBlock *blockLast = blockArray[y][x];
                ColorBlock *blockFirst = blockArray[y][1];
                [blockLast changeImage:blockFirst.image];
            }
            
        }
    }
    
    self.hoverY  = 1 ;
    self.hoverX  = 1 ;
    float interval = 1.0f/(self.size * 1.5f);
    [self schedule:@selector(hoverBlock) interval:interval repeat:(self.size * self.size ) delay:0];
}

-(void) hoverBlock{
    ColorBlock *block =  blockArray[self.hoverY][self.hoverX];
    
    NSString *image = block.image ;
    NSArray *testArray = [image componentsSeparatedByString:@"."];
    NSString *name = (NSString*)testArray[0];
    image = [NSString stringWithFormat:@"%@_hover.png", name];
    [block changeImage:image];
    
    self.hoverX = self.hoverX + 1;
    if(self.hoverX == self.size +1){
        self.hoverX = 1 ;
        self.hoverY = self.hoverY + 1;
    }
    
    
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
    int row = [((NSNumber*)obj)intValue];
    
    // change last node position manually
    ColorBlock *firstBlock = blockArray[row][0];
    
    // now change positions in blockarray slide right
    for( int i = 0 ; i <  self.size + 1;  i++ ){
        blockArray[row][i] = blockArray[row][i+1];
    }
    
    blockArray[row][self.size + 1] = firstBlock;
    CGPoint lastPosition = [positionArray[row][self.size + 1] CGPointValue];
    firstBlock.position = CGPointMake(lastPosition.x , lastPosition.y);
    
    // switch colors
    [self reflectFirstLastColors];
}

- (void) upMoveComplete:(id)obj{
    int column = [((NSNumber*)obj)intValue];
    
    // change last node position manually
    ColorBlock *firstBlock = blockArray[0][column];
    
    // now change positions in blockarray slide right
    for( int i = 0 ; i <  self.size + 1;  i++ ){
        blockArray[i][column] = blockArray[i+1][column];
    }
    
    blockArray[self.size + 1][column] = firstBlock;
    CGPoint lastPosition = [positionArray[self.size + 1][column] CGPointValue];
    firstBlock.position = CGPointMake(lastPosition.x , lastPosition.y);
    
    // switch colors
    [self reflectFirstLastColors];
}

- (void) downMoveComplete:(id)obj{
    int column = [((NSNumber*)obj)intValue];
    
    // change last node position manually
    ColorBlock *lastBlock = blockArray[self.size + 1][column];
    
    // now change positions in blockarray slide right
    for(int i =  self.size + 1 ; i > 0 ; i--){
        blockArray[i][column] = blockArray[i-1][column];
    }
    
    blockArray[0][column] = lastBlock;
    CGPoint firstPosition = [positionArray[0][column] CGPointValue];
    lastBlock.position = CGPointMake(firstPosition.x , firstPosition.y);
    
    // switch colors
    [self reflectFirstLastColors];
}

-(void) restart{
    
}



@end
