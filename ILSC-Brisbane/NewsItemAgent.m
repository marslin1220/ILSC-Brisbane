//
//  NewsItemAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/12/7.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <Parse/Parse.h>

#import "NewsItemAgent.h"

#define CLASS_NEWS_ITEM @"NewsItem"
#define KEY_NEWS_TITLE @"newsTitle"

@interface NewsItemAgent()

@property NSArray *newsArray;

@end

@implementation NewsItemAgent

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
  if (self.newsArray) {
    return [self.newsArray count];
  }

  PFQuery *query = [PFQuery queryWithClassName:CLASS_NEWS_ITEM];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    self.newsArray = objects;
    [self.tableViewController.tableView reloadData];
  }];

  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return NSLocalizedString(@"News", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"non-accessory-cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }

  if ([self.newsArray count] > indexPath.row) {
    PFObject *dataObject = [self.newsArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:dataObject[KEY_NEWS_TITLE]];
  }

  return cell;
}

@end
