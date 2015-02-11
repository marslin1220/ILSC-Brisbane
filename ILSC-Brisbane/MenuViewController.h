//
//  ViewController.h
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/7/1.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (nonatomic) NSInteger selectedMenuItemIndex;

@end
