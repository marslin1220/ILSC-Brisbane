//
//  ContactUsTableViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/30.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "ContactUsTableViewController.h"

@interface ContactUsTableViewController ()

@end

@implementation ContactUsTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIApplication *shareApplication = [UIApplication sharedApplication];

  switch (indexPath.section) {
    case 0:
      [shareApplication openURL:[NSURL URLWithString:@"tel://(07)3220-0144"]];
      break;
    case 1:
      [shareApplication openURL:[NSURL URLWithString:@"http://maps.apple.com/?q=ILSC-Brisbane"]];
      break;
    default:
      break;
  }
}

@end
