//
//  Definitions.h
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    FSPKErrorCodeUnexpectedResponse = 46,
} FSPKErrorCode;

#define kBaseURL            @"http://freshpicksapi.herokuapp.com/"
#define kChefImagePath      @"images/chefs/%@/%@.jpg"           //username, [366|140|70]
#define kDishImagePath      @"images/dishes/%d-%@.jpg"         //username, dish's id, [full|600x450|300x225]

@interface Definitions : NSObject

+ (UIColor *) listingBackgroundColor;

@end
