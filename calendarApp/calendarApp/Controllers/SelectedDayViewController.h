//
//  SelectedDayViewController.h
//  calendarApp
//
//  Created by S N on 2017/06/11.
//  Copyright © 2017年 swill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDatabase.h"
#import "TimeTableViewProvider.h"

@interface SelectedDayViewController : UIViewController<TimeTableViewProviderDelegate>
    @property (nonatomic ,strong) NSDate *date;
    @property CalendarDatabase *DB;

@end
