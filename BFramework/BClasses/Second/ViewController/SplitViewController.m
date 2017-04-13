//
//  SplitViewController.m
//  BFramework
//
//  Created by 120v on 2017/4/12.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "SplitViewController.h"
#import "DetailViewController.h"

@interface SplitViewController ()<UISplitViewControllerDelegate>

@end

@implementation SplitViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController{
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]]) {
        return YES;
    } else {
        return NO;
    }
}





@end
