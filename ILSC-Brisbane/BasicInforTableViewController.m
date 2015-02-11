//
//  BasicInforTableViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2015/2/11.
//  Copyright (c) 2015年 marstudio. All rights reserved.
//

#import <QuickLook/QLPreviewController.h>

#import "BasicInforTableViewController.h"
#import "SWRevealViewController.h"

@interface BasicInforTableViewController () <QLPreviewControllerDataSource>

@end

@implementation BasicInforTableViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIViewController *viewController = nil;
  switch (indexPath.row) {
    case 3:
    {
      QLPreviewController *previewController = [[QLPreviewController alloc] init] ;
      previewController.dataSource = self;
      viewController = previewController;
    }
      break;
    default:
      break;
  }

  if (viewController) {
    [self.navigationController pushViewController:viewController animated:YES];
  }
}

#pragma mark - Quick Look Data Source

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
  return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
  // Break the path into its components (filename and extension)
  NSArray *fileComponents = [@"Brisbane Schedule for Session 12 2014.pdf" componentsSeparatedByString:@"."];

  // Use the filename (index 0) and the extension (index 1) to get path
  NSString *path = [[NSBundle mainBundle] pathForResource:[fileComponents objectAtIndex:0] ofType:[fileComponents objectAtIndex:1]];

  return (id <QLPreviewItem>)[NSURL fileURLWithPath:path];
}

@end
