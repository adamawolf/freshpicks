//
//  FPKSRootWareViewController.h
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPKSRootDishViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView * collectionView;

@end
