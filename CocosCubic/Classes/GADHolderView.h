//
//  GADHolderView.h
//  CocosCubic
//
//  Created by Onur Atamer on 25/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADInterstitial.h"
#import "cocos2d.h"

@interface GADHolderView : NSObject<GADInterstitialDelegate>


-(id)init;
-(BOOL)loadInterstitial:(id)target showCallback:(SEL)showCallback dismissCallback:(SEL)dismissCallback;
+ (GADHolderView *)sharedCenter;
-(NSTimer*)getTimer:(id)target loadAdv:(SEL)loadAdv;

@property GADInterstitial *interstitial;
@property id target;
@property SEL showCallback;
@property SEL dissmisCallback;
@property BOOL pending ;
@property NSTimer *timer;

@end
