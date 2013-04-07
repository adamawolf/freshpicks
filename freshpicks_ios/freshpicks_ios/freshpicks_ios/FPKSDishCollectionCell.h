//
//  FPKSDishCollectionCell.h
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPKSDishCollectionCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView * dishImageView;
@property (nonatomic, strong) IBOutlet UIImageView * chefImageView;
@property (nonatomic, strong) IBOutlet UILabel * chefLabel;

@property (nonatomic, strong) IBOutlet UIImageView * firstStarImageView;
@property (nonatomic, strong) IBOutlet UIImageView * secondStarImageView;
@property (nonatomic, strong) IBOutlet UIImageView * thirdStarImageView;
@property (nonatomic, strong) IBOutlet UIImageView * fourthStarImageView;
@property (nonatomic, strong) IBOutlet UIImageView * fifthImageView;

@property (nonatomic, strong) IBOutlet UILabel * dishNameAndPriceLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint * nameLabelWidthContraint;

- (void) configureCellWithDishData: (NSDictionary *) dishData;

@end
