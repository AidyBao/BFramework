//
//  UITabBarController+ZX.m
//  ZXStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UITabBarController+MQ.h"
#import "MQTabBarConfig.h"
#import <objc/runtime.h>


@implementation MQModelVCInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end


@implementation UITabBarController (MQ)

- (void)mq_addChildViewController:(UIViewController *)vc
                         withItem:(MQTabbarItem *)item{
    if (vc) {
        UIImage * normalImage = [UIImage imageNamed:item.normalImage];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectedImage = [UIImage imageNamed:item.selectedImage];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.image = normalImage;
        vc.tabBarItem.selectedImage = selectedImage;
        vc.tabBarItem.title = item.name;
        
        if (!self.mqModelControllersInfo) {
            self.mqModelControllersInfo = [NSMutableDictionary dictionary];
        }
        
        if (item.embedInNavigation) {//嵌入导航控制器
            if (item.showAsPresent) {//不在tabar中显示，present 在最上层
                //待优化
//                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
                MQModelVCInfo * mInfo = [[MQModelVCInfo alloc] init];
                [mInfo setValuesForKeysWithDictionary:@{@"className":NSStringFromClass([vc class]),@"item":item}];
                [self.mqModelControllersInfo setObject:mInfo forKey:[NSNumber numberWithInteger:self.viewControllers.count]];
                
                [self xxx_addChildViewContoller:[[UIViewController alloc] init] withItem:item];
            }else{
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
                nav.tabBarItem.title = item.name;
                [self addChildViewController:nav];
            }
        }else{
            if (item.showAsPresent) {
                //待优化
                //
                MQModelVCInfo * mInfo = [[MQModelVCInfo alloc] init];
                [mInfo setValuesForKeysWithDictionary:@{@"className":NSStringFromClass([vc class]),@"item":item}];
                [self.mqModelControllersInfo setObject:mInfo forKey:[NSNumber numberWithInteger:self.viewControllers.count]];
                [self xxx_addChildViewContoller:[[UIViewController alloc] init] withItem:item];
            }else{
                [self addChildViewController:vc];
            }
        }
        
        if (!self.mqtarbarItems) {
            self.mqtarbarItems = [NSMutableArray array];
        }
        [self.mqtarbarItems addObject:item];
    }
}

- (void)xxx_addChildViewContoller:(UIViewController *)vc withItem:(MQTabbarItem *)item{
    UIImage * normalImage = [UIImage imageNamed:item.normalImage];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = normalImage;
    
    UIImage * selectedImage = [UIImage imageNamed:item.selectedImage];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.title = item.name;
    [self addChildViewController:vc];
}

- (void)mq_addChildViewController:(UIViewController *)vc atPlistIndex:(NSInteger)index{
    NSArray * items = [MQTabBarConfig tabbarItems];
    if (items && index < items.count) {
        MQTabbarItem * item = [items objectAtIndex:index];
        [self mq_addChildViewController:vc withItem:item];
    }
}

+ (BOOL)mq_tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    __block NSInteger index = -1;
    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == viewController) {
            index = idx;
            *stop = true;
        }
    }];
    if (index != -1) {
        MQModelVCInfo * info = [tabBarController.mqModelControllersInfo objectForKey:[NSNumber numberWithInteger:index]];
        MQTabbarItem * item = info.item;
        if (item.showAsPresent) {
            if (item.embedInNavigation) {
                Class cls = NSClassFromString(info.className);
                [tabBarController presentViewController:[[UINavigationController alloc] initWithRootViewController:[cls new]] animated:true completion:nil];
            }else{
                Class cls = NSClassFromString(info.className);
                [tabBarController presentViewController:[cls new] animated:true completion:nil];
            }
            return false;
        }
    }
    return true;
}

#pragma mark ---

static const char * MQTarbarItems = "MQTarbarItems";

- (NSMutableArray<MQTabbarItem *> *)mqtarbarItems{
    return  objc_getAssociatedObject(self, MQTarbarItems);
}

- (void)setMqtarbarItems:(NSMutableArray<MQTabbarItem *> *)mqtarbarItems{
    objc_setAssociatedObject(self, MQTarbarItems, mqtarbarItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char * MQModelControllersInfo = "MQModelControllersInfo";

- (NSMutableDictionary *)mqModelControllersInfo{
    return  objc_getAssociatedObject(self, MQModelControllersInfo);
}

- (void)setMqModelControllersInfo:(NSMutableDictionary *)mqModelControllersInfo{
    objc_setAssociatedObject(self, MQModelControllersInfo, mqModelControllersInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
