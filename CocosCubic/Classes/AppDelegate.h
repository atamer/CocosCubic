//
//  AppDelegate.h
//  CocosCubic
//
//  Created by Onur Atamer on 23/07/14.
//  Copyright Onur Atamer 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"
#import "GADInterstitialDelegate.h"
#import "GADInterstitial.h"

@interface AppDelegate : CCAppDelegate<UIApplicationDelegate,GADInterstitialDelegate>{
    GADInterstitial     *interstitial_;
}


@end
