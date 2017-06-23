//
//  DetailViewController.h
//  calendarApp
//
//  Created by S N on 2017/06/19.
//  Copyright © 2017年 swill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDatabase.h"

@interface DetailViewController : UIViewController
    @property NSInteger hour;
    @property CalendarDatabase *DB;

@end
