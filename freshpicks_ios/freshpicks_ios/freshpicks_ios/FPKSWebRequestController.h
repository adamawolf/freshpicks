//
//  FPKSWebRequestController.h
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPKSWebRequestController : NSObject

- (void) asynchronouslyLoadDishList;

+ (FPKSWebRequestController *) sharedController;

@end
