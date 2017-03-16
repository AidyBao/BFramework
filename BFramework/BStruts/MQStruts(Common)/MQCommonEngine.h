//
//  ZXCommonEngine.h
//  ZXStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQUtilityTools.h"
#import "MQUIControlExtends.h"
#import "MQCategories.h"
#import "MQCommonEngine.h"
#import "MQCommonUIControls.h"

/**装载UI配置*/
@interface MQCommonEngine : NSObject

//MARK: - 装载配置
/** 装载所有配置 */
+ (void)loadAllConfig;
/** 装载导航栏配置 */
+ (void)loadNavBarConfig;
/** 装载标签栏控制 */
+ (void)loadTabBarConfig;


//MARK: -卸载配置  有点不合理，没法还原到原始状态
/** 卸载所有配置 */
//+ (void)unloadAllConfig;

@end
