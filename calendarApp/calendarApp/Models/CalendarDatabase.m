//
//  CalendarDatabase.m
//  calendarApp
//
//  Created by S N on 2017/06/18.
//  Copyright © 2017年 swill. All rights reserved.
//

#import "CalendarDatabase.h"
#import "FMDatabase.h"

@interface CalendarDatabase()
@property FMDatabase *db;
@end

@implementation CalendarDatabase
-(void)SetupDB{
    //DBのパス設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir  = [paths objectAtIndex:0];
    databasePath   = [dir stringByAppendingPathComponent:@"calendar.db"];
    NSLog(@"%@",databasePath);
    _db = [FMDatabase databaseWithPath:databasePath];
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS tr_calendar(date INTEGER PRIMARY KEY, year INTEGER , month INTEGER,day INTEGER, hour INTEGER, min INTEGER, text TEXT);";
    
    [_db open];
    [_db executeUpdate:sql];
    [_db close];
}

@end
