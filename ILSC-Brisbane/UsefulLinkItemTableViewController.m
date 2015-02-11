//
//  UsefulLinkItemTableViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/12/2.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "UsefulLinkItemTableViewController.h"
#import "SWRevealViewController.h"

#define CLASS_USEFUL_LINK_ITEM @"UsefulLinkItem"
#define KEY_ITEM_TITLE @"itemTitle"
#define KEY_ITEM_LINK @"itemLink"
#define KEY_CATEGORY_ID @"category_objectId"
#define ID_USEFUL_LINK_ITEM_CELL @"useful-link-item-cell-id"

@interface UsefulLinkItemTableViewController ()

@property NSArray *usefulLinkItemArray;

@end

@implementation UsefulLinkItemTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self loadUsefulLinkItem];
}

- (void)loadUsefulLinkItem
{
  if (self.usefulLinkItemArray) {
    return;
  }

  PFQuery *query = [PFQuery queryWithClassName:CLASS_USEFUL_LINK_ITEM];
  [query whereKey:KEY_CATEGORY_ID equalTo:self.catetory.objectId];

  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    self.usefulLinkItemArray = objects;
    [self.tableView reloadData];
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];

  self.usefulLinkItemArray = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (!self.usefulLinkItemArray) {
    return 0;
  }

  return [self.usefulLinkItemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_USEFUL_LINK_ITEM_CELL
                                                          forIndexPath:indexPath];

  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID_USEFUL_LINK_ITEM_CELL];
  }

  if (self.usefulLinkItemArray) {
    PFObject *itemObject = [self.usefulLinkItemArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:itemObject[KEY_ITEM_TITLE]];
  }

  return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (!self.usefulLinkItemArray) {
    return;
  }

  PFObject *itemObject = [self.usefulLinkItemArray objectAtIndex:indexPath.row];
  NSURL *url = [NSURL URLWithString:itemObject[KEY_ITEM_LINK]];
  [[UIApplication sharedApplication] openURL:url];
}

@end
