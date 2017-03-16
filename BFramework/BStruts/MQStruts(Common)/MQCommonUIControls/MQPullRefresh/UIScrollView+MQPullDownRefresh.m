//
//  UIScrollView+MQPullDownRefresh.m
//  YDHYK
//
//  JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UIScrollView+MQPullDownRefresh.h"
#import "MQRefreshHeader.h"
#import "MQCommonEngine.h"

@implementation UIScrollView (MQPullDownRefresh)


-(void)mq_addHeaderRefreshActionUseMQImage:(BOOL)bmqImage
                                    target:(id)target
                                    action:(SEL)action{
    if (bmqImage) {
        // 添加动画图片的下拉刷新
        MQRefreshHeader * header = nil;
        header.automaticallyChangeAlpha = YES;  //渐显
        header = [MQRefreshHeader headerWithRefreshingTarget:target refreshingAction:action];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        self.mj_header = header;
    }else{
        // 设置文字
        MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
        [header.lastUpdatedTimeLabel setHidden:YES];
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        // 设置字体
        header.stateLabel.font = [UIFont mq_bodyFontWithSize:14];
        header.lastUpdatedTimeLabel.font = [UIFont mq_bodyFontWithSize:12];
        // 设置颜色
        header.stateLabel.textColor = [UIColor mq_sub1TextColor];
        header.lastUpdatedTimeLabel.textColor = [UIColor mq_sub1TextColor];
        self.mj_header = header;
    }
}

-(void)mq_addFooterRefreshActionAutoRefresh:(BOOL)autoRefresh
                                     target:(id)target
                                     action:(SEL)action{
    if (autoRefresh) {
        MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
        [footer setBackgroundColor:[UIColor clearColor]];
        [footer setRefreshingTitleHidden:YES];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"" forState:MJRefreshStatePulling];
        [footer setTitle:@"" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"--没有更多了--" forState:MJRefreshStateNoMoreData];
        [footer.stateLabel setFont:[UIFont mq_bodyFontWithSize:14]];
        [footer.stateLabel setTextColor:[UIColor mq_sub1TextColor]];
        self.mj_footer = footer;
    }else{
        MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
        footer.automaticallyChangeAlpha = YES;
        [footer setBackgroundColor:[UIColor clearColor]];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"" forState:MJRefreshStatePulling];
        [footer setTitle:@"" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"--没有更多了--" forState:MJRefreshStateNoMoreData];
        [footer.stateLabel setFont:[UIFont mq_bodyFontWithSize:14]];
        [footer.stateLabel setTextColor:[UIColor mq_sub1TextColor]];
        // 设置了底部inset
        // 忽略掉底部inset
        self.mj_footer = footer;
    }
}


@end
