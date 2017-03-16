//
//  UIScrollView+MQPullDownRefresh.h
//  YDHYK
//
//  JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UIScrollView (MQPullDownRefresh)

/**添加下拉刷新
 * bMQImage True: 使用图片 False:使用文字
 */
-(void)mq_addHeaderRefreshActionUseMQImage:(BOOL)bmqImage
                                    target:(id)target
                                    action:(SEL)action;
/**添加上拉加载更多
 * autoRefresh True: 自动加载
 */
-(void)mq_addFooterRefreshActionAutoRefresh:(BOOL)autoRefresh
                                     target:(id)target
                                     action:(SEL)action;

@end
