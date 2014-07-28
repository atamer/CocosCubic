//
//  Constants.h
//  CocosCubic
//
//  Created by Onur Atamer on 27/07/14.
//  Copyright (c) 2014 Onur Atamer. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CCColorFromRGB(rgbValue) [CCColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BACKGROUND_COLOR CCColorFromRGB(0xF0ECC9)
#define RED_COLOR CCColorFromRGB(0xD34F28)



@interface Constants : NSObject

@end
