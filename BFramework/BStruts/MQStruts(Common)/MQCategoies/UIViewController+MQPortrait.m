//
//  UIViewController+MQPortrait.m
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
// 

#import "UIViewController+MQPortrait.h"
#import <objc/runtime.h>
#import "MQNavBarConfig.h"

@implementation UIViewController (MQPortrait)

//+ (void)load{
//    Method methodA1 = class_getInstanceMethod(self, @selector(shouldAutorotate));
//    Method methodA2 = class_getInstanceMethod(self, @selector(xxx_shouldAutorotate));
//    method_exchangeImplementations(methodA1, methodA2);
//    
//    Method methodB1 = class_getInstanceMethod(self, @selector(supportedInterfaceOrientations));
//    Method methodB2 = class_getInstanceMethod(self, @selector(xxx_supportedInterfaceOrientations));
//    method_exchangeImplementations(methodB1, methodB2);
//    
//    Method methodC1 = class_getInstanceMethod(self, @selector(viewDidLoad));
//    Method methodC2 = class_getInstanceMethod(self, @selector(xxx_viewDidLoad));
//    method_exchangeImplementations(methodC1, methodC2);
//}
//
//- (void)xxx_viewDidLoad{
//    [self xxx_viewDidLoad];
//    [self setAutomaticallyAdjustsScrollViewInsets:NO];
//    [self setEdgesForExtendedLayout:UIRectEdgeNone];
//}
//
//- (BOOL)xxx_shouldAutorotate{
//    return false;
//}
//
//- (UIInterfaceOrientationMask)xxx_supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}


@end
