//
//  InformationTableViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/10/16.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "InformationTableViewController.h"

#define URL_TRANSLINK @"http://translink.com.au"

NS_ENUM(NSInteger, sectionType) {
  sectionTypePublic = 0,
  sectionTypeStudent = 1
};

@implementation InformationTableViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == sectionTypeStudent) {
    if (indexPath.row == 0) {
      NSURL *url = [NSURL URLWithString:URL_TRANSLINK];
      [[UIApplication sharedApplication] openURL:url];
    }
  }

  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
