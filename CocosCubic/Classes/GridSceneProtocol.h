//
//  GridSceneProtocol.h
//  CocosCubic
//
//  Created by Onur Atamer on 02/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GridSceneProtocol <NSObject>

@required
- (void) updateFunc:(float)differX differY:(float)differY x:(int)x y:(int)y;
- (void) touchEndFunc:(UITouch*)uiTouch x:(int)x y:(int)y;
- (void) touchBeginFunc:(UITouch*)uiTouch x:(int)x y:(int)y;


@end
