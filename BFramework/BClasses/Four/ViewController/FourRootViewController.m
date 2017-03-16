//
//  FourRootViewController.m
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "FourRootViewController.h"
#import "FirstRootViewController.h"

@interface FourRootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation FourRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Four";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //添加刷新控件
    [self.tableView mq_addHeaderRefreshActionUseMQImage:YES target:self action:@selector(refreshHeader)];
    [self.tableView mq_addFooterRefreshActionAutoRefresh:YES target:self action:@selector(refreshFooter)];

}


#pragma mark - Refresh
- (void)refreshHeader{
    NSLog(@"refreshHeader");
    
    [self.tableView.mj_header endRefreshing];
}

- (void)refreshFooter{
    NSLog(@"refreshFooter");
    
    [self.tableView.mj_footer endRefreshing];
}




#pragma mark - UITablewViewDelegate && UITabelViewDataSoure
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}


- (IBAction)test:(id)sender {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    NSArray *imagesURL = @[
                           @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                           @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                           @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg"
                           ];
    
    // 情景三：图片配文字(可选)
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"代码在使用过程中出现问题",
                        @"您可以发邮件到qzycoder@163.com",
                        ];
    
    //如果你的这个广告视图是添加到导航控制器子控制器的View上,请添加此句,否则可忽略此句
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    AdView *adView = [AdView adScrollViewWithFrame:CGRectMake(0, 300, width, 172)
                              imageLinkURL:imagesURL
                       placeHoderImageName:@"placeHoder.jpg"
                      pageControlShowStyle:UIPageControlShowStyleCenter];
    
    //    是否需要支持定时循环滚动，默认为YES
    //    adView.isNeedCycleRoll = YES;
    
    [adView setAdTitleArray:titles withShowStyle:AdTitleShowStyleLeft];
    //    设置图片滚动时间,默认3s
    //    adView.adMoveTime = 2.0;
    
    //图片被点击后回调的方法
    adView.callBack = ^(NSInteger index,NSString * imageURL)
    {
        NSLog(@"被点中图片的索引:%ld---地址:%@",index,imageURL);
    };
    [self.view addSubview:adView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
