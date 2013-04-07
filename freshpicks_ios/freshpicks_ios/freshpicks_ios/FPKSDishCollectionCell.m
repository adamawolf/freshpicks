//
//  FPKSDishCollectionCell.m
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import "FPKSDishCollectionCell.h"
#import "UIImageView+AFNetworking.h"

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

#define kMaxChefNameLabelWidth  106.0f

- (void) setDishData:(NSDictionary *)dishData
{
    _dishData = dishData;
    
    NSString * dishImagePath = [NSString stringWithFormat:kBaseURL kDishImagePath, [dishData[@"dish"][@"id"] intValue], [UIScreen mainScreen].scale > 1.0 ? @"600x450" : @"300x225"];
    
    [[self dishImageView] setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:dishImagePath]]
                          placeholderImage:[[UIImage imageNamed:@"placeholder_dish.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1.0f, 1.0f, 1.0f)]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                       [[self dishImageView] setImage:image];
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                       DLog(@"failed to load dish image %@", dishImagePath);
                                   }];
    
    NSString * chefImagePath = [NSString stringWithFormat:kBaseURL kChefImagePath, dishData[@"dish"][@"chef"][@"username"], [UIScreen mainScreen].scale > 1.0 ? @"140" : @"70"];
    
    [[self chefImageView] setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:chefImagePath]]
                                placeholderImage:[[UIImage imageNamed:@"placeholder.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1.0f, 1.0f, 1.0f)]
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                    [[self chefImageView] setImage:image];
                                                }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                             DLog(@"failed to load chef image %@", chefImagePath);
                                         }];
    
    [[self dishNameAndPriceLabel] setText:[NSString stringWithFormat:@"%@ | $%d", [self dishData][@"dish"][@"name"], [[self dishData][@"dish"][@"price"] intValue]]];
    
    [[self chefLabel] setText:[self dishData][@"dish"][@"chef"][@"name"]];
    
    CGSize size = [[self chefLabel] sizeThatFits:CGSizeMake(kMaxChefNameLabelWidth, 31.0f)];
    
    if ([self nameLabelWidthContraint])
    {
        [[self chefLabel] removeConstraint:[self nameLabelWidthContraint]];
        
        [self setNameLabelWidthContraint:[NSLayoutConstraint constraintWithItem:[self chefLabel] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:MIN(kMaxChefNameLabelWidth, size.width)]];
        [[self chefLabel] addConstraint:[self nameLabelWidthContraint]];
    }
}

@end
