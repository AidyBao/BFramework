//
//  MQQRCodeUtils.h
//  YDHYK
//
//  Created by screson on 2016/12/22.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MQQRCodeUtils : NSObject

+ (UIImage *)createQRForString:(NSString *)qrString withSize:(CGFloat)size;
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
