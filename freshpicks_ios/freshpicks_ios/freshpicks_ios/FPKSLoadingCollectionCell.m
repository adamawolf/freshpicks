//
//  FPKSLoadingCollectionCell.m
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import "FPKSLoadingCollectionCell.h"

@implementation FPKSLoadingCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) configureCell
{
    [[self activityIndicatorView] startAnimating];
}

@end
