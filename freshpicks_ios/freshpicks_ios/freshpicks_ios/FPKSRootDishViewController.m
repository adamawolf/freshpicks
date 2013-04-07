//
//  FPKSRootWareViewController.m
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import "FPKSRootDishViewController.h"
#import "FPKSDishCollectionCell.h"
#import "FPKSWebRequestController.h"

@interface FPKSRootDishViewController () <FPKSWebRequestControllerDelegate>

@end

@implementation FPKSRootDishViewController

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
    
    [[FPKSWebRequestController sharedController] setDishListDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[FPKSWebRequestController sharedController] asynchronouslyLoadDishList];
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [[self collectionView] dequeueReusableCellWithReuseIdentifier:@"FPKSDishCollectionCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"PushDishDetail" sender:nil];
}

#pragma mark - FPKSWebRequestControllerDelegate methods

- (void) webRequestController: (FPKSWebRequestController *) webRequestController didLoadDishList: (NSArray *) dishDictionaries
{
    DLog(@"%@", dishDictionaries);
}

- (void) webRequestController: (FPKSWebRequestController *) webRequestController didEncounterErrorLoadingDishList: (NSError *) error
{
    UIAlertView * anAlertView = [[UIAlertView alloc] initWithTitle:@"Error loading dish list" message:[NSString stringWithFormat:@"Error code %d", [error code]] delegate:nil cancelButtonTitle:@"Drats" otherButtonTitles: nil];
    [anAlertView show];
    
    DLog(@"error: %@", [error localizedDescription]);
}

@end
