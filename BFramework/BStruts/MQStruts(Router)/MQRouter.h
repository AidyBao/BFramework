//
//  MQRouter.h
//  MQStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**界面跳转控制*/
@interface MQRouter : NSObject

/**切换window 根控制器*/
+ (void)changeRootViewController:(UIViewController *)rootVC;


+ (void)shouldSelectTabbarIndex:(NSInteger)index;
+ (void)selectTabbarIndex:(NSInteger)index;


//+ (void)loadAdsViewController:(UIViewController *)adsVC;
//
//+ (void)loadLeadPageViewController:(UIViewController *)leadPageVC;
//
//+ (void)loadRootViewController:(UIViewController *)rootVC;

@end
