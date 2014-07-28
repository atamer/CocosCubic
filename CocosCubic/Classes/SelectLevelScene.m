//
//  SelectLevelScene.m
//  CocosCubic
//
//  Created by Onur Atamer on 27/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "SelectLevelScene.h"
#import "SelectSizeScene.h"
#import "Constants.h"


@implementation SelectLevelScene

NSString* size_;

+ (SelectLevelScene *)scene:(NSString*)size
{
    size_ = size;
    return [[self alloc] init];
}


- (id)init{
    self = [super init ];
    if (!self) return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor: BACKGROUND_COLOR ];
    [self addChild:background];
    
    
    
    CCButton *back = [CCButton buttonWithTitle:@"Back" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_button_highlight.png"]];
    back.label.fontSize = 20;
    back.anchorPoint = ccp(0,0);
    back.name = @"size3";
    CGFloat backHeight = back.boundingBox.size.height;
    [back setTarget:self selector:@selector(onBackClicked)];
    back.position = ccp(backHeight * 0.5f, screenHeight - backHeight * 1.2);
    [self addChild:back];
    
    
    

    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Select Level" fontName:@"Chalkboard" fontSize:48.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = RED_COLOR;
    label.position = ccp(0.5f, 0.8f); // Middle of screen
    [self addChild:label];
    
    
    CGFloat firstPadding = (screenWidth / 1136) * 150 ;
    CGFloat betweenPadding = 180 *(screenWidth / 1136);
    for (int i = 0 ; i < 5; i++) {
        NSString* level = [NSString stringWithFormat:@"%d",i+1];
        CCButton *levelButton = [CCButton buttonWithTitle:level spriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"]];
        levelButton.label.fontSize = 20;
        levelButton.anchorPoint = ccp(0,0);
        levelButton.name = level;
        if(i == 0){
            levelButton.position = ccp(firstPadding, (screenHeight / 2) );
        }else{
            levelButton.position = ccp(firstPadding + ( i * betweenPadding ), (screenHeight / 2) );
        }
        [self addChild:levelButton];
    }
    
    betweenPadding = 180 *(screenWidth / 1136);
    for (int i = 5 ; i < 10 ; i++) {
        NSString* level = [NSString stringWithFormat:@"%d",i+1];
        CCButton *levelButton = [CCButton buttonWithTitle:level spriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"small_button_highlight.png"]];
        levelButton.label.fontSize = 20;
        levelButton.anchorPoint = ccp(0,0);
        levelButton.name = level;
        if(i == 5){
            levelButton.position = ccp(firstPadding, (screenHeight / 2) - betweenPadding );
        }else{
            levelButton.position = ccp(firstPadding + ( (i - 5) * betweenPadding ), (screenHeight / 2) - betweenPadding);
        }
        [self addChild:levelButton];
    }
    
    
    for (int i = 10 ; i < 15 ; i++) {
        NSString* level = [NSString stringWithFormat:@"%d",i+1];
        CCButton *levelButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"lock.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"lock_highlight.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"lock_highlight.png"]];
        levelButton.label.fontSize = 20;
        levelButton.anchorPoint = ccp(0,0);
        levelButton.name = level;
        if(i == 10){
            levelButton.position = ccp(firstPadding, (screenHeight / 2) - (betweenPadding * 2) );
        }else{
            levelButton.position = ccp(firstPadding + ( (i - 10) * betweenPadding ), (screenHeight / 2) - (betweenPadding * 2));
        }
        [self addChild:levelButton];
    }


    
    
    
    return self;
}


-(void)onBackClicked{
    [[CCDirector sharedDirector] replaceScene:[SelectSizeScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.6f]];
}

@end
