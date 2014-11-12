//
//  ActivitiCalendarViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/8/27.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <Parse/Parse.h>
#import "ActivitiCalendarViewController.h"
#import "NSCalendar+DateComparison.h"

#define KEY_TITLE @"title"
#define KEY_SUBTITLE @"subtitle"
#define KEY_DATE @"date"

#define CLASS_ACTIVITY_CALENDAR_EVENT @"ActivityCalendarEvent"

@interface ActivitiCalendarViewController ()

@property (nonatomic) CKCalendarView *calendarView;
@property (nonatomic) NSArray *calendarEventGroup;
@property (nonatomic) NSDate *firstFetchedDate;
@property (nonatomic) NSDate *lastFetchedDate;

@end

@implementation ActivitiCalendarViewController

#pragma mark - Init Object Memeber
- (CKCalendarView *)calendarView
{
  if (!_calendarView) {
    _calendarView = [CKCalendarView new];

    [_calendarView setDelegate:self];
    [_calendarView setDataSource:self];
  }

  return _calendarView;
}

#pragma mark - UI Life Cycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  [[self view] addSubview:self.calendarView];
  [self fetchEventsForCalendar];
}

- (void)fetchEventsForCalendar
{
  if (![self needToFetchEvents]) {
    return;
  }

  PFQuery *query = [PFQuery queryWithClassName:CLASS_ACTIVITY_CALENDAR_EVENT];
  [query whereKey:KEY_DATE greaterThanOrEqualTo:self.calendarView.firstVisibleDate];
  [query whereKey:KEY_DATE lessThanOrEqualTo:self.calendarView.lastVisibleDate];

  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (error) {
      NSLog(@"Error: %@ %@", error, [error userInfo]);
      return;
    }

    self.calendarEventGroup = objects;

    self.firstFetchedDate = self.calendarView.firstVisibleDate;
    self.lastFetchedDate = self.calendarView.lastVisibleDate;

    dispatch_async(dispatch_get_main_queue(), ^{
      [self.calendarView reload];
    });
  }];
}

- (BOOL)needToFetchEvents
{
  if (!self.firstFetchedDate) {
    return true;
  }

  if (!self.lastFetchedDate) {
    return true;
  }

  if (NSOrderedAscending == [self.calendarView.firstVisibleDate compare:self.firstFetchedDate]) {
    return true;
  }

  if (NSOrderedDescending == [self.calendarView.lastVisibleDate compare:self.lastFetchedDate]) {
    return true;
  }

  return false;
}

#pragma mark - Implement CKCalendarDataSource
- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date
{
  NSMutableArray *ckCalendarEventGroup = [[NSMutableArray alloc] init];
  NSCalendar *currentCalendar = [NSCalendar currentCalendar];

  for (PFObject *object in self.calendarEventGroup) {
    if ([currentCalendar date:date isSameDayAs:[object objectForKey:KEY_DATE]]) {
      CKCalendarEvent *ckCalendarEvent = [[CKCalendarEvent alloc] init];
      ckCalendarEvent.title = [object objectForKey:KEY_TITLE];

      [ckCalendarEventGroup addObject:ckCalendarEvent];
    }
  }

  return ckCalendarEventGroup;
}

#pragma mark - Implement CKCalendarViewDelegate
- (void)calendarView:(CKCalendarView *)calendarView willSelectDate:(NSDate *)date
{
}

- (void)calendarView:(CKCalendarView *)calendarView didSelectDate:(NSDate *)date
{
  if ([self isSelectedDayOutOfFetchedRange:date]) {
    [self fetchEventsForCalendar];
  }
}

- (BOOL)isSelectedDayOutOfFetchedRange:(NSDate *)date
{
  if (NSOrderedAscending == [date compare:self.firstFetchedDate]) {
    return true;
  }

  if (NSOrderedDescending == [date compare:self.lastFetchedDate]) {
    return true;
  }

  return false;
}

@end
