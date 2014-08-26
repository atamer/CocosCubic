//
//  GADHolderView.m
//  CocosCubic
//
//  Created by Onur Atamer on 25/08/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import "GADHolderView.h"
#import <objc/message.h>

@implementation GADHolderView

static GADHolderView *sharedGADCenter = nil;

+ (GADHolderView *)sharedCenter{
    if(sharedGADCenter == nil){
        sharedGADCenter = [[self alloc] init];
    }
    return sharedGADCenter;
}



-(id)init{
    self = [super init ];
    if (!self) return(nil);
    
    self.pending = false;
    return self;
}


-(void)loadInterstitial:(id)target showCallback:(SEL)showCallback dismissCallback:(SEL)dismissCallback{
    
    if(self.pending == false){
        self.pending = true;
        self.dissmisCallback = dismissCallback;
        self.showCallback = showCallback;
        
        
        GADRequest *request = [GADRequest request];
        self.interstitial = [[GADInterstitial alloc] init];
        self.interstitial.delegate = self;
        self.interstitial.adUnitID = @"ca-app-pub-8854429305629377/3481174946";
        
        
        /*UIDevice *device = [UIDevice currentDevice];
         NSUUID *uniqueIdentifier = [device identifierForVendor];
         
         NSString *uuid = uniqueIdentifier.UUIDString;
         request.testDevices = @[
         // TODO: Add your device/simulator test identifiers here. Your device identifier is printed to
         // the console when the app is launched.
         uuid
         ];
         */
        [self.interstitial loadRequest:request];

    }
    
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    //An interstitial object can only be used once - so it's useful to automatically load a new one when the current one is dismissed
    
    if(self.dissmisCallback){
        typedef void (*Func)(id, SEL);
        ((Func)objc_msgSend)(self.target, self.dissmisCallback);
    }
    
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    //If an error occurs and the interstitial is not received you might want to retry automatically after a certain interval
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(preLoadInterstitial) userInfo:nil repeats:NO];
   
    
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    self.pending = false;
    CCDirectorIOS* director = (CCDirectorIOS*) [CCDirector sharedDirector];
    CCNavigationController *nav =(CCNavigationController*)[director delegate];
    [self.interstitial presentFromRootViewController:nav];
    
    if(self.showCallback){
        typedef void (*Func)(id, SEL);
        ((Func)objc_msgSend)(self.target, self.showCallback);
    }
}





@end
