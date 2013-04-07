//
//  FPKSWebRequestController.h
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPKSWebRequestController;

@protocol FPKSWebRequestControllerDelegate <NSObject>

- (void) webRequestController: (FPKSWebRequestController *) webRequestController didLoadDishList: (NSArray *) dishDictionaries;
- (void) webRequestController: (FPKSWebRequestController *) webRequestController didEncounterErrorLoadingDishList: (NSError *) error;

@end

@interface FPKSWebRequestController : NSObject

@property (nonatomic, weak) id<FPKSWebRequestControllerDelegate> dishListDelegate;

- (void) asynchronouslyLoadDishList;

+ (FPKSWebRequestController *) sharedController;

@end
