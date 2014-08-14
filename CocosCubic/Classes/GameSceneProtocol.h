//
//  GameSceneProtocol.h
//  CocosCubic
//
//  Created by Onur Atamer on 07/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameSceneProtocol <NSObject>

@required
-(void) updateMove:(BOOL)reverse ;
-(void) finishGame;
-(void) randomizeFinished;
@end
