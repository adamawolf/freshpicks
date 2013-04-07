//
//  FPKSWebRequestController.m
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import "FPKSWebRequestController.h"
#import "AFNetworking.h"

static FPKSWebRequestController * _sharedInstance = nil;

@implementation FPKSWebRequestController

+ (FPKSWebRequestController *) sharedController
{
    if (!_sharedInstance)
    {
        _sharedInstance = [[FPKSWebRequestController alloc] init];
    }
    
    return _sharedInstance;
}

#define kDishListURL    @"http://freshpicksapi.herokuapp.com/today.json"

- (void) asynchronouslyLoadDishList
{
    NSURL * dishURL = [NSURL URLWithString:kDishListURL];
    
    NSURLRequest * dishRequuest = [NSURLRequest requestWithURL:dishURL];
    
    NSDate * startDate = [NSDate date];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:dishRequuest
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        if ([JSON isKindOfClass:[NSArray class]])
                                                        {
                                                            void (^completion)() = ^{
                                                                [[self dishListDelegate] webRequestController:self didLoadDishList:(NSArray *)JSON];
                                                            };
                                                            
                                                            NSTimeInterval responseTime = [[NSDate date] timeIntervalSinceDate:startDate];
                                                            if (responseTime < 0.6f)
                                                            {
                                                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                    dispatch_sync(dispatch_get_main_queue(), ^{
                                                                        completion();
                                                                    });
                                                                });
                                                            }
                                                            else
                                                            {
                                                                completion();
                                                            }
                                                        }
                                                        else
                                                        {
                                                            NSError * error = [[NSError alloc] initWithDomain:@"FPSKWebRequestControllerError" code:FSPKErrorCodeUnexpectedResponse userInfo:nil];
                                                            [[self dishListDelegate] webRequestController:self didEncounterErrorLoadingDishList:error];                                                            
                                                        }
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        [[self dishListDelegate] webRequestController:self didEncounterErrorLoadingDishList:error];
                                                    }];
    
    [operation start];
}

@end
