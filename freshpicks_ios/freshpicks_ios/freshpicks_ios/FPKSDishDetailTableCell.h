//
//  FPKSDishDetailTableCell.h
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/7/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPKSDishDetailTableCell : UITableViewCell

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

@property (nonatomic, strong) IBOutlet UILabel * descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel * ingredientsLabel;
@property (nonatomic, strong) IBOutlet UILabel * remainingLabel;
@property (nonatomic, strong) IBOutlet UILabel * restrictionsLabel;

- (void) configureCellWithDishData: (NSDictionary *) dishData;

@end
