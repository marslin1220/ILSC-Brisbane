//
//  ActivitiCalendarViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/8/27.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "ActivitiCalendarViewController.h"

@interface ActivitiCalendarViewController ()

@property (nonatomic) CKCalendarView *calendarView;

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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[self view] addSubview:self.calendarView];
}

#pragma mark - Implement CKCalendarDataSource
- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date
{
    return nil;
}

#pragma mark - Implement CKCalendarViewDelegate
- (void)calendarView:(CKCalendarView *)calendarView willSelectDate:(NSDate *)date
{

}

- (void)calendarView:(CKCalendarView *)calendarView didSelectDate:(NSDate *)date
{

}

@end
