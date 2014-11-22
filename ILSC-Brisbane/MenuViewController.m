//
//  ViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/7/1.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "MenuViewController.h"

#define ILSC_BNE_COMMUNITY_TV_URL @"https://m.youtube.com/channel/UCUmXuPKvW5uLoXtLl9a5tDQ/videos"
#define ILSC_COMMUNITY_TV_URL @"https://m.youtube.com/user/ilscTV/videos"
#define ILSC_BLOG_URL @"http://blog.ilsc.com"

@interface MenuViewController ()

@end

@implementation MenuViewController

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIApplication *applcation = [UIApplication sharedApplication];

  if (indexPath.section == 0) {
    switch (indexPath.row) {
      case 0:
        [applcation openURL:[NSURL URLWithString:ILSC_BNE_COMMUNITY_TV_URL]];
        break;
      case 1:
        [applcation openURL:[NSURL URLWithString:ILSC_COMMUNITY_TV_URL]];
        break;
      case 2:
        [applcation openURL:[NSURL URLWithString:ILSC_BLOG_URL]];
        break;
      default:
        break;
    }

  }

  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
