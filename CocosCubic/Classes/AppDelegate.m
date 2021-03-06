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
#import "GAITracker.h"
#import "CCFileUtils.h"
#import "GAI.h"
#import "GAIFields.h"

@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;

    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-31321094-5"];
    
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    
    NSString *dimensionValue = currentDeviceId;
    [tracker set:[GAIFields customDimensionForIndex:2] value:dimensionValue];
    
   
    
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *strTime = [objDateformat stringFromDate:[NSDate date]];
    
    
    dimensionValue = strTime;
    [tracker set:[GAIFields customDimensionForIndex:3] value:dimensionValue];
    
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(NO),
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

    
	return YES;
}

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
	return [IntroScene scene];
}



@end
