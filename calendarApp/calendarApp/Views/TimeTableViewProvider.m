//
//  TimeTableViewProvider.m
//  calendarApp
//
//  Created by S N on 2017/06/18.
//  Copyright © 2017年 swill. All rights reserved.
//

#import "TimeTableViewProvider.h"
#import "HourCell.h"

@implementation TimeTableViewProvider

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 24*2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HourCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSInteger hour = indexPath.row/2;
    NSInteger min;
    if(indexPath.row%2 == 0){
        min = 0;
    }else{
        min = 30;
    }
    cell.hour.text = [NSString stringWithFormat:@"%zd:%02zd~", hour,min];
    
    
    __weak typeof (self) wself = self;
    NSString *text;
    if ([wself.myDelegate respondsToSelector:@selector(getText:)]) {
        NSString *h = [NSString stringWithFormat:@"%zd%02zd",hour,min];
        text = [wself.myDelegate getText:[h integerValue]];
    }
    
    cell.text.text = text;
    
    return cell;
}


@end
