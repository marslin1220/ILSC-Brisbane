//
//  SectionAgentFactory.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "SectionAgentFactory.h"
#import "UsefulLinkAgent.h"
#import "SecurityInformationAgent.h"
#import "ActivityBookingAgent.h"

@interface SectionAgentFactory()

@property (nonatomic) NSArray *sectionAgentGroup;

@end

@implementation SectionAgentFactory

#pragma mark - Member Initiation

- (id)initWithTableViewController:(UITableViewController *)tableViewController
{
  self = [super init];
  if (self) {
    self.tableViewController = tableViewController;
  }

  return self;
}

- (NSArray *)sectionAgentGroup
{
  if (!_sectionAgentGroup) {
    _sectionAgentGroup = @[[[UsefulLinkAgent alloc] initWithTableViewController:self.tableViewController], [[SecurityInformationAgent alloc] initWithTableViewController:self.tableViewController], [[ActivityBookingAgent alloc] initWithTableViewController:self.tableViewController]];
  }

  return _sectionAgentGroup;
}

#pragma mark - Factory Methods

- (NSInteger)numberOfSectionAgents
{
  return [self.sectionAgentGroup count];
}

- (id<SectionAgent>)sectionAgentInSection:(NSInteger)section
{
  return self.sectionAgentGroup[section];
}

@end
