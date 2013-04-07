//
//  FPKSDishDetailViewController.m
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import "FPKSDishDetailViewController.h"
#import "FPKSDishDetailTableCell.h"

@interface FPKSDishDetailViewController ()

@end

@implementation FPKSDishDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setDishData:(NSDictionary *)dishData
{
    _dishData = dishData;
    
    NSString * dishName = [self dishData][@"dish"][@"name"];
    [self setTitle:dishName ? dishName : @"Dish"];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[self tableView] dequeueReusableCellWithIdentifier:@"FPKSDishDetailTableCell"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell: (UITableViewCell *) cell atIndexPath: (NSIndexPath *) indexPath
{
    [(FPKSDishDetailTableCell*)cell configureCellWithDishData:[self dishData]];
}

@end
