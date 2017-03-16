//
//  UITabBarController+ZX.h
//  ZXStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQTabbarItem.h"

@interface MQModelVCInfo : NSObject

@property (nonatomic,copy)   NSString * className;
@property (nonatomic,strong) MQTabbarItem * item;

@end

/**TabBar 扩展*/

@interface UITabBarController (MQ)

/**zxtabbaritems 不包括系统的*/
@property (nonatomic,strong,readonly) NSMutableArray<MQTabbarItem *> * mqtarbarItems;

/**present 的controller 信息*/
//待优化
@property (nonatomic,strong,readonly) NSMutableDictionary * mqModelControllersInfo;

/**添加Controller*/
- (void)mq_addChildViewController:(UIViewController *)vc
                         withItem:(MQTabbarItem *)item;

/**添加Controller,资源从plist读取*/
- (void)mq_addChildViewController:(UIViewController *)vc
                     atPlistIndex:(NSInteger)index;
/**ShowAsPresent 在APPDelegate 选择Tabbar代理时 调用该方法*/
+ (BOOL)mq_tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

@end
