//
//  SelectedDayViewController.m
//  calendarApp
//
//  Created by S N on 2017/06/11.
//  Copyright © 2017年 swill. All rights reserved.
//

#import "SelectedDayViewController.h"
#import "DetailViewController.h"

@interface SelectedDayViewController ()
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet  TimeTableViewProvider *tableView;
@property NSInteger hour;

@end

@implementation SelectedDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM月dd日";
    self.title = [formatter stringFromDate:self.date];
    
    self.tableView.dataSource = self.tableView;
    self.tableView.delegate = self.tableView;
    self.tableView.myDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
    
-(NSString *)getText:(NSInteger)hour{
    return [self.DB getDetail:self.date hour:hour];
}
-(void)selectedHour:(NSInteger)hour{
    self.hour = hour;
        [self performSegueWithIdentifier:@"toSelectedHour" sender:self];
}
    
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"toSelectedHour"]) {
        //遷移先のViewController
        DetailViewController *nextViewController = [segue destinationViewController];
        [nextViewController setHour:_hour];
        [nextViewController setDB:self.DB];
    }
}
@end
