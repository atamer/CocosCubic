//
//  ExtActionCallFunc.h
//  CocosCubic
//
//  Created by Onur Atamer on 17/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCActionInstant.h"

@interface ExtActionCallFunc : CCActionCallFunc{
    id _object;
}


+ (id)actionWithTarget:(id)t selector:(SEL)s object:(id)obj;

@end
