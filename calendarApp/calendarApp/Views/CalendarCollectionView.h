//
//  CollectionView.h
//  calendarApp
//
//  Created by S N on 2017/02/22.
//  Copyright © 2017年 swill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate_NSDate_Extension_.h"

@protocol CalendarCollectionViewDelegate <NSObject>
- (void)setSelectedDate:(NSDate *)selectedDate;
    - (void)selectedMonth:(NSString*)month day:(NSString*)day;
@end

@interface CalendarCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, retain) id<CalendarCollectionViewDelegate> delegate2;
@property (nonatomic, strong) NSDate *selectedDate;
-(void)prevMonth;
-(void)nextMonth;
@end
