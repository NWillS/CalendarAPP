//
//  ViewController.h
//  calendarApp
//
//  Created by S N on 2017/05/23.
//  Copyright © 2017年 swill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarCollectionViewProvider.h"
#import "CalendarDatabase.h"

@interface CalendarViewController : UIViewController<CalendarCollectionViewProviderDelegate>

@property CalendarDatabase *DB;
@end

