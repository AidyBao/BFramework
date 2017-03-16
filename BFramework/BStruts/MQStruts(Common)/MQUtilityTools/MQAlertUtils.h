//
//  MQAlertUtils.h
//  YDHYK
//
//  JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**警告框工具类*/
@interface MQAlertUtils : NSObject

/**无事件处理*/
+ (void)showAAlertWithTitle:(NSString *)title
                    message:(NSString *)msg;
/**单个按钮+事件处理*/
+ (void)showAAlertWithTitle:(NSString *)title
                    message:(NSString *)msg
                 buttonText:(NSString *)buttonText
               buttonAction:(void (^)())buttonAction;
/**多个按钮+事件处理*/
+ (void)showAAlertWithTitle:(NSString *)title
                    message:(NSString *)msg
                buttonTexts:(NSArray *)arrTexts
               buttonAction:(void (^)(int buttonIndex))buttonAction;

+ (void)showActionSheetWithTitle:(NSString *)title
                     buttonTexts:(NSArray *)arrTexts
                    buttonAction:(void (^)(int buttonIndex))buttonAction;

@end
