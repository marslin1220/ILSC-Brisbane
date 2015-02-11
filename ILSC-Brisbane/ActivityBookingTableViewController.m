//
//  ActivityBookingTableViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2015/2/11.
//  Copyright (c) 2015年 marstudio. All rights reserved.
//

#import <Parse/Parse.h>

#import "ActivityBookingTableViewController.h"
#import "SWRevealViewController.h"

#define CLASS_ACTIVITY_BOOKING @"ActivityBooking"
#define KEY_ACTIVITY_TITLE @"activityTitle"
#define KEY_ACTIVITY_LINK @"activityLink"

@interface ActivityBookingTableViewController ()

@property NSArray *activityArray;

@end

@implementation ActivityBookingTableViewController

- (void)viewDidLoad
{
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (self.activityArray) {
    return [self.activityArray count];
  }

  PFQuery *query = [PFQuery queryWithClassName:CLASS_ACTIVITY_BOOKING];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    self.activityArray = objects;
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

  if ([self.activityArray count] > indexPath.row) {
    PFObject *dataObject = [self.activityArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:dataObject[KEY_ACTIVITY_TITLE]];
  }

  return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  PFObject *itemObject = self.activityArray[indexPath.row];
  NSURL *url = [NSURL URLWithString:itemObject[KEY_ACTIVITY_LINK]];
  [[UIApplication sharedApplication] openURL:url];
}

@end
