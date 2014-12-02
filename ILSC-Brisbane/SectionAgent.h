//
//  SectionAgent.h
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SectionAgent <NSObject, UITableViewDataSource, UITableViewDelegate>

@property UITableViewController *tableViewController;

- (id)initWithTableViewController:(UITableViewController *)tableViewController;

@end
