//
//  MQHUD.m
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "MQHUD.h"
#import "UIColor+MQColor.h"
#import "UIFont+MQFont.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation MQHUD

//MARK: - MB
+ (void)MBShowSuccessInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay{
    MBProgressHUD * mbp = [MBProgressHUD showHUDAddedTo:view animated:true];
    mbp.mode = MBProgressHUDModeCustomView;
    mbp.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MQ_IMAGE_SUCCESS]];
    mbp.label.text = text;
    mbp.label.font = [UIFont mq_titleFontWithSize:15];
    mbp.minSize = CGSizeMake(100, 100);
    mbp.label.textColor = MQWHITE_COLOR;
    mbp.bezelView.layer.cornerRadius = 10.0;
    mbp.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    mbp.bezelView.color = MQRGBA_COLOR(0, 0, 0, 0.7);
    if (delay > 0) {
        [mbp hideAnimated:true afterDelay:delay];
    }
    mbp.removeFromSuperViewOnHide = true;
}

+ (void)MBShowFailureInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay{
    MBProgressHUD * mbp = [MBProgressHUD showHUDAddedTo:view animated:true];
    mbp.mode = MBProgressHUDModeCustomView;
    mbp.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MQ_IMAGE_FAILURE]];
    if ([text respondsToSelector:@selector(length)] && text.length) {
        mbp.label.text = text;
    }else{
        mbp.label.text = @"未知错误";
    }
    mbp.label.font = [UIFont mq_titleFontWithSize:15];
    mbp.minSize = CGSizeMake(100, 100);
    mbp.label.textColor = MQWHITE_COLOR;
    mbp.bezelView.layer.cornerRadius = 10.0;
    mbp.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    mbp.bezelView.color = MQRGBA_COLOR(0, 0, 0, 0.7);
    if (delay > 0) {
        [mbp hideAnimated:true afterDelay:delay];
    }
    mbp.removeFromSuperViewOnHide = true;
}

+ (void)MBShowLoadingInView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay{
    MBProgressHUD * mbp = [MBProgressHUD showHUDAddedTo:view animated:true];
    mbp.mode = MBProgressHUDModeCustomView;
    UIImageView * customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MQ_IMAGE_LOADING]];
    CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI*2);
    anima.duration = 1.0f;
    anima.repeatCount = NSUIntegerMax;
    anima.removedOnCompletion = false;
    [customView.layer addAnimation:anima forKey:nil];
    mbp.customView = customView;
    mbp.label.text = text;
    mbp.label.font = [UIFont mq_titleFontWithSize:15];
    mbp.minSize = CGSizeMake(100, 100);
    mbp.label.textColor = MQWHITE_COLOR;
    mbp.bezelView.layer.cornerRadius = 10.0;
    mbp.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    mbp.bezelView.color = MQRGBA_COLOR(0, 0, 0, 0.7);
    if (delay > 0) {
        [mbp hideAnimated:true afterDelay:delay];
    }
    mbp.removeFromSuperViewOnHide = true;
}

+ (void)MBHideForView:(UIView *)view animate:(BOOL)animate{
    [MBProgressHUD hideHUDForView:view animated:animate];
}


@end
