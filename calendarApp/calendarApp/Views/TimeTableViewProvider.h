//
//  TimeTableViewProvider.h
//  calendarApp
//
//  Created by S N on 2017/06/18.
//  Copyright © 2017年 swill. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeTableViewProviderDelegate<NSObject>
- (NSString *)getText:(NSInteger)hour;
@end

@interface TimeTableViewProvider : UITableView<UITableViewDataSource>
@property(nonatomic, retain) id<TimeTableViewProviderDelegate> myDelegate;

@end
