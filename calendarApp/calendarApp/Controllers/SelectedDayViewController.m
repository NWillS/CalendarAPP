//
//  SelectedDayViewController.m
//  calendarApp
//
//  Created by S N on 2017/06/11.
//  Copyright © 2017年 swill. All rights reserved.
//

#import "SelectedDayViewController.h"
#import "TimeTableViewProvider.h"

@interface SelectedDayViewController ()
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet  TimeTableViewProvider *tableView;

@end

@implementation SelectedDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@/%@",self.month,self.day];
    
    self.tableView.dataSource = self.tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
