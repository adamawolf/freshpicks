//
//  FPKSDishCollectionCell.m
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import "FPKSDishCollectionCell.h"

@interface FPKSDishCollectionCell ()

@property (nonatomic, strong) NSDictionary * dishData;

@end


@implementation FPKSDishCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) configureCellWithDishData: (NSDictionary *) dishData
{
    [self setDishData:dishData];
}

- (void) setDishData:(NSDictionary *)dishData
{
    _dishData = dishData;
    
    DLog(@"TODO: render data in collection cell");
}

@end
