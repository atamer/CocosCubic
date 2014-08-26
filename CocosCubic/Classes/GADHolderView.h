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
-(void)loadInterstitial:(id)target showCallback:(SEL)showCallback dismissCallback:(SEL)dismissCallback;
+ (GADHolderView *)sharedCenter;

@property GADInterstitial *interstitial;
@property id target;
@property SEL showCallback;
@property SEL dissmisCallback;
@property BOOL pending ;

@end
