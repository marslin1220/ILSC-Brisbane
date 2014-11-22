//
//  SectionAgentFactory.h
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionAgent.h"

@interface SectionAgentFactory : NSObject

@property UITableViewController *tableViewController;

- (id)initWithTableViewController:(UITableViewController *)tableViewController;
- (NSInteger)numberOfSectionAgents;
- (id<SectionAgent>)sectionAgentInSection:(NSInteger)section;

@end
