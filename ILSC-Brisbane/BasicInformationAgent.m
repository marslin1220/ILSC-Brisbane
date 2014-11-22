//
//  BasicInformationAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "BasicInformationAgent.h"

@implementation BasicInformationAgent

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

  switch (indexPath.row) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    default:
      break;
  }

  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
