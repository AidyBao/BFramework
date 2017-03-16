//
//  UIViewController+MQNav.m
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UIViewController+MQNav.h"
#import "UIFont+MQFont.h"
#import "UIColor+MQColor.h"

#define MQ_NAV_FixedSpace  -4

@implementation UIViewController (MQNav)

//MARK: right
- (void)mq_addRightBarItemsWithImageNames:(NSArray<NSString *> *)imagesNames
                            originalColor:(BOOL)originalColor{
    if (imagesNames.count) {
        NSMutableArray * arrItems = [NSMutableArray array];
        int count = 0;
        for (NSString * name in imagesNames) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:MQ_NAV_FixedSpace];
            [arrItems addObject:negativeSpacer];
            UIImage * image = [UIImage imageNamed:name];
            if (originalColor) {
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
            UIBarButtonItem  * itemT=[[UIBarButtonItem alloc] initWithImage:image
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(rightBarButtonAction:)];
            [itemT setTag:count++];
            [arrItems addObject:itemT];

        }
        [self.navigationItem setRightBarButtonItems:arrItems animated:NO];
    }else{
        [self.navigationItem setRightBarButtonItem:nil];
    }
}

- (void)mq_addRightBarItemsWithTexts:(NSArray<NSString *> *)texts font:(UIFont *)font color:(UIColor *)color{
    if (texts.count) {
        NSMutableArray * arrItems = [NSMutableArray array];
        int count = 0;
        for (NSString * title in texts) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:MQ_NAV_FixedSpace];
            [arrItems addObject:negativeSpacer];
            
            UIBarButtonItem * itemT = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction:)];
            [itemT setTag:count++];
            [itemT setTitleTextAttributes:@{NSFontAttributeName:font?font:[UIFont mq_titleFontWithSize:mq_navBarButtonTitleFontSize()],NSForegroundColorAttributeName:color?color:[UIColor mq_navbarButtonTitleColor]} forState:UIControlStateNormal];
            [arrItems addObject:itemT];
        }
        [self.navigationItem setRightBarButtonItems:arrItems];
    }else{
        [self.navigationItem setRightBarButtonItem:nil];
    }
}

- (void)mq_addRightBarItemsWithIconFontTexts:(NSArray<NSString *> *)texts fontSize:(CGFloat)fontSize color:(UIColor *)color{
    if (texts.count) {
        NSMutableArray * arrItems = [NSMutableArray array];
        int count = 0;
        for (NSString * title in texts) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:MQ_NAV_FixedSpace];
            [arrItems addObject:negativeSpacer];
            
            UIBarButtonItem * itemT = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction:)];
            [itemT setTag:count++];
            [itemT setTitleTextAttributes:@{NSFontAttributeName:[UIFont mq_iconfontWithSize:fontSize],NSForegroundColorAttributeName:color?color:[UIColor mq_navbarButtonTitleColor]} forState:UIControlStateNormal];
            [arrItems addObject:itemT];
        }
        [self.navigationItem setRightBarButtonItems:arrItems];
    }else{
        [self.navigationItem setRightBarButtonItem:nil];
    }
}

- (void)mq_addRightBarItemWithCustomView:(UIView *)customView{
    if (customView) {
        NSMutableArray * arrItems = [NSMutableArray array];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [negativeSpacer setWidth:MQ_NAV_FixedSpace];
        [arrItems addObject:negativeSpacer];
        UIBarButtonItem * itemT = [[UIBarButtonItem alloc] initWithCustomView:customView];
        [arrItems addObject:itemT];
        [self.navigationItem setRightBarButtonItems:arrItems];
    }else{
        [self.navigationItem setRightBarButtonItem:nil];
    }
}

- (void)rightBarButtonAction:(UIBarButtonItem *)sender{
    [self mq_rightBarButtonActionsIndex:sender.tag];
}

- (void)mq_rightBarButtonActionsIndex:(NSInteger)index{
    
}



//MARK: left

- (void)mq_addLeftBarItemsWithImageNames:(NSArray<NSString *> *)imagesNames
                           originalColor:(BOOL)originalColor{
    if (imagesNames.count) {
        NSMutableArray * arrItems = [NSMutableArray array];
        int count = 0;
        for (NSString * name in imagesNames) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:MQ_NAV_FixedSpace];
            [arrItems addObject:negativeSpacer];
            UIImage * image = [UIImage imageNamed:name];
            if (originalColor) {
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
            
            UIBarButtonItem  * itemT=[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
            [itemT setTag:count++];
            [arrItems addObject:itemT];
            
        }
        [self.navigationItem setLeftBarButtonItems:arrItems animated:NO];
    }else{
        [self.navigationItem setLeftBarButtonItem:nil];
    }
}

