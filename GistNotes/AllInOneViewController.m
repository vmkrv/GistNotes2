//
//  AllInOneViewController.m
//  GistNotes
//
//  Created by Veaceslav Macarov on 09.09.15.
//  Copyright (c) 2015 Veaceslav Macarov. All rights reserved.
//

#import "AllInOneViewController.h"
//-- Controllers
#import "GistDetailViewController.h"
//-- Models
#import "GistsModel.h"
#import "Gist.h"

@interface AllInOneViewController () <UITabBarDelegate,GistsModelDelegate>
{
    GistsModel *gistModel;
    UIRefreshControl *refreshControl;
}
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AllInOneViewController
@synthesize tabBar;

#pragma mark - App Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"All in one";
    
    tabBar.delegate = self;
    gistModel = [[GistsModel alloc] init];
    gistModel.delegate = self;
    [gistModel retrieveGists];
    [tabBar setSelectedItem:tabBar.items[0]];
    
    // Initialize the refresh control.
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor purpleColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(getData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (tabBar.selectedItem.tag == 0) {
        [gistModel retrieveGists];
    } else {
        [gistModel retrieveNotes];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

- (void)getData
{
    if (tabBar.selectedItem.tag == 0) {
        [gistModel downloadGists];
    } else {
        [gistModel retrieveNotes];
    }
}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
        [refreshControl endRefreshing];
    }
}

#pragma mark - GistsModelDelegate

- (void)dataRetrieveSucceed
{
    [self reloadData];
}

- (void)dataRetrieveFailed
{
    [[[UIAlertView alloc] initWithTitle:@"" message:@"Ooops! Smth went wrong!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        [gistModel retrieveGists];
    } else {
        [gistModel retrieveNotes];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return gistModel.gists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Gist *gist = gistModel.gists[indexPath.row];
    cell.textLabel.text = gist.gistDescription;
    cell.detailTextLabel.text = gist.createdDate;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Gist *gist = gistModel.gists[indexPath.row];
    
    UIStoryboard *storyboard = self.storyboard;
    GistDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"gistDetaildID"];
    vc.selectedGist = gist;
    vc.aTitle = @"Gist";
    vc.original = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
