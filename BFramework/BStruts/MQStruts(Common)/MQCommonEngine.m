//
//  ZXCommonEngine.m
//  ZXStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//  设置统一配置颜色

#import "MQCommonEngine.h"
#import <UIKit/UIKit.h>

#import "NSBundle+MQSetting.h"
#import "UIColor+MQColor.h"
#import "UIFont+MQFont.h"
#import "MQNavBarConfig.h"
#import "MQTabBarConfig.h"

@implementation MQCommonEngine

#pragma mark - 所有配置
+ (void)loadAllConfig{
    [self loadNavBarConfig];
    [self loadTabBarConfig];
}

#pragma mark - 导航栏配置
+ (void)loadNavBarConfig{
    
    //导航栏背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor mq_navbarColor]];
//    if (![ZXNavBarConfig userSystemBackButton]) {
//        [[UINavigationBar appearance] setBackIndicatorImage:[NSBundle zx_navBackImage]];
//        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[NSBundle zx_navBackImage]];
//    }
    //导航栏透明度
    [[UINavigationBar appearance] setTranslucent:[MQNavBarConfig isTranslucent]];
    [[UINavigationBar appearance] setTintColor:[UIColor mq_navbarButtonTitleColor]];
    
    //导航栏字体颜色及字体
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:
                                                               [UIColor mq_navbarTitleColor],
                                                           NSFontAttributeName:
                                                               [UIFont systemFontOfSize:
                                                                mq_navBarTitleFontSize()]
                                                        }];
    //导航栏分割线
    if (![MQNavBarConfig showSeparatorLine]) {
        [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init]
                                           forBarPosition:UIBarPositionAny
                                               barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
}

#pragma mark - 标签栏配置
+ (void)loadTabBarConfig{
    
    //标签栏背景色
    [[UITabBar appearance] setBarTintColor:[UIColor mq_tabbarColor]];
    
    //标签栏透明度
    [[UITabBar appearance] setTranslucent:[MQTabBarConfig isTranslucent]];
    
    //标签栏选中和未选中字体和颜色
    if (![MQTabBarConfig isCustomFontSize]) {
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSForegroundColorAttributeName:
                                                                [UIColor mq_tabbarTitleNormalColor]
                                                            }
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSForegroundColorAttributeName:
                                                                [UIColor mq_tabbarTitleSelectedColor]
                                                            }
                                                 forState:UIControlStateSelected];
    }else{
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSForegroundColorAttributeName:
                                                                [UIColor mq_tabbarTitleNormalColor],
                                                            NSFontAttributeName:
                                                                [UIFont systemFontOfSize:
                                                                 mq_tabBarItemTitleFontSize()]
                                                            }
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSForegroundColorAttributeName:
                                                                [UIColor mq_tabbarTitleSelectedColor],
                                                            NSFontAttributeName:
                                                                [UIFont systemFontOfSize:
                                                                 mq_tabBarItemTitleFontSize()]
                                                            }
                                                 forState:UIControlStateSelected];
    }
    
    //标签栏阴影
    if (![MQTabBarConfig showSeparatorLine]) {
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    }
}

@end
