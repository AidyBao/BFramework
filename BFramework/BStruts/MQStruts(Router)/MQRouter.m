//
//  MQRouter.m
//  MQStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQRouter.h"
#import "MQRootViewControllers.h"

@implementation MQRouter

+ (void)changeRootViewController:(UIViewController *)rootVC{
    UIWindow * window = [MQRootViewControllers appWindow];
    window.rootViewController = rootVC;
}

+ (void)shouldSelectTabbarIndex:(NSInteger)index{
    UITabBarController * tabbarvc = [MQRootViewControllers mq_tabbarController];
    [tabbarvc.delegate tabBarController:tabbarvc shouldSelectViewController:[[tabbarvc viewControllers] objectAtIndex:index]];
}

+ (void)selectTabbarIndex:(NSInteger)index{
    UITabBarController * tabbarvc = [MQRootViewControllers mq_tabbarController];
    [tabbarvc setSelectedIndex:index];
}

@end
