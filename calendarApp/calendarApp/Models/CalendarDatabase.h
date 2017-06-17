//
//  CalendarDatabase.h
//  calendarApp
//
//  Created by S N on 2017/06/18.
//  Copyright © 2017年 swill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarDatabase : NSObject{
    //database path
    NSString *databasePath;
}
-(void)SetupDB;
@end
