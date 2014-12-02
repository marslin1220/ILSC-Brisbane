//
//  UsefulLinkAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/12/2.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "UsefulLinkAgent.h"

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
  return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return NSLocalizedString(@"Useful Link", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"dynamic-cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }

  return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
