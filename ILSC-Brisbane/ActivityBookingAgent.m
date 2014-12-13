//
//  ActivityBookingAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/12/14.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <Parse/Parse.h>

#import "ActivityBookingAgent.h"

#define CLASS_ACTIVITY_BOOKING @"ActivityBooking"
#define KEY_ACTIVITY_TITLE @"activityTitle"
#define KEY_ACTIVITY_LINK @"activityLink"

@interface ActivityBookingAgent ()

@property NSArray *activityArray;

@end

@implementation ActivityBookingAgent

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
  if (self.activityArray) {
    return [self.activityArray count];
  }

  PFQuery *query = [PFQuery queryWithClassName:CLASS_ACTIVITY_BOOKING];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    self.activityArray = objects;
    [self.tableViewController.tableView reloadData];
  }];

  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return NSLocalizedString(@"Activity booking", nil);
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
