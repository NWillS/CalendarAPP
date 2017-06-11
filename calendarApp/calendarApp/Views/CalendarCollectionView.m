//
//  CollectionView.m
//  calendarApp
//
//  Created by S N on 2017/02/22.
//  Copyright © 2017年 swill. All rights reserved.
//

#import "CalendarCollectionView.h"

@interface CalendarCollectionView()

@end
#import "DayCell.h"

typedef NS_ENUM(NSInteger,DayOfWeek){
    Sun = 0,
    Mon,
    Tue,
    Wed,
    Thu,
    Fri,
    Sat
};




static NSInteger const DaysPerWeek = 7;

static CGFloat const CellMargin = 2.0f;

static NSString * dayAWeek [7] = {@"日",@"月",@"火",@"水",@"木",@"金",@"土"};



@implementation CalendarCollectionView

-(void)prevMonth{
    __weak typeof (self) wself = self;
    
    self.selectedDate = [wself.selectedDate monthAgoDate];
    
    [wself reloadData];
    if ([wself.delegate2 respondsToSelector:@selector(setSelectedDate:)]) {
        [wself.delegate2 setSelectedDate:wself.selectedDate];
    }
}
-(void)nextMonth{
    __weak typeof (self) wself = self;
    self.selectedDate = [wself.selectedDate monthLaterDate];
    
    [wself reloadData];
    if ([wself.delegate2 respondsToSelector:@selector(setSelectedDate:)]) {
        [wself.delegate2 setSelectedDate:wself.selectedDate];
    }
}

/**
 *  Return First date of the month
 *
 *  @return date
 */
- (NSDate *)firstDateOfMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                   fromDate:self.selectedDate];
    components.day = 1;
    
    NSDate *firstDateMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return firstDateMonth;
}

/**
 *  return date for specified indexPath
 *
 *  @param indexPath cell's indexPath
 *
 *  @return date
 */
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    // calculate the ordinal number of first day
    NSInteger ordinalityOfFirstDay = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                                                             inUnit:NSCalendarUnitWeekOfMonth
                                                                            forDate:self.firstDateOfMonth];
    
    // calculate the difference between "day number of cell at indexPath" and "day number of first day"
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = indexPath.item - (ordinalityOfFirstDay - 1);
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                                 toDate:self.firstDateOfMonth
                                                                options:0];
    return date;
}

#pragma mark - UICollectionViewDataSource methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    if(section == 0){
        return DaysPerWeek;
    }else{
        // calculate number of weeks
        NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth
                                                                  inUnit:NSCalendarUnitMonth
                                                                 forDate:self.firstDateOfMonth];
        NSUInteger numberOfWeeks = rangeOfWeeks.length;
        NSInteger numberOfItems = numberOfWeeks * DaysPerWeek;
        
        return numberOfItems;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DayCell *cell;
    if(indexPath.section == 0){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayForWeekCell"
                                                         forIndexPath:indexPath];
        
        cell.label.text = dayAWeek[indexPath.row];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                         forIndexPath:indexPath];
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"d";
        NSDate *dateForCellAIP = [self dateForCellAtIndexPath:indexPath];
        cell.label.text = [formatter stringFromDate:dateForCellAIP];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger currentMonth = [calendar component:NSCalendarUnitMonth fromDate:self.selectedDate];
        NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:dateForCellAIP];
        if(month != currentMonth){
            cell.label.alpha = 0.4;
        }else{
            cell.label.alpha = 1.0;
        }
    }
    
    cell.label.textColor = [self colorOfWeek:indexPath.row];
    return cell;
}
-(UIColor *)colorOfWeek:(NSInteger)indexPath{
    if(indexPath % DaysPerWeek == Sun){
        return [UIColor colorWithRed:255.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1.0];
    }else if(indexPath % DaysPerWeek == Sat){
        return [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:255.0 / 255 alpha:1.0];
    }else{
        return [UIColor blackColor];
        
    }
}
    // Cell が選択された場合
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof (self) wself = self;
    if(indexPath.section != 0){
        NSDate *dateForCellAIP = [self dateForCellAtIndexPath:indexPath];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"MM";
        NSString *month = [formatter stringFromDate:dateForCellAIP];
        formatter.dateFormat = @"dd";
        NSString *day = [formatter stringFromDate:dateForCellAIP];
        if ([wself.delegate2 respondsToSelector:@selector(selectedMonth:day:)]) {
            [wself.delegate2 selectedMonth:month day:day];
        }
    }
}
    
#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberOfMargin = 8;
    CGFloat width = floorf((collectionView.frame.size.width - CellMargin * numberOfMargin) / DaysPerWeek);
    CGFloat height;
    if (indexPath.section == 0) {
        height = width * 0.75f;
    }else{
        height = width * 1.3f;
    }
    
    return CGSizeMake(width, height);
}
    

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin*10, CellMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}

@end
