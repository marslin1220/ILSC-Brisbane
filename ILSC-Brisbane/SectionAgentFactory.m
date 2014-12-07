//
//  SectionAgentFactory.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "SectionAgentFactory.h"
#import "WhatsOnAgent.h"
#import "BasicInformationAgent.h"
#import "UsefulLinkAgent.h"
#import "NewsItemAgent.h"

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
    _sectionAgentGroup = @[[[WhatsOnAgent alloc] initWithTableViewController:self.tableViewController], [[BasicInformationAgent alloc] initWithTableViewController:self.tableViewController], [[UsefulLinkAgent alloc] initWithTableViewController:self.tableViewController], [[NewsItemAgent alloc] initWithTableViewController:self.tableViewController]];
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
