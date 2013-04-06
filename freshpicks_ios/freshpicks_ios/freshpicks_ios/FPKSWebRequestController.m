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
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:dishRequuest
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSLog(@"%@", (NSString *)JSON);
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                     message:[NSString stringWithFormat:@"%@",error]
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [alertView show];
                                                    }];
    
    [operation start];
}

@end
