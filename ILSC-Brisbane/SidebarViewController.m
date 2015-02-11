//
//  SidebarViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2015/2/11.
//  Copyright (c) 2015年 marstudio. All rights reserved.
//

#import "SidebarViewController.h"
#import "MenuViewController.h"

@implementation SidebarViewController {
  NSArray *menuItems;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  menuItems = @[@"whatison", @"information", @"usefullink", @"news", @"xxxxinformation", @"activitybooking"];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                          forIndexPath:indexPath];

  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;

  MenuViewController *menuViewController = [destViewController childViewControllers].firstObject;
  menuViewController.selectedMenuItemIndex = indexPath.row;
}

@end
