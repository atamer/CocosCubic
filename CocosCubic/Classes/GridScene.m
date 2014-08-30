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
#import "RecordScene.h"
#import <objc/message.h>

@implementation ActionMoveBlock{
}
@end

@implementation GridScene


NSMutableArray *blockArray;
NSMutableArray *positionArray;
NSMutableArray *borderArrayX;
NSMutableArray *borderArrayY;

BOOL actionActive ;
NSInteger actionDirection;
CGPoint touchStartPoint;
BOOL directionFound  ;

BOOL endGame;
BOOL touchStart;

CGFloat borderX1_2;
CGFloat borderX2_3;

CGFloat borderY1_2;
CGFloat borderY2_3;

NSString *lastMove;
int lastMoveIndex;
int blockIndex  ;
CCTime ANIM_TIME  ;

+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size level:(NSString*)level gameSceneProtocol:(id<GameSceneProtocol>)gameSceneProtocol
{
    return [[self alloc] initWithImageNamed:image size:size level:level random:YES  reverse:NO gameSceneProtocol:gameSceneProtocol ];
}

+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size level:(NSString*)level random:(BOOL)random gameSceneProtocol:(id<GameSceneProtocol>)gameSceneProtocol
{
    return [[self alloc] initWithImageNamed:image size:size level:level random:random reverse:NO gameSceneProtocol:gameSceneProtocol ];
}


+ (GridScene *)spriteWithImageNamed:(NSString*)image size:(int)size level:(NSString*)level random:(BOOL)random  reverse:(BOOL)reverse gameSceneProtocol:(id<GameSceneProtocol>)gameSceneProtocol
{
    return [[self alloc] initWithImageNamed:image size:size level:level random:random reverse:reverse gameSceneProtocol:gameSceneProtocol ];
}


