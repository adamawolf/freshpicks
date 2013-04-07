//
//  FPKSRootWareViewController.m
//  freshpicks_ios
//
//  Created by Adam Wolf on 4/6/13.
//  Copyright (c) 2013 freshpicks. All rights reserved.
//

#import "FPKSRootDishViewController.h"
#import "FPKSWebRequestController.h"

#import "FPKSDishCollectionCell.h"
#import "FPKSLoadingCollectionCell.h"
#import "FPKSErrorCollectionCell.h"

typedef enum {
    FPKSRootDishViewControllerStatusLoading,
    FPKSRootDishViewControllerStatusLoaded,
    FPKSRootDishViewControllerStatusError,
} FPKSRootDishViewControllerStatus;

typedef enum {
    FPKSCollectionCellTypeLoading,
    FPKSCollectionCellTypeDish,
    FPKSCollectionCellTypeError,
} FPKSCollectionCellType;

@interface FPKSRootDishViewController () <FPKSWebRequestControllerDelegate>

@property (nonatomic, assign) FPKSRootDishViewControllerStatus status;
@property (nonatomic, strong) NSArray * loadedDishListDictionaries;
@property (nonatomic, strong) NSArray * collectionData;

@end

@implementation FPKSRootDishViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setStatus:FPKSRootDishViewControllerStatusLoading];
    [[FPKSWebRequestController sharedController] setDishListDelegate:self];
    [[FPKSWebRequestController sharedController] asynchronouslyLoadDishList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Custom setter methods

- (void) setStatus: (FPKSRootDishViewControllerStatus) status
{
    _status = status;
    
    [self prepareTableData];
}

#pragma mark - Helper methods

- (void) prepareTableData
{
    [self setCollectionData:nil];
    
    NSMutableArray * cellDictionaries = [NSMutableArray new];
    
    if ([self status] == FPKSRootDishViewControllerStatusLoading)
    {
        [cellDictionaries addObject:@{@"type" : @(FPKSCollectionCellTypeLoading)}];
    }
    else if ([self status] == FPKSRootDishViewControllerStatusLoaded)
    {
        [[self loadedDishListDictionaries] enumerateObjectsUsingBlock:^(NSDictionary * dishListDictionary, NSUInteger index, BOOL * stop) {
            [cellDictionaries addObject:@{
             @"type" : @(FPKSCollectionCellTypeDish),
             @"dishData" : dishListDictionary,
             }];
        }];
    }
    else if ([self status] == FPKSRootDishViewControllerStatusError)
    {
        [cellDictionaries addObject:@{@"type" : @(FPKSCollectionCellTypeError)}];
    }
    
    [self setCollectionData:cellDictionaries];
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self collectionData] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = nil;
 
    NSDictionary * cellDictionary = [[self collectionData] objectAtIndex:indexPath.row];
    
    if ([cellDictionary[@"type"] intValue] == FPKSCollectionCellTypeLoading)
    {
        cell = [[self collectionView] dequeueReusableCellWithReuseIdentifier:@"FPKSLoadingCollectionCell" forIndexPath:indexPath];
    }
    else if ([cellDictionary[@"type"] intValue] == FPKSCollectionCellTypeDish)
    {
        cell = [[self collectionView] dequeueReusableCellWithReuseIdentifier:@"FPKSDishCollectionCell" forIndexPath:indexPath];
    }
    else if ([cellDictionary[@"type"] intValue] == FPKSCollectionCellTypeError)
    {
        cell = [[self collectionView] dequeueReusableCellWithReuseIdentifier:@"FPKSErrorCollectionCell" forIndexPath:indexPath];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell: (UICollectionViewCell *) collectionCell atIndexPath: (NSIndexPath *) indexPath
{
    NSDictionary * cellDictionary = [[self collectionData] objectAtIndex:indexPath.row];
    
    if ([cellDictionary[@"type"] intValue] == FPKSCollectionCellTypeLoading)
    {
        [(FPKSLoadingCollectionCell *)collectionCell configureCell];
    }
    else if ([cellDictionary[@"type"] intValue] == FPKSCollectionCellTypeDish)
    {
        [(FPKSDishCollectionCell *)collectionCell configureCellWithDishData:cellDictionary[@"dishData"]];
    }
    else if ([cellDictionary[@"type"] intValue] == FPKSCollectionCellTypeError)
    {
        //pass
    }
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"PushDishDetail" sender:nil];
}

#pragma mark - FPKSWebRequestControllerDelegate methods

- (void) webRequestController: (FPKSWebRequestController *) webRequestController didLoadDishList: (NSArray *) dishDictionaries
{
    DLog(@"loaded data %@", dishDictionaries);
    
    [self setLoadedDishListDictionaries:dishDictionaries];
    [self setStatus:FPKSRootDishViewControllerStatusLoaded];
    
    [[self collectionView] reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

- (void) webRequestController: (FPKSWebRequestController *) webRequestController didEncounterErrorLoadingDishList: (NSError *) error
{
    DLog(@"error: %@", [error localizedDescription]);
    
    UIAlertView * anAlertView = [[UIAlertView alloc] initWithTitle:@"Error loading dish list" message:[NSString stringWithFormat:@"Error code %d", [error code]] delegate:nil cancelButtonTitle:@"Drats" otherButtonTitles: nil];
    [anAlertView show];
    
    [self setLoadedDishListDictionaries:nil];
    [self setStatus:FPKSRootDishViewControllerStatusError];
    [[self collectionView] reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

@end
