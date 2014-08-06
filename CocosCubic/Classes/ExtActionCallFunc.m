//
//  ExtActionCallFunc.m
//  CocosCubic
//
//  Created by Onur Atamer on 17/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ExtActionCallFunc.h"
#import <objc/message.h>

@implementation ExtActionCallFunc

+(id) actionWithTarget: (id) t selector:(SEL) s array:(NSArray*)array
{
    
	return [[self alloc] initWithTarget: t selector: s array:array];
}


-(id) initWithTarget: (id) t selector:(SEL) s array:(NSArray*)array
{
	if( (self=[super init]) ) {
        
        NSAssert(t == nil || [t respondsToSelector:s], @"target cannot perform selector %@.",        NSStringFromSelector(s));
        
		self.targetCallback = t;
        self.array = array;
		_selector = s;
	}
	return self;
}

-(void) execute
{
    typedef void (*Func)(id, SEL, id);
    ((Func)objc_msgSend)(_targetCallback, _selector,self.array);
}

@end
