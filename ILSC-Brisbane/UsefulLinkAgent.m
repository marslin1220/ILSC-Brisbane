//
//  UsefulLinkAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/12/2.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <Parse/Parse.h>

#import "UsefulLinkAgent.h"
#import "UsefulLinkItemTableViewController.h"

#define CLASS_USEFUL_LINK_CATEGORY @"UsefulLinkCategory"
#define KEY_CATEGORY_TITLE @"categoryTitle"

@interface UsefulLinkAgent()

@property NSArray *categoryArray;

@end

@implementation UsefulLinkAgent

@synthesize tableViewController;

- (id)initWithTableViewController:(UITableViewController *)tableVC
{
  self = [super init];
  if (self) {
    self.tableViewController = tableVC;
  }

  return self;
}

#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (self.categoryArray) {
    return [self.categoryArray count];
  }

  PFQuery *query = [PFQuery queryWithClassName:CLASS_USEFUL_LINK_CATEGORY];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    self.categoryArray = objects;
    [self.tableViewController.tableView reloadData];
  }];

  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return NSLocalizedString(@"Useful Link", nil);
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
  UsefulLinkItemTableViewController *usefulLinkItemTVC = [self.tableViewController.storyboard instantiateViewControllerWithIdentifier:@"useful-link-item-view-controller"];
  usefulLinkItemTVC.catetory = [self.categoryArray objectAtIndex:indexPath.row];

  [self.tableViewController.navigationController pushViewController:usefulLinkItemTVC animated:YES];
}

@end
