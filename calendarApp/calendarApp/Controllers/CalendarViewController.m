//
//  ViewController.m
//  calendarApp
//
//  Created by S N on 2017/05/23.
//  Copyright © 2017年 swill. All rights reserved.
//

#import "CalendarViewController.h"
#import "SelectedDayViewController.h"

@interface CalendarViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBtn;
@property (weak, nonatomic) IBOutlet CalendarCollectionViewProvider *collectionV;
@property NSDate *date;

@end

@implementation CalendarViewController
- (IBAction)tappedPrevBtn:(id)sender {
    [self.collectionV prevMonth];
}
- (IBAction)tappedNextBtn:(id)sender {
    [self.collectionV nextMonth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) wself = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionV.dataSource = self.collectionV;
    self.collectionV.delegate = self.collectionV;
    self.collectionV.delegate2 = self;
    
    self.collectionV.selectedDate = [NSDate date];
    [wself setSelectedDate:wself.collectionV.selectedDate];
    
    self.DB = [[CalendarDatabase alloc]init];
    [self.DB SetupDB];
}
-(void)viewWillAppear:(BOOL)animated{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
    _collectionV.selectedDate = selectedDate;
    
    // update title text
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy年M月";
    self.title = [formatter stringFromDate:_collectionV.selectedDate];
    formatter.dateFormat = @"M";
    self.nextBtn.enabled = YES;
    self.prevBtn.enabled = YES;
    if([[formatter stringFromDate:_collectionV.selectedDate]  isEqual: @"1"]){
        self.prevBtn.enabled = NO;
    }else if ([[formatter stringFromDate:_collectionV.selectedDate]  isEqual: @"12"]){
        self.nextBtn.enabled = NO;
    }
}
-(void)selectedDate:(NSDate *)date{
    self.date = date;
    [self performSegueWithIdentifier:@"toSelectedDay" sender:self];
}
    
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"toSelectedDay"]) {
        //遷移先のViewController
        SelectedDayViewController *nextViewController = [segue destinationViewController];
        [nextViewController setDate:self.date];
        [nextViewController setDB:self.DB];
    }
}
    
-(BOOL)isSetSchedule:(NSDate *)date{
    return [self.DB isSetSchedule:date];
}
@end
