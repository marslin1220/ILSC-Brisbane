//
//  BasicInformationAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "BasicInformationAgent.h"

@implementation BasicInformationAgent

@synthesize tableViewController;

- (id)initWithTableViewController:(UITableViewController *)tableVC
{
  self = [super init];
  if (self) {
    self.tableViewController = tableVC;
  }

  return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return NSLocalizedString(@"Information", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"dynamic-cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }

  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = NSLocalizedString(@"Map", nil);
      break;
    case 1:
      cell.textLabel.text = NSLocalizedString(@"Academic calendar", nil);
      break;
    case 2:
      cell.textLabel.text = NSLocalizedString(@"Activity calendar", nil);
      break;
    case 3:
      cell.textLabel.text = NSLocalizedString(@"Session class schedule", nil);
      break;
    default:
      break;
  }

  return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIApplication *applcation = [UIApplication sharedApplication];

  UIViewController *viewController = nil;
  switch (indexPath.row) {
    case 0:
      viewController = [self.tableViewController.storyboard instantiateViewControllerWithIdentifier:@"map-view-controller"];
      break;
    case 1:
      viewController = [self.tableViewController.storyboard instantiateViewControllerWithIdentifier:@"academic-view-controller"];
      break;
    case 2:
      viewController = [self.tableViewController.storyboard instantiateViewControllerWithIdentifier:@"activity-view-controller"];
      break;
    case 3:
      break;
    default:
      break;
  }

  if (viewController) {
    [self.tableViewController.navigationController pushViewController:viewController animated:YES];
  }

  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
