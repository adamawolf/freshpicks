//
//  Definitions.m
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import "Definitions.h"

@implementation Definitions

+ (UIColor *) listingBackgroundColor
{
    static UIColor * _listingBackroundColor = nil;
    
    if (!_listingBackroundColor)
    {
        _listingBackroundColor = [UIColor colorWithRed:(226.0f/255.0f) green:(249.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
    }
    
    return _listingBackroundColor;
}

@end
