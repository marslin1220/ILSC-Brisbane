//
//  WhatsOnAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "WhatsOnAgent.h"

#define ILSC_BNE_COMMUNITY_TV_URL @"https://m.youtube.com/channel/UCUmXuPKvW5uLoXtLl9a5tDQ/videos"
#define ILSC_COMMUNITY_TV_URL @"https://m.youtube.com/user/ilscTV/videos"
#define ILSC_BLOG_URL @"http://blog.ilsc.com"

@implementation WhatsOnAgent

@synthesize tableViewController;

- (id)initWithTableViewController:(UITableViewController *)tableVC
{
  self = [super init];
  if (self) {
    self.tableViewController = tableVC;
  }

  return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return NSLocalizedString(@"What's on", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"disclosure-cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }

  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = NSLocalizedString(@"Community Channel Update", nil);
      break;
    case 1:
      cell.textLabel.text = NSLocalizedString(@"ILSC TV", nil);
      break;
    case 2:
      cell.textLabel.text = NSLocalizedString(@"ILSC Blog", nil);
      break;
    default:
      break;
  }

  return cell;
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
