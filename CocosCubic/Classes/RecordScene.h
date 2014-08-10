//
//  RecordScene.h
//  CocosCubic
//
//  Created by Onur Atamer on 10/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface RecordScene : CCScene

@property NSString* size;
@property NSString* level;
@property int record;

+ (RecordScene *)scene:(NSString*)size level:(NSString*)level record:(int)record;

@end
