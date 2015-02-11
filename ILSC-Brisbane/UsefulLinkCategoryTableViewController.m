//
//  UsefulLinkCategoryTableViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2015/2/11.
//  Copyright (c) 2015年 marstudio. All rights reserved.
//

#import <Parse/Parse.h>

#import "UsefulLinkCategoryTableViewController.h"
#import "UsefulLinkItemTableViewController.h"
#import "SWRevealViewController.h"

#define CLASS_USEFUL_LINK_CATEGORY @"UsefulLinkCategory"
#define KEY_CATEGORY_TITLE @"categoryTitle"

@interface UsefulLinkCategoryTableViewController ()

@property NSArray *categoryArray;

@end

@implementation UsefulLinkCategoryTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setSidebarButtonAction];
}

- (void)setSidebarButtonAction
{
  SWRevealViewController *revealViewController = self.revealViewController;
  if (revealViewController)
  {
    self.menuButton.target = revealViewController;
    self.menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (self.categoryArray) {
    return [self.categoryArray count];
  }

  PFQuery *query = [PFQuery queryWithClassName:CLASS_USEFUL_LINK_CATEGORY];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    self.categoryArray = objects;
    [self.tableView reloadData];
  }];

  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"disclosure-cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }

  if ([self.categoryArray count] > indexPath.row) {
    PFObject *dataObject = [self.categoryArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:dataObject[KEY_CATEGORY_TITLE]];
  }

  return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UsefulLinkItemTableViewController *usefulLinkItemTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"useful-link-item-view-controller"];
  usefulLinkItemTVC.catetory = [self.categoryArray objectAtIndex:indexPath.row];

  [self.navigationController pushViewController:usefulLinkItemTVC animated:YES];
}

@end
