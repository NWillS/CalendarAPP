//
//  NSDate_NSDate_Extension_.h
//  calendarApp
//
//  Created by S N on 2017/05/23.
//  Copyright © 2017年 swill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate ()

@end

@implementation NSDate (Extension)

/**
 *  Return the date one month before the receiver.
 *
 *  @return  date
 */
- (NSDate *)monthAgoDate
{
    NSInteger addValue = -1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

/**
 *  Return the date one month after the receiver.
 *
 *  @return  date
 */
- (NSDate *)monthLaterDate
{
    NSInteger addValue = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

@end
