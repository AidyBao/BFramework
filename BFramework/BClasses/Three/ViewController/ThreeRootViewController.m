//
//  ThreeRootViewController.m
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "ThreeRootViewController.h"
#import "WHC_FMDBTestViewController.h"
#import "LK_FMDBTestViewController.h"

@interface ThreeRootViewController ()<MQLineChartViewDelegate>

@property (nonatomic,strong) MQLineChartView * chartView;

@end

@implementation ThreeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Three";
}

#pragma mark - 主控制器跳转
- (IBAction)testRouterVC:(id)sender {
    //跳转到主界面
    [MQRootViewControllers reload];
    [MQRouter changeRootViewController:[MQRootViewControllers mq_tabbarController]];
}

#pragma mark - 绘图
- (IBAction)testChart:(id)sender {
    [self.view addSubview:self.chartView];
    
    self.chartView.preValue  = @"0.015";//先赋值
    self.chartView.arrValues = @[@(12.23),@(24.4),@(50),@(75),@(21),@(2),@(11)];
    self.chartView.arrDays   = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    [self.chartView setDateInfo:@"7天内"];
    [self.chartView selectedAtIndex:2];
}


#pragma mark - MQLineChartViewDelegate
- (void)mqLineChartViewSelectedAtIndex:(NSInteger)index lineChartView:(MQLineChartView *)lineChartView{
    NSLog(@"selected at index:%@",@(index));
}
- (void)mqLineChartViewAnimationEnd:(MQLineChartView *)lineChartView{
    NSLog(@"");
}


- (IBAction)WHC_FMDB_Test:(id)sender {
    [MQRouter changeRootViewController:[[WHC_FMDBTestViewController alloc]init]];
}

- (IBAction)LK_FMDB_Test:(id)sender {
    [MQRouter changeRootViewController:[[WHC_FMDBTestViewController alloc]init]];
}


#pragma mark - lazy
- (MQLineChartView *)chartView{
    if (!_chartView) {
        _chartView = [[MQLineChartView alloc] initWithOrigin:CGPointZero];
        [_chartView setDelegate:self];
    }
    return _chartView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
