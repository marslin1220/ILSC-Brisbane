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
- (void)viewDidLoad
{
  [super viewDidLoad];

  self.menuButton.target = self.revealViewController;
  self.menuButton.action = @selector(revealToggle:);
  [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];

  self.sectionAgentFactory = nil;
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [self.sectionAgentFactory numberOfSectionAgents];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSInteger numberOfRows = 0;

  id<SectionAgent> sectionAgent = [self.sectionAgentFactory sectionAgentInSection:section];
  numberOfRows = [sectionAgent tableView:tableView numberOfRowsInSection:section];

  return numberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *title = nil;

  id<SectionAgent> sectionAgent = [self.sectionAgentFactory sectionAgentInSection:section];
  title = [sectionAgent tableView:tableView titleForHeaderInSection:section];

  return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = nil;

  id<SectionAgent> sectionAgent = [self.sectionAgentFactory sectionAgentInSection:indexPath.section];
  cell = [sectionAgent tableView:tableView cellForRowAtIndexPath:indexPath];

  return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  id<SectionAgent> sectionAgent = [self.sectionAgentFactory sectionAgentInSection:indexPath.section];
  if ([sectionAgent respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
    [sectionAgent tableView:tableView didSelectRowAtIndexPath:indexPath];
  }

  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
