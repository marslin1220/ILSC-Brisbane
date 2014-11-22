//
//  SectionAgentFactory.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/11/22.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "SectionAgentFactory.h"
#import "WhatsOnAgent.h"

@interface SectionAgentFactory()

@property (nonatomic) NSArray *sectionAgentGroup;
@property (nonatomic) id<SectionAgent> whatsOnAgent;

@end

@implementation SectionAgentFactory

#pragma mark - Member Initiation

- (NSArray *)sectionAgentGroup
{
  if (!_sectionAgentGroup) {
    _sectionAgentGroup = @[self.whatsOnAgent];
  }

  return _sectionAgentGroup;
}

- (id<SectionAgent>)whatsOnAgent
{
  if (!_whatsOnAgent) {
    _whatsOnAgent = [WhatsOnAgent new];
  }

  return _whatsOnAgent;
}

- (NSInteger)numberOfSectionAgents
{
  return [self.sectionAgentGroup count];
}

- (id<SectionAgent>)sectionAgentInSection:(NSInteger)section
{
  return self.sectionAgentGroup[section];
}

@end
