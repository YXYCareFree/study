//
//  ViewController.m
//  CalendarEventManager
//
//  Created by beyondSoft on 16/9/7.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addCalendarEvent];

}

- (void)addCalendarEvent{

    EKEventStore * eventStore = [EKEventStore new];
    NSString * eventTitle = @"test";
    //这里的string格式和设置的时间格式应保持一致
    NSDate * startDate = [self dateFromString:@"2016-09-09 17:16:00"];
    NSDate * endDate = [self dateFromString:@"2016-09-15 09:00:00"];

    int alarm = 30;
    NSString * notes = @"note--baby";
    NSString * location = @"location";
    int recurrenceTimes = 2;
    //EKRecurrenceFrequency frequency = [self getRecurrenceFrequency:@"frequency"];
    EKRecurrenceFrequency frequency = EKRecurrenceFrequencyDaily;

    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {

        dispatch_async(dispatch_get_main_queue(), ^{

            if (error) {

            }else if (!granted){
                NSLog(@"被用户拒绝，不允许访问日历");
            }else{
                BOOL isOK = [self saveEventWithStore:eventStore
                                          eventTitle:eventTitle
                                           startDate:startDate
                                             endDate:endDate
                                               alarm:alarm
                                            location:location
                                               notes:notes
                                               times:recurrenceTimes
                                           frequency:frequency];
                NSLog(@"%@", isOK ? @"添加事件成功" : @"添加事件失败");
            }
        });
    }];
}

- (BOOL)saveEventWithStore:(EKEventStore *)eventStore
                eventTitle:(NSString *)eventTitle
                 startDate:(NSDate *)startDate
                   endDate:(NSDate *)endDate
                     alarm:(int)alarm
                  location:(NSString *)location
                     notes:(NSString *)notes
                     times:(int)recurrenceTimes
                 frequency:(EKRecurrenceFrequency)frequency
{
    if ([self getEventsFromEventStore:eventStore
                           eventTitle:eventTitle
                            startDate:startDate
                              endDate:endDate
                                alarm:alarm
                             location:location
                                notes:notes].count > 0) {
        return NO;
    }

    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title = eventTitle;
    event.location = location;
    event.startDate = startDate;
    event.endDate = endDate;
    event.notes = notes;

    if (recurrenceTimes > 0) {
        EKRecurrenceEnd *endRecurrence = [EKRecurrenceEnd recurrenceEndWithOccurrenceCount:recurrenceTimes];
        EKRecurrenceRule *rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:frequency interval:1 end:endRecurrence];
        [event addRecurrenceRule:rule];
    }

    [event addAlarm:[EKAlarm alarmWithRelativeOffset:(-1 * alarm)]];
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];

    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];

    return !err;
}

- (NSArray *)getEventsFromEventStore:(EKEventStore *)eventStore
                          eventTitle:(NSString *)eventTitle
                           startDate:(NSDate *)startDate
                             endDate:(NSDate *)endDate
                               alarm:(int)alarm
                            location:(NSString *)location
                               notes:(NSString *)notes
{
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:startDate
                                                                 endDate:endDate
                                                               calendars:nil];
    NSArray *events = [eventStore eventsMatchingPredicate:predicate];
    NSMutableArray *ret = [NSMutableArray array];

    for (EKEvent *e in events) {
        if ([self isEqualEvent:e
                    eventTitle:eventTitle
                     startDate:startDate
                       endDate:endDate
                         notes:notes
                      location:location]) {
            [ret addObject:e];
        }
    }

    return ret;
}

- (BOOL)isEqualEvent:(EKEvent *)event
          eventTitle:(NSString *)eventTitle
           startDate:(NSDate *)startDate
             endDate:(NSDate *)endDate
               notes:(NSString *)notes
            location:(NSString *)location
{
    if (eventTitle.length && ![eventTitle isEqualToString:event.title]) {
        return NO;
    }

    if (startDate && ![startDate isEqualToDate:event.startDate]) {
        return NO;
    }

    if (endDate && ![endDate isEqualToDate:event.endDate]) {
        return NO;
    }

    if (notes.length && ![notes isEqualToString:event.notes]) {
        return NO;
    }

    if (location.length && ![location isEqualToString:event.location]) {
        return NO;
    }

    return YES;
}

+ (EKRecurrenceFrequency)getRecurrenceFrequency:(NSString *)frequencyStr
{
    NSArray *frequencyArr = @[@"year", @"month", @"week", @"day"];
    EKRecurrenceFrequency frequency=EKRecurrenceFrequencyDaily;

    switch ([frequencyArr indexOfObject:frequencyStr]) {
        case 0:
            frequency = EKRecurrenceFrequencyYearly;
            break;
        case 1:
            frequency = EKRecurrenceFrequencyMonthly;
            break;
        case 2:
            frequency = EKRecurrenceFrequencyWeekly;
            break;
        case 3:
            frequency = EKRecurrenceFrequencyDaily;
            break;
    }

    return frequency;
}

- (NSDate *)dateFromString:(NSString *)dateString{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];

    return destDate;
}

@end
