//
//  FPKSLoadingCollectionCell.h
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPKSLoadingCollectionCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView * activityIndicatorView;

- (void) configureCell;

@end
