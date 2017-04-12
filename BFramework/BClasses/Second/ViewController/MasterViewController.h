//
//  MasterViewController.h
//  BFramework
//
//  Created by 120v on 2017/4/12.
//  Copyright © 2017年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (nonatomic, strong) DetailViewController *detailVC;

@end
