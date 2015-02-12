//
//  SecurityInforTableViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2015/2/11.
//  Copyright (c) 2015年 marstudio. All rights reserved.
//

#import "SecurityInforTableViewController.h"
#import "SWRevealViewController.h"

@interface SecurityInforTableViewController ()

@end

@implementation SecurityInforTableViewController

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

@end
