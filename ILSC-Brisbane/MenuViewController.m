//
//  ViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/7/1.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "MenuViewController.h"
#import "TableViewAgent.h"
#import "WhatsOnAgent.h"

@interface MenuViewController ()

@property (nonatomic) id<TableViewSectionAgent> whatsOnAgent;

@end

@implementation MenuViewController

#pragma mark - Member Initiation

- (id<TableViewSectionAgent>)whatsOnAgent
{
  if (!_whatsOnAgent) {
    _whatsOnAgent = [WhatsOnAgent new];
  }

  return _whatsOnAgent;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSInteger numberOfRows = 0;

  switch (section) {
    case 0: //What's on
      numberOfRows = [self.whatsOnAgent tableView:tableView numberOfRowsInSection:section];
      break;
    case 1: // Information
      numberOfRows = 3;
      break;
    case 2: // Userful link
      numberOfRows = 3;
      break;
    case 3: // News
      break;
    case 4: // xxxx information
      break;
    case 5: // Who is who
      break;
    default:
      break;
  }

  return numberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  switch (section) {
    case 0:
      [self.whatsOnAgent tableView:tableView titleForHeaderInSection:section];
      break;

    default:
      break;
  }
  return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 0) {
    return [self.whatsOnAgent tableView:tableView cellForRowAtIndexPath:indexPath];

  } else if (indexPath.section == 1){

  }
  return nil;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 0) {
    [self.whatsOnAgent tableView:tableView didSelectRowAtIndexPath:indexPath];
  }

  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
