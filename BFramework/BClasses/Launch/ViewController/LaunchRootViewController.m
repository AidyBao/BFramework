//
//  LaunchRootViewController.m
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "LaunchRootViewController.h"

@interface LaunchRootViewController ()
@property (weak, nonatomic) IBOutlet UIButton *toMainButton;

@end

@implementation LaunchRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    
}

- (IBAction)toMainUI:(id)sender {
    [MQRouter changeRootViewController:[MQRootViewControllers mq_tabbarController]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
