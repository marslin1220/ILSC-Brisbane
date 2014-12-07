//
//  SecurityInformationAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/12/7.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "SecurityInformationAgent.h"

@implementation SecurityInformationAgent

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
  return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return NSLocalizedString(@"XXXX information", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"right-detail-cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }

  switch (indexPath.row) {
    case 0:
      [cell.textLabel setText:NSLocalizedString(@"WiFi password", nil)];
      [cell.detailTextLabel setText:@"ILSC-WiFi"];
      break;
    case 1:
      [cell.textLabel setText:NSLocalizedString(@"Toilet password", nil)];
      [cell.detailTextLabel setText:@"c1230"];
      break;
    default:
      break;
  }

  return cell;
}

@end
