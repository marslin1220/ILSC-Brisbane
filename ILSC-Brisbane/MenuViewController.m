//
//  ViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/7/1.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "MenuViewController.h"
#import "SectionAgentFactory.h"
#import "SectionAgent.h"
#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface MenuViewController ()

@property (nonatomic) SectionAgentFactory *sectionAgentFactory;

@end

@implementation MenuViewController

#pragma mark - Member Initiation
- (SectionAgentFactory *)sectionAgentFactory
{
  if (!_sectionAgentFactory) {
    _sectionAgentFactory = [[SectionAgentFactory alloc] initWithTableViewController:self];
  }

  return _sectionAgentFactory;
}

#pragma mark - View Life Cycle

- (void)awakeFromNib
{
  self.selectedMenuItemIndex = 3;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setSidebarButtonAction];
  [self setFrontTitle];
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

- (void)setFrontTitle
{
  id<SectionAgent> sectionAgent = [self.sectionAgentFactory sectionAgentInSection:self.selectedMenuItemIndex];
  self.title = [sectionAgent tableView:self.tableView titleForHeaderInSection:0];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];

  self.sectionAgentFactory = nil;
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSInteger numberOfRows = 0;

  id<SectionAgent> sectionAgent = [self.sectionAgentFactory sectionAgentInSection:self.selectedMenuItemIndex];
  numberOfRows = [sectionAgent tableView:tableView numberOfRowsInSection:0];

  return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = nil;

  id<SectionAgent> sectionAgent = [self.sectionAgentFactory sectionAgentInSection:self.selectedMenuItemIndex];
  cell = [sectionAgent tableView:tableView cellForRowAtIndexPath:indexPath];

  return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  id<SectionAgent> sectionAgent = [self.sectionAgentFactory sectionAgentInSection:self.selectedMenuItemIndex];
  if ([sectionAgent respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
    [sectionAgent tableView:tableView didSelectRowAtIndexPath:indexPath];
  }

  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
