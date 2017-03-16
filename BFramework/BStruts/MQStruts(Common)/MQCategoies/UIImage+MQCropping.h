//
//  UIImage+Cropping.h
//  YDHYK
//
//  Created by 120v on 2017/1/12.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MQCropping)
/**
 * @pragram 尺寸和质量压缩
 * @newsize 压缩大小
 * @image 需要处理的图片
 **/
+ (UIImage*)mq_scaleImageWithImage:(UIImage*)image toSize:(CGSize)newsize;
/**
 * @pragram 将裁剪后不规则的图片，裁剪为正方形
 * @image 需要剪切图片
 **/
+ (UIImage *)mq_cutImageToSquare:(UIImage*)image;
/**
 * @pragram 固定图片方向
 * @aImage 需要固定图片
 **/
+ (UIImage *)mq_fixOrientation:(UIImage *)aImage;
@end
