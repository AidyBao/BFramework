//
//  UIViewController+MQNav.h
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**有关导航栏的设置 （所有属性默认从plist读取）*/
@interface UIViewController (MQNav)

//MARK: - 导航栏 右边按钮
/**导航栏右侧按钮 图片名称*/
- (void)mq_addRightBarItemsWithImageNames:(NSArray<NSString *> *)imagesNames
                            originalColor:(BOOL)originalColor;
/**导航栏右侧按钮 按钮标题名称 font color 可为nil*/
- (void)mq_addRightBarItemsWithTexts:(NSArray<NSString *> *)texts
                                font:(UIFont *)font
                               color:(UIColor *)color;

/**导航栏右侧按钮 按钮iconfont标题名称 color 可为nil*/
- (void)mq_addRightBarItemsWithIconFontTexts:(NSArray<NSString *> *)texts
                                    fontSize:(CGFloat)fontSize
                                       color:(UIColor *)color;
/**导航栏右侧按钮 自定义视图*/
- (void)mq_addRightBarItemWithCustomView:(UIView *)customView;

/**导航栏右侧按钮事件，不包括自定义视图*/
- (void)mq_rightBarButtonActionsIndex:(NSInteger)index;

//MARK: - 导航栏 左边按钮
/**导航栏左侧按钮 图片名称*/
- (void)mq_addLeftBarItemsWithImageNames:(NSArray<NSString *> *)imagesNames
                           originalColor:(BOOL)originalColor;
/**导航栏左侧按钮 按钮标题名称 font color 可为nil*/
- (void)mq_addLeftBarItemsWithTexts:(NSArray<NSString *> *)texts
                               font:(UIFont *)font
                              color:(UIColor *)color;
/**导航栏左侧按钮 按钮iconfont标题名称 color 可为nil*/
- (void)mq_addLeftBarItemsWithIconFontTexts:(NSArray<NSString *> *)texts
                                   fontSize:(CGFloat)fontSize
                                      color:(UIColor *)color;
/**导航栏左侧按钮 自定义视图*/
- (void)mq_addLeftBarItemWithCustomView:(UIView *)customView;
/**导航栏左侧按钮事件，不包括自定义视图*/
- (void)mq_leftBarButtonActionsIndex:(NSInteger)index;

/**NavBar 背景颜色*/
- (void)mq_setNavBarBackgroundColor:(UIColor *)color;

/**重设 NavBar 标题及图标按钮颜色（默认Plist读取）*/
- (void)mq_setNavBarSubViewsColor:(UIColor *)color;
/**重设 NavBar 标题颜色）*/
- (void)mq_setNavBarTitleColor:(UIColor *)color;

/**设置NavBar 返回按钮图标【在上一层VC中提前设置】*/
- (void)mq_setNavBarBackButtonImage:(UIImage *)image;

/**pop 到某个控制器*/
- (void)mq_popToViewControllerwithClassName:(NSString *)className animated:(BOOL)animated;

@end
