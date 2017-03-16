//
//  MQNoDataView.h
//  YDHYK
//
//  JuanFelix on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MQRCallBack)(void);

/**无数据或者无网络界面*/
@interface MQEmptyView : UIView
/**无数据 heightFix 用于调整高度 默认给0就行 */
+ (void)showNoDataInView:(UIView *)view
                   text1:(NSString *)text1
                   text2:(NSString *)text2
               heightFix:(CGFloat)heightFix;
/**无网络  用于调整高度 默认给0就行*/
+ (void)showNetworkErrorInView:(UIView *)view
                     heightFix:(CGFloat)heightFix
                 refreshAction:(MQRCallBack)refreshAction
                     ;
+ (void)dismissInView:(UIView *)view;
@end
