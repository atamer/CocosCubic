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

+(id) actionWithTarget: (id) t selector:(SEL) s object:(id)obj
{
    
	return [[self alloc] initWithTarget: t selector: s object:obj];
}


-(id) initWithTarget: (id) t selector:(SEL) s object:(id)obj
{
	if( (self=[super init]) ) {
        
        NSAssert(t == nil || [t respondsToSelector:s], @"target cannot perform selector %@.",        NSStringFromSelector(s));
        
		self.targetCallback = t;
        _object = obj;
		_selector = s;
	}
	return self;
}

-(void) execute
{
    typedef void (*Func)(id, SEL, id);
    ((Func)objc_msgSend)(_targetCallback, _selector,_object);
}

@end
