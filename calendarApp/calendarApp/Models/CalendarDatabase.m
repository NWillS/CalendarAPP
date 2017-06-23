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
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS tr_calendar(date INTEGER , hour INTEGER, text TEXT ,PRIMARY KEY( date, hour));";
    
    [self.db open];
    [self.db executeUpdate:sql];
    [self.db close];
}
-(BOOL)isSetSchedule:(NSDate *)date{
    
    NSInteger count;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyyMMdd";
    
    NSString *sql = @"SELECT COUNT(date) as count FROM tr_calendar WHERE date = ?;";
    
    [self.db open];
    FMResultSet *results = [self.db executeQuery:sql,[formatter stringFromDate:date]];
    [results next];
    count = [results intForColumn:@"count"];
    
    [self.db close];
    
    if(count == 0){
        return NO;
    }
    return YES;
}
-(NSString *)getDetail:(NSDate *)date hour:(NSInteger)hour{
    NSString *text;
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyyMMdd";
    
    NSString *sql = @"SELECT text FROM tr_calendar WHERE date = ? AND hour = ?;";
    [self.db open];
    FMResultSet *results = [self.db executeQuery:sql,[formatter stringFromDate:date],[NSNumber numberWithInteger:hour]];
    [results next];
    
    text = [results stringForColumnIndex:0];

    [self.db close];
    return text;
}
@end
