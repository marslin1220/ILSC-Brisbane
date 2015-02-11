//
//  WhatsOnTableViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2015/2/11.
//  Copyright (c) 2015年 marstudio. All rights reserved.
//

#import <Parse/Parse.h>

#import "WhatsOnTableViewController.h"
#import "SWRevealViewController.h"

#define ILSC_BNE_COMMUNITY_TV_URL @"https://m.youtube.com/channel/UCUmXuPKvW5uLoXtLl9a5tDQ/videos"
#define ILSC_COMMUNITY_TV_URL @"https://m.youtube.com/user/ilscTV/videos"
#define ILSC_BLOG_URL @"http://blog.ilsc.com"

@interface WhatsOnTableViewController ()

@end

@implementation WhatsOnTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setSidebarButtonAction];
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

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIApplication *applcation = [UIApplication sharedApplication];

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

  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
