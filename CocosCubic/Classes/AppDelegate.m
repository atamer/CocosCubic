//
//  AppDelegate.m
//  CocosCubic
//
//  Created by Onur Atamer on 23/07/14.
//  Copyright Onur Atamer 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "IntroScene.h"
#import "CCFileUtils.h"

@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(YES),
		CCSetupDepthFormat: @GL_DEPTH24_STENCIL8_OES,
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
//		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mode.
		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
		CCSetupTabletScale2X: @(YES),
	}];
//    CCFileUtils *utils = [CCFileUtils sharedFileUtils];
//    [utils setiPadSuffix:@"-hd"];
//    [[CCFileUtils sharedFileUtils] setiPadContentScaleFactor:1.0f];

    
    [self preLoadInterstitial];
    
	return YES;
}

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
	return [IntroScene scene];
}

- (void)preLoadInterstitial {
    //Call this method as soon as you can - loadRequest will run in the background and your interstitial will be ready when you need to show it
    GADRequest *request = [GADRequest request];
    interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.delegate = self;
    interstitial_.adUnitID = @"ca-app-pub-8854429305629377/7909765340";
    
    UIDevice *device = [UIDevice currentDevice];
    NSUUID *uniqueIdentifier = [device identifierForVendor];

    NSString *uuid = uniqueIdentifier.UUIDString;
    request.testDevices = @[
                            // TODO: Add your device/simulator test identifiers here. Your device identifier is printed to
                            // the console when the app is launched.
                            uuid
                            ];
    
    [interstitial_ loadRequest:request];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    //An interstitial object can only be used once - so it's useful to automatically load a new one when the current one is dismissed
    [self preLoadInterstitial];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    //If an error occurs and the interstitial is not received you might want to retry automatically after a certain interval
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(preLoadInterstitial) userInfo:nil repeats:NO];
    NSLog(@"%@",error.userInfo[@"NSLocalizedDescription"]);
    
}

- (void) showInterstitial
{
    //Call this method when you want to show the interstitial - the method should double check that the interstitial has not been used before trying to present it
    if (!interstitial_.hasBeenUsed)
        [interstitial_ presentFromRootViewController:nil];
}

@end
