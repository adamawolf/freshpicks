//
//  FPKSDishDetailViewController.h
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPKSDishDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary * dishData;

@property (nonatomic, strong) IBOutlet UITableView * tableView;

@end
