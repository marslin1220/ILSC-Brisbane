//
//  BasicInformationAgent.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <QuickLook/QLPreviewController.h>

#import "BasicInformationAgent.h"

@interface BasicInformationAgent() <QLPreviewControllerDataSource>
@end

@implementation BasicInformationAgent

@synthesize tableViewController;

- (id)initWithTableViewController:(UITableViewController *)tableVC
{
  self = [super init];
  if (self) {
    self.tableViewController = tableVC;
  }

  return self;
}

#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return NSLocalizedString(@"Information", nil);
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
      cell.textLabel.text = NSLocalizedString(@"Map", nil);
      break;
    case 1:
      cell.textLabel.text = NSLocalizedString(@"Academic calendar", nil);
      break;
    case 2:
      cell.textLabel.text = NSLocalizedString(@"Activity calendar", nil);
      break;
    case 3:
      cell.textLabel.text = NSLocalizedString(@"Session class schedule", nil);
      break;
    case 4:
      cell.textLabel.text = NSLocalizedString(@"Contact us", nil);
      break;
    default:
      break;
  }

  return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIViewController *viewController = nil;
  switch (indexPath.row) {
    case 0:
      viewController = [self.tableViewController.storyboard instantiateViewControllerWithIdentifier:@"map-view-controller"];
      break;
    case 1:
      viewController = [self.tableViewController.storyboard instantiateViewControllerWithIdentifier:@"academic-view-controller"];
      break;
    case 2:
      viewController = [self.tableViewController.storyboard instantiateViewControllerWithIdentifier:@"activity-view-controller"];
      break;
    case 3:
    {
      QLPreviewController *previewController = [[QLPreviewController alloc] init] ;
      previewController.dataSource = self;
      viewController = previewController;
    }
      break;
    case 4:
      viewController = [self.tableViewController.storyboard instantiateViewControllerWithIdentifier:@"contact-us-view-controller"];
      break;
    default:
      break;
  }

  if (viewController) {
    [self.tableViewController.navigationController pushViewController:viewController animated:YES];
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
