//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Mohit Sadhu on 8/9/15.
//  Copyright (c) 2015 Mohit Sadhu. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"

@interface BNRItemsViewController()

@property (nonatomic, strong) IBOutlet UIView *headerView;
@end

@implementation BNRItemsViewController
{
    NSInteger totalCount;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self)
    {
//        for (NSInteger i = 0; i < 5; i++)
//        {
//            [[BNRItemStore sharedStore] createItem];
//        }
//        [[BNRItemStore sharedStore] createNoMoreItem];
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];

    totalCount = 0;
    
//    UIView *header = self.headerView;

//    [self.tableView setTableHeaderView:header];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

//- (UIView *)headerView
//{
//    if (!_headerView)
//    {
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    
//    return _headerView;
//}

#pragma mark - UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    totalCount = [[BNRItemStore sharedStore] allItems].count;
//    
//    if (totalCount)
//    {
////        return [BNRItemStore sharedStore].allItems.count + 1;
//        totalCount = totalCount + 1;
//        return totalCount;
//    }
//    else
//        return 1;
    
    return [BNRItemStore sharedStore].allItems.count;
//    return [BNRItemStore sharedStore].allItems.count + 1;

//    return totalCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    
//    if (indexPath.row == totalCount)
//    {
//        cell.textLabel.text = @"No More Items!";
//    }
//    else
//    {
        BNRItem *item = items[indexPath.row];
        cell.textLabel.text = [item description];
//    }

    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];

    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    detailViewController.item = (BNRItem *)items[indexPath.row];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{    
//    if (indexPath.row == totalCount - 1 )
//        return NO;
    
    return YES;
}


#pragma mark - Action methods

- (IBAction)addNewItem:(id)sender
{
    BNRItem *item = [[BNRItemStore sharedStore] createItem];
//    [self.tableView reloadData];
    
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:item];

    totalCount++;
    NSLog(@"\n\ntotalCount =  %ld\n\n", (long)totalCount);
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}

//- (IBAction)toggleEditingMode:(id)sender
//{
//    if (self.isEditing)
//    {
//        [sender  setTitle:@"Edit" forState:UIControlStateNormal];
//        [self setEditing:NO animated:YES];
//    }
//    else
//    {
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        [self setEditing:YES animated:YES];
//    }
//}

@end
