//
//  ExtActionCallFunc.h
//  CocosCubic
//
//  Created by Onur Atamer on 17/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCActionInstant.h"

@interface ExtActionCallFunc : CCActionCallFunc
    
@property  NSArray* array;

+(id) actionWithTarget: (id) t selector:(SEL) s array:(NSArray*)array;

@end
