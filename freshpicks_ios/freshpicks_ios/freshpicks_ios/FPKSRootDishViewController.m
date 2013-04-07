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

#import "FPKSDishDetailViewController.h"

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

@property (nonatomic, strong) UIRefreshControl * refreshControl;

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
    
    [[self collectionView] setBackgroundColor:[Definitions listingBackgroundColor]];
    
    [self setStatus:FPKSRootDishViewControllerStatusLoading];
    [[FPKSWebRequestController sharedController] setDishListDelegate:self];
    [[FPKSWebRequestController sharedController] asynchronouslyLoadDishList];
    
    self.collectionView.alwaysBounceVertical = YES;
    
    UIRefreshControl * aRefreshControl = [[UIRefreshControl alloc] init];
    aRefreshControl.tintColor = [UIColor grayColor];
    [aRefreshControl addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:aRefreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    
    [self setRefreshControl:aRefreshControl];
}

- (void) refershControlAction
{
    [self setLoadedDishListDictionaries:nil];
    [self setStatus:FPKSRootDishViewControllerStatusLoading];
    
    [[self collectionView] reloadSections:[NSIndexSet indexSetWithIndex:0]];
    
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PushDishDetail"])
    {
        FPKSDishDetailViewController * target = (FPKSDishDetailViewController *)[segue destinationViewController];
        [target setDishData:sender];
    }
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(320, 25);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        reusableview = headerView;
    }
    
    return reusableview;
}

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
    NSDictionary * cellDictionary = [[self collectionData] objectAtIndex:indexPath.row];
    
    if ([cellDictionary[@"type"] intValue] == FPKSCollectionCellTypeDish)
    {
        [self performSegueWithIdentifier:@"PushDishDetail" sender:cellDictionary[@"dishData"]];
    }
}

#pragma mark - FPKSWebRequestControllerDelegate methods

- (void) webRequestController: (FPKSWebRequestController *) webRequestController didLoadDishList: (NSArray *) dishDictionaries
{
    DLog(@"loaded data %@", dishDictionaries);
    
    [self setLoadedDishListDictionaries:dishDictionaries];
    [self setStatus:FPKSRootDishViewControllerStatusLoaded];
    
    [[self collectionView] reloadSections:[NSIndexSet indexSetWithIndex:0]];
    
    [[self refreshControl] endRefreshing];
}

- (void) webRequestController: (FPKSWebRequestController *) webRequestController didEncounterErrorLoadingDishList: (NSError *) error
{
    DLog(@"error: %@", [error localizedDescription]);
    
    UIAlertView * anAlertView = [[UIAlertView alloc] initWithTitle:@"Error loading dish list" message:[NSString stringWithFormat:@"Error code %d", [error code]] delegate:nil cancelButtonTitle:@"Drats" otherButtonTitles: nil];
    [anAlertView show];
    
    [self setLoadedDishListDictionaries:nil];
    [self setStatus:FPKSRootDishViewControllerStatusError];
    [[self collectionView] reloadSections:[NSIndexSet indexSetWithIndex:0]];
    
    [[self refreshControl] endRefreshing];
}

@end