- (id) initWithImageNamed:(NSString*)imageName size:(int)size level:(NSString*)level random:(BOOL)random reverse:(BOOL)reverse gameSceneProtocol:(id<GameSceneProtocol>)gameSceneProtocol
{
    self = [super initWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:imageName]];
    if(!self)return (nil);
    
    
    self.tracker = [[GAI sharedInstance] defaultTracker];
    
    endGame = YES;
    touchStart = NO;
    self.image = imageName;
    self.size = size;
    self.level = [level intValue];
    self.gameSceneProtocol = gameSceneProtocol;
    
    CCSprite *parentNode = [CCSprite node ];
    
    blockArray = [NSMutableArray array];
    positionArray = [NSMutableArray array];
    for(int i = 0 ; i < self.size + 2 ; i++ ){
        NSMutableArray *rowArray = [NSMutableArray array];
        NSMutableArray *rowPositionArray = [NSMutableArray array];
        for(int j = 0 ; j < self.size + 2 ; j++){
            NSString *image ;
            if(reverse == YES){
                if(j - 1 <= 0){
                    image = [NSString stringWithFormat:@"%@%d.png", @"color",1];
                }else if(j < 7){
                    image = [NSString stringWithFormat:@"%@%d.png", @"color",j];
                }else{
                    image = [NSString stringWithFormat:@"%@%d.png", @"color",6];
                }
            }else{
                if(i - 1 <= 0){
                    image = [NSString stringWithFormat:@"%@%d.png", @"color",1];
                }else if(i < 7){
                    image = [NSString stringWithFormat:@"%@%d.png", @"color",i];
                }else{
                    image = [NSString stringWithFormat:@"%@%d.png", @"color",6];
                }
            }
            
            ColorBlock *color ;
            color = [ColorBlock initWithColor:image x:j y:i contentSize:self.contentSize size:self.size];


            
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
    
    
    borderArrayX = [NSMutableArray array];
    borderArrayY = [NSMutableArray array];
    
    for(int i = 0 ; i < self.size +1 ; i++){
        CGPoint  tempX1 = [positionArray[1][i] CGPointValue];
        CGPoint  tempX2 = [positionArray[1][i+1] CGPointValue];
        CGFloat middle =  (tempX1.x + tempX2.x) / 2;
        [borderArrayX insertObject:[NSNumber numberWithFloat:middle] atIndex:i];
    }
    

    for(int i = 0 ; i < self.size +1 ; i++){
        CGPoint  tempX1 = [positionArray[i][1] CGPointValue];
        CGPoint  tempX2 = [positionArray[i+1][1] CGPointValue];
        CGFloat middle =  (tempX1.y + tempX2.y) / 2;
        [borderArrayY insertObject:[NSNumber numberWithFloat:middle] atIndex:i];
    }

    
    

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
    
    
    [self reflectFirstLastColors:NO reverse:NO] ;
    
    if(random == YES){
        [self unmatchColors];
    }

    self.userInteractionEnabled = true;
    [self showAdv];
    
    return self;
}

- (void) touchEndFunc:(UITouch*)uiTouch x:(int)x y:(int)y{
    
    if(directionFound == true && endGame == NO){
        actionActive = NO;
        directionFound = false;
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
                actionMove = [CCActionMoveTo actionWithDuration:ANIM_TIME position:CGPointMake(point.x,point.y)];
                
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
                actionMove = [CCActionMoveTo actionWithDuration:ANIM_TIME position:CGPointMake(point.x,point.y)];
                
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


-(void) touchMoved:(UITouch *)touchParam withEvent:(UIEvent *)event{
    
    self.currentTouchParam = touchParam;
    self.currentUIEvent = event;
    
    if(touchStart == YES){
        CGPoint touchLocation = [touchParam locationInNode:self];
        
        float x_differ = fabsf(touchStartPoint.x - touchLocation.x);
        float y_differ = fabsf(touchStartPoint.y - touchLocation.y);
        
        float x_differ_sign = touchStartPoint.x - touchLocation.x;
        float y_differ_sign = touchStartPoint.y - touchLocation.y;
        
        touchStartPoint = touchLocation;
        
        // sliding animation may be in use
        if(actionActive == NO && endGame == NO){
            if(directionFound == NO){
                // difference for trigger
                if(x_differ > 2 || y_differ > 2){
                    directionFound = YES;
                    // if movement is active do not change direction
                    if(x_differ > y_differ){
                        actionDirection = 1;
                        [self findBlockIndex:touchParam];
                        [self updateFunc:touchLocation differ: x_differ_sign ];
                    }else{
                        actionDirection = -1;
                        [self findBlockIndex:touchParam];
                        [self updateFunc:touchLocation differ:y_differ_sign ];
                    }
                }
            }else{
                if(actionDirection == 1 ){
                    [self updateFunc:touchLocation differ:x_differ_sign];
                }else{
                    [self updateFunc:touchLocation differ:y_differ_sign ];
                }
                
            }
        }
        
 
    }
}

-(void) findBlockIndex:(UITouch *)touch{
    CGPoint touchLocation = [touch locationInNode:self];
    blockIndex = 0 ;
    if(actionDirection == 1){
        //horizontal movement
        // find out block
        // Y axis is reversible
        for( blockIndex = 0 ; blockIndex < self.size  ; blockIndex++){
            if( [((NSNumber*)borderArrayY[blockIndex]) floatValue] >= touchLocation.y &&
               [((NSNumber*)borderArrayY[blockIndex+1]) floatValue] < touchLocation.y ){
                break;
            }
        }
    }else{
        for( blockIndex = 0 ; blockIndex < self.size  ; blockIndex++){
            if( [((NSNumber*)borderArrayX[blockIndex]) floatValue] < touchLocation.x &&
               [((NSNumber*)borderArrayX[blockIndex+1]) floatValue] >= touchLocation.x ){
                break;
            }
        }
    }
    blockIndex++;

}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touchStartPoint = [touch locationInNode:self];
    touchStart = YES;
    
    self.currentTouchParam = touch;
    self.currentUIEvent = event;
    
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{

    self.currentTouchParam = touch;
    self.currentUIEvent = event;
    
    directionFound = false;
    if(endGame == NO && actionActive == NO){
       
        // put to first position
        NSMutableArray *actionMoveArray = [NSMutableArray new];
        CCActionMoveTo *actionMove;
        ColorBlock *block;
        CGPoint point;
        
        
        if(actionDirection == 1){
            //horizontal
            for(int i = 0 ; i < self.size + 2 ; i++){
                point = [positionArray[blockIndex][i] CGPointValue];
                block = blockArray[blockIndex][i];
                actionMove = [CCActionMoveTo actionWithDuration:ANIM_TIME position:CGPointMake(point.x,point.y)];
                
                ActionMoveBlock *actionMoveBlock = [[ActionMoveBlock alloc] init];
                actionMoveBlock.action = actionMove;
                actionMoveBlock.block = block;
                
                [actionMoveArray addObject:actionMoveBlock];
            }
        }else{
            //vertical
            for(int i = 0 ; i < self.size + 2 ; i++){
                point = [positionArray[i][blockIndex] CGPointValue];
                block = blockArray[i][blockIndex];
                actionMove = [CCActionMoveTo actionWithDuration:ANIM_TIME position:CGPointMake(point.x,point.y)];
                
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


- (void) updateFunc:(CGPoint)touchLocation differ:(CGFloat)differ{
    
    // check movement pattern
    
    ColorBlock *block1;
    ColorBlock *block2;

    if(actionDirection == 1){
        // moves horizontal
        block1 = blockArray[blockIndex][1];
        block2 = blockArray[blockIndex][2];
        if( (block1.position.x > borderX1_2  ) || (block1.position.x - differ) > borderX1_2 ){
            //move right
            directionFound = false;
            [self moveRight:blockIndex sel:nil checkComplete:YES revert:NO];
        }else if( block2.position.x < borderX1_2 || (block2.position.x + differ) < borderX1_2){
            //move left
            directionFound = false;
            [self moveLeft:blockIndex checkComplete:YES revert:NO];
        }else{
            //  CCLOG(@"move right %f %f",differX,block2.position.x );
            for(int i = 0 ; i < self.size + 2 ; i++ ){
                ColorBlock *block = blockArray[blockIndex][i];
                block.position = CGPointMake(block.position.x - differ , block.position.y );
            }
        }
    }else{
        // moves vertical
        block1 = blockArray[1][blockIndex];
        block2 = blockArray[2][blockIndex];
        if( block2.position.y > borderY1_2 || (block2.position.y - differ)  > borderY1_2 ){
            //move up
            directionFound = false;
            [self moveUp:blockIndex checkComplete:YES revert:NO];
        }else if( block1.position.y < borderY1_2 || (block1.position.y - differ)  < borderY1_2 ){
            //move down
            directionFound = false;
            [self moveDown:blockIndex sel:nil checkComplete:YES revert:NO];
            
        }else{
            for(int i = 0 ; i < self.size + 2 ; i++ ){
                ColorBlock *block = blockArray[i][blockIndex];
                block.position = CGPointMake(block.position.x , block.position.y - differ);
            }
        }
    }
}






int randomizeCounter = 0 ;
int randomCount;

-(void) unmatchColors{
    ANIM_TIME = 0.4;
    endGame = true;
    // just randomize
    randomizeCounter = 0;
    if(self.level == 1 ) {
        randomCount = 5;
        [self randomizeColors];
    }else if( self.level == 2 || self.level == 3 || self.level == 4 ){
        randomCount = 5;
        [self randomizeColors];
    }else{
        randomCount = self.level;
        [self randomizeColors];
    }
}


-(void) randomizeColors{

  //  NSLog(@"%d %d %d ",randomizeCounter, randomCount , [self checkComplete]);
    if(randomizeCounter < randomCount || [self checkComplete] == YES){
        int random = rand() % self.size;
        if(randomizeCounter % 2 == 0){
            [self moveDown:random sel:@selector(randomizeColors) checkComplete:NO revert:NO];
        }else{
            [self moveRight:random sel:@selector(randomizeColors) checkComplete:NO revert:NO];
        }
    }else{
        [self.gameSceneProtocol randomizeFinished];
        ANIM_TIME = 0.1;
        [self reflectFirstLastColors:false reverse:false];
        endGame = false;

    }
    randomizeCounter++;
}

-(void)printPositions{
    
    printf("--------------------------\n");
    for(int y = 0 ; y < self.size + 2 ; y++  ){
        for(int x = 0 ; x < self.size + 2 ; x++ ){
            ColorBlock *block =  blockArray[y][x];
            printf("%f:%f  ",block.position.x,block.position.y );
        }
        printf("\n");
    }
    printf("--------------------------\n");

    
}



-(void) moveDown:(int)x{
    [self moveDown:x sel:@selector(randomizeColors) checkComplete:NO revert:NO];
}

-(void) moveRight:(int)y{
    [self moveRight:y sel:@selector(randomizeColors) checkComplete:NO revert:NO];
}

-(void) moveRight:(int)y sel:(SEL)sel checkComplete:(BOOL)checkComplete revert:(BOOL)revert{
    actionActive = YES;
    CCActionSequence *sequence;
    NSMutableArray *actionArray = [NSMutableArray array];
    
    for(int i = 0 ; i < self.size + 2 ; i++ ){
        if( i != 0 ){
            CGPoint pos = [positionArray[y][i] CGPointValue];
            
            CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:ANIM_TIME position:CGPointMake(pos.x,pos.y)];
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
    
    NSArray *array ;
    if(sel){
        array = @[[NSNumber numberWithInt:y],
                  [NSValue valueWithPointer:sel],
                  [NSNumber numberWithBool:checkComplete],
                  [NSNumber numberWithBool:revert]];
    }else{
        array = @[[NSNumber numberWithInt:y],
                  [NSNull null],
                  [NSNumber numberWithBool:checkComplete],
                  [NSNumber numberWithBool:revert]];
    }
    
    // action0 and complete sequencially
    sequence = [CCActionSequence actionOne: actionArray[0] two:[ExtActionCallFunc actionWithTarget:self selector:@selector(rightMoveComplete:) array:array]];
    
    ColorBlock *firstBlock = horizontalBlockArray[0];
    [firstBlock runAction:sequence];
    
}

- (void) rightMoveComplete:(NSArray*)array{
    int row = [((NSNumber*)array[0]) intValue];
    SEL callback = nil;
    if( ![(array[1]) isEqual:[NSNull null]] ){
        callback = [((NSValue*)array[1]) pointerValue];
    }
    
    BOOL checkComplete  = [((NSNumber*)array[2]) boolValue ];
    BOOL revert  = [((NSNumber*)array[3]) boolValue ];
    
    lastMove = @"right";
    lastMoveIndex = row;
    
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
    [self reflectFirstLastColors:checkComplete reverse:revert];
    if(callback != nil){
        typedef void (*Func)(id, SEL);
        ((Func)objc_msgSend)(self, callback);
    }
    
}




//left

-(void) moveLeft:(int)y checkComplete:(BOOL)checkComplete revert:(BOOL)revert{
    actionActive = YES;
    CCActionSequence *sequence;
    NSMutableArray *actionArray = [NSMutableArray array];
    
    for(int i = 0 ; i < self.size + 2 ; i++ ){
        if( i != self.size + 1  ){
            CGPoint pos = [positionArray[y][i] CGPointValue];
            CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:ANIM_TIME position:CGPointMake(pos.x,pos.y)];
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
    
    NSArray *array = [NSArray arrayWithObjects:[NSNumber numberWithInt:y],
                      [NSNumber numberWithBool:checkComplete],
                      [NSNumber numberWithBool:revert],
                      nil];
    // action0 and complete sequencially
    sequence = [CCActionSequence actionOne: actionArray[0] two:[ExtActionCallFunc actionWithTarget:self selector:@selector(leftMoveComplete:) array:array]];
    
    ColorBlock *firstBlock = horizontalBlockArray[1];
    [firstBlock runAction:sequence];
    
}


- (void) leftMoveComplete:(NSArray*)array{

    int row = [((NSNumber*)array[0]) intValue];
    BOOL checkComplete = [((NSNumber*)array[1]) boolValue ];
    BOOL revert = [((NSNumber*)array[2]) boolValue ];
    
    
    lastMove = @"left";
    lastMoveIndex = row;
    
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
    [self reflectFirstLastColors:checkComplete reverse:revert];
}


// move up

-(void) moveUp:(int)x checkComplete:(BOOL)checkComplete revert:(BOOL)revert{
    actionActive = YES;
    CCActionSequence *sequence;
    NSMutableArray *actionArray = [NSMutableArray array];
    
    for(int i = 0 ; i < self.size + 2 ; i++ ){
        if( i != self.size + 1  ){
            CGPoint pos = [positionArray[i][x] CGPointValue];
            CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:ANIM_TIME position:CGPointMake(pos.x,pos.y)];
            actionArray[i] = actionMove;
        }
    }
    
    // apply actions to block arrays except first one
    for(int i = 1 ; i < [actionArray count] ; i++){
        CCActionMoveTo *actionMove =  actionArray[i];
        ColorBlock *block = blockArray[i+1][x];
        [block runAction:actionMove];
    }
    NSArray *array = [NSArray arrayWithObjects:[NSNumber numberWithInt:x],
                      [NSNumber numberWithBool:checkComplete],
                      [NSNumber numberWithBool:revert],
                      nil];
    // action0 and complete sequencially
    sequence = [CCActionSequence actionOne: actionArray[0] two:[ExtActionCallFunc actionWithTarget:self selector:@selector(upMoveComplete:) array:array]];
    
    ColorBlock *firstBlock = blockArray[1][x];
    [firstBlock runAction:sequence];
}


- (void) upMoveComplete:(NSArray*)array{

    int column = [((NSNumber*)array[0]) intValue];
    BOOL checkComplete = [((NSNumber*)array[1]) boolValue ];
    BOOL revert = [((NSNumber*)array[2]) boolValue ];
    
    lastMove = @"up";
    lastMoveIndex = column;
    
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
    [self reflectFirstLastColors:checkComplete reverse:revert];
}


// move down

-(void) moveDown:(int)x sel:(SEL)sel checkComplete:(BOOL)checkComplete revert:(BOOL)revert{
    actionActive = YES;
    CCActionSequence *sequence;
    
    NSMutableArray *actionArray = [NSMutableArray array];
    
    for(int i = 0 ; i < self.size + 2 ; i++ ){
        if( i != 0 ){
            CGPoint pos = [positionArray[i][x] CGPointValue];
            CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:ANIM_TIME position:CGPointMake(pos.x,pos.y)];
            actionArray[i-1] = actionMove;
        }
        
    }
    
    // apply actions to block arrays except first one
    for(int i = 1 ; i < [actionArray count] ; i++){
        CCActionMoveTo *actionMove =  actionArray[i];
        ColorBlock *block = blockArray[i][x];
        [block runAction:actionMove];
    }
    

    NSArray *array ;
    if(sel){
        array = @[[NSNumber numberWithInt:x],
                  [NSValue valueWithPointer:sel],
                  [NSNumber numberWithBool:checkComplete],
                  [NSNumber numberWithBool:revert]];
    }else{
        array = @[[NSNumber numberWithInt:x],
                  [NSNull null],
                  [NSNumber numberWithBool:checkComplete],
                  [NSNumber numberWithBool:revert]];
    }

    

    // action0 and complete sequencially
    sequence = [CCActionSequence actionOne: actionArray[0] two:[ExtActionCallFunc actionWithTarget:self selector:@selector(downMoveComplete:) array:array]];
    
    ColorBlock *firstBlock = blockArray[0][x];
    [firstBlock runAction:sequence];
    
    
    
}


- (void) downMoveComplete:(NSArray*)array{

    int column = [((NSNumber*)array[0]) intValue];
    SEL callback = nil;
    if( ![(array[1]) isEqual:[NSNull null]] ){
        callback = [((NSValue*)array[1]) pointerValue];
    }

    BOOL checkComplete  = [((NSNumber*)array[2]) boolValue ];
    BOOL revert  = [((NSNumber*)array[3]) boolValue ];
    
    lastMove = @"down";
    lastMoveIndex = column;
    
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
    [self reflectFirstLastColors:checkComplete reverse:revert];
    if(callback != nil){
        typedef void (*Func)(id, SEL);
        ((Func)objc_msgSend)(self, callback);
    }
    
}




-(void) reflectFirstLastColors:(BOOL)checkComplete reverse:(BOOL)reverse{
    
    NSString *label = [NSString stringWithFormat:@"%d %d",self.size ,self.level];
    
    [self.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"movegrid"     // Event category
                                                          action:@"move"  // Event action (required)
                                                           label:label         // Event label
                                                           value:nil] build]];    // Event valu
    
    actionActive = NO;
    directionFound = NO;
    touchStart = NO;
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
            
            CGPoint  orgPoint =   [positionArray[y][x] CGPointValue];
            block.position = CGPointMake(orgPoint.x, orgPoint.y);
        }
    }

    if(reverse == TRUE){
        [self.gameSceneProtocol updateMove:reverse];
    }

    if(checkComplete == YES){
        [Constants playMoveItem];
        [self.gameSceneProtocol updateMove:reverse];
        
        BOOL match = [self checkComplete];
        if(match == YES){
            endGame = YES;
            self.hoverY  = 1 ;
            self.hoverX  = 1 ;
            float interval = 1.0f/(self.size * 1.5f);
            [self schedule:@selector(hoverBlock) interval:interval repeat:(self.size * self.size ) delay:0];
        }
    }
}


-(BOOL)checkComplete{
    BOOL match = YES;
    // check horizontal match
    for (int i = 1 ; i < self.size +1 ; i++){
        NSString *matchColor = nil;
        for(int j = 1 ; j < self.size + 1 ; j++){
            ColorBlock *block = blockArray[i][j];
            if(!matchColor){
                matchColor = block.image;
            }
            if( ![matchColor isEqualToString:block.image]  ){
                match = NO;
                break;
            }
        }
        if(match == false){
            break;
        }
    }
    
    if( match == NO){
        match = YES;
        // check vertical match
        for (int i = 1 ; i < self.size +1 ; i++){
            NSString *matchColor = nil;
            for(int j = 1 ; j < self.size + 1 ; j++){
                ColorBlock *block = blockArray[j][i];
                if(!matchColor){
                    matchColor = block.image;
                }
                if(![matchColor isEqualToString:block.image]  ){
                    match = NO;
                    break;
                }
            }
            if(match == false){
                break;
            }
        }
    }
    return match;
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
//    NSLog(@"%d %d",self.hoverX,self.hoverY);
    if((self.hoverX >= self.size ) && (self.hoverY >= self.size)){
        [self.gameSceneProtocol finishGame];
    }
    
}

-(void)clean{
    self.gameSceneProtocol = nil;
}

-(void)revert{
    
    if([lastMove isEqualToString:@"down"]){
        [self moveUp:lastMoveIndex checkComplete:NO revert:YES];
    }else if([lastMove isEqualToString:@"up"]){
        [self moveDown:lastMoveIndex sel:nil checkComplete:NO revert:YES];
    }else if([lastMove isEqualToString:@"left"]){
        [self moveRight:lastMoveIndex sel:nil checkComplete:NO revert:YES];
    }else if([lastMove isEqualToString:@"right"]){
        [self moveLeft:lastMoveIndex checkComplete:NO revert:YES];
    }
    
}

-(void)onEnter
{
    [super onEnter];
    self.userInteractionEnabled = true;
}

-(void)showAdv{
    [[GADHolderView sharedCenter] getTimer:self loadAdv:@selector(loadAdv)];
}

-(void)loadAdv{

   BOOL loadSuccess =  [[GADHolderView sharedCenter] loadInterstitial:self showCallback:nil dismissCallback:@selector(advDismissed)];
/*    if(loadSuccess == TRUE){
        self.userInteractionEnabled = NO;
         [self reflectFirstLastColors:NO reverse:NO];
    }
*/
}

-(void)advDismissed{

    [[CCDirector sharedDirector].responderManager setEnabled:FALSE];
    [[CCDirector sharedDirector].responderManager setEnabled:TRUE];
    self.userInteractionEnabled = true;
    //[self touchCancelled:self.currentTouchParam withEvent:self.currentUIEvent];

    [self reflectFirstLastColors:NO reverse:NO];
}

@end