- (void)mq_addLeftBarItemsWithTexts:(NSArray<NSString *> *)texts font:(UIFont *)font color:(UIColor *)color{
    if (texts.count) {
        NSMutableArray * arrItems = [NSMutableArray array];
        int count = 0;
        for (NSString * title in texts) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:MQ_NAV_FixedSpace];
            [arrItems addObject:negativeSpacer];
            
            UIBarButtonItem * itemT = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
            [itemT setTag:count++];
            [itemT setTitleTextAttributes:@{NSFontAttributeName:font?font:[UIFont mq_titleFontWithSize:mq_navBarButtonTitleFontSize()],NSForegroundColorAttributeName:color?color:[UIColor mq_navbarButtonTitleColor]} forState:UIControlStateNormal];
            [arrItems addObject:itemT];
        }
        [self.navigationItem setLeftBarButtonItems:arrItems];
    }else{
        [self.navigationItem setLeftBarButtonItem:nil];
    }
}

- (void)mq_addLeftBarItemsWithIconFontTexts:(NSArray<NSString *> *)texts fontSize:(CGFloat)fontSize color:(UIColor *)color{
    if (texts.count) {
        NSMutableArray * arrItems = [NSMutableArray array];
        int count = 0;
        for (NSString * title in texts) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:MQ_NAV_FixedSpace];
            [arrItems addObject:negativeSpacer];
            
            UIBarButtonItem * itemT = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
            [itemT setTag:count++];
//            [itemT setTitlePositionAdjustment:<#(UIOffset)#> forBarMetrics:<#(UIBarMetrics)#>];
            [itemT setTitleTextAttributes:@{NSFontAttributeName:[UIFont mq_iconfontWithSize:fontSize],NSForegroundColorAttributeName:color?color:[UIColor mq_navbarButtonTitleColor]} forState:UIControlStateNormal];
            [arrItems addObject:itemT];
        }
        [self.navigationItem setLeftBarButtonItems:arrItems];
    }else{
        [self.navigationItem setLeftBarButtonItem:nil];
    }
}

- (void)mq_addLeftBarItemWithCustomView:(UIView *)customView{
    if (customView) {
        NSMutableArray * arrItems = [NSMutableArray array];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [negativeSpacer setWidth:MQ_NAV_FixedSpace];
        [arrItems addObject:negativeSpacer];
        UIBarButtonItem * itemT = [[UIBarButtonItem alloc] initWithCustomView:customView];
        [arrItems addObject:itemT];
        [self.navigationItem setLeftBarButtonItems:arrItems];
    }else{
        [self.navigationItem setLeftBarButtonItem:nil];
    }
}

- (void)leftBarButtonAction:(UIBarButtonItem *)sender{
    [self mq_leftBarButtonActionsIndex:sender.tag];
}


- (void)mq_leftBarButtonActionsIndex:(NSInteger)index{
    
}

//MARK: - navbar
- (void)mq_setNavBarBackgroundColor:(UIColor *)color{
    if (color) {
        [self.navigationController.navigationBar setBarTintColor:color];
        if (color == [UIColor clearColor]) {
            [self.navigationController.navigationBar setTranslucent:true];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow"] forBarMetrics:UIBarMetricsCompact];
        }else{
            [self.navigationController.navigationBar setTranslucent:false];
        }
    }
}


- (void)mq_setNavBarSubViewsColor:(UIColor *)color{
    if (color) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                               NSForegroundColorAttributeName:
                                                                   color,
                                                               NSFontAttributeName:
                                                                   [UIFont systemFontOfSize:
                                                                    mq_navBarTitleFontSize()]
                                                               }];
        [self.navigationController.navigationBar setTintColor:color];
    }
}

- (void)mq_setNavBarTitleColor:(UIColor *)color{
    if (color) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                               NSForegroundColorAttributeName:
                                                                   color,
                                                               NSFontAttributeName:
                                                                   [UIFont systemFontOfSize:
                                                                    mq_navBarTitleFontSize()]
                                                               }];
    }
}


- (void)mq_setNavBarBackButtonImage:(UIImage *)image{
    if (image) {
        [self.navigationController.navigationBar setBackIndicatorImage:image];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image];
    }
}


- (void)mq_popToViewControllerwithClassName:(NSString *)className animated:(BOOL)animated{
    if (self.navigationController) {
        NSArray<UIViewController *> * arrVCS = [self.navigationController viewControllers];
        if (arrVCS && arrVCS.count) {
            UIViewController * fVC = nil;
            for (UIViewController * vc in arrVCS) {
                if ([vc isKindOfClass:NSClassFromString(className)]) {
                    fVC = vc;
                    break;
                }
            }
            if (fVC) {
                [self.navigationController popToViewController:fVC animated:animated];
            }
        }
    }
}



@end
