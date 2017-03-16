//
//  MQAlertUtils.m
//  YDHYK
//
//  JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "MQAlertUtils.h"

@implementation MQAlertUtils : NSObject

+ (void)showAAlertWithTitle:(NSString *)title message:(NSString *)msg{
    NSString * strT = title;
    if (!title) {
        strT = @"提示";
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:strT message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [[self keyController] presentViewController:alert animated:true completion:nil];
}

+ (UIViewController *)keyController{
    UIViewController * keyController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    do{
        if (keyController.presentedViewController) {
            keyController = keyController.presentedViewController;
        }else{
            break;
        }
    }while(keyController.presentedViewController);
    return keyController;
}

+ (void)showAAlertWithTitle:(NSString *)title message:(NSString *)msg buttonText:(NSString *)buttonText buttonAction:(void (^)())buttonAction{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title ? title : @"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:buttonText ? buttonText :@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (buttonAction) {
            buttonAction();
        }
    }]];
    [[self keyController] presentViewController:alert animated:true completion:nil];
}

+ (void)showAAlertWithTitle:(NSString *)title message:(NSString *)msg buttonTexts:(NSArray *)arrTexts buttonAction:(void (^)(int))buttonAction{
    
    if (arrTexts && arrTexts.count) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:title ? title : @"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        int index = 0;
        for (NSString * strText in arrTexts) {
            [alert addAction:[UIAlertAction actionWithTitle:strText ? strText :@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (buttonAction) {
                    buttonAction(index);
                }
            }]];
            index++;
        }
        [[self keyController] presentViewController:alert animated:true completion:nil];
    }
}

+ (void)showActionSheetWithTitle:(NSString *)title
                     buttonTexts:(NSArray *)arrTexts
                    buttonAction:(void (^)(int))buttonAction{
    if (arrTexts && arrTexts.count) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        int index = 0;
        for (NSString * strText in arrTexts) {
            [alert addAction:[UIAlertAction actionWithTitle:strText ? strText :@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (buttonAction) {
                    buttonAction(index);
                }
            }]];
            index++;
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (buttonAction) {
                buttonAction(index);
            }
        }]];
        index++;
        [[self keyController] presentViewController:alert animated:true completion:nil];
    }
}

@end
