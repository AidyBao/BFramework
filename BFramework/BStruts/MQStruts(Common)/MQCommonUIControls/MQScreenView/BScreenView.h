//
//  BScreenView.h
//  SubWayWifi
//
//  Created by bao_aidy on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BScreenView;

@protocol BScreenViewDelegate <NSObject>

-(void)BScreenViewButtonAction:(UIButton *)sender withCatcode:(NSInteger)catCode withScreenFlag:(NSInteger)flag;

@end

@interface BScreenView : UIView

@property(nonatomic,weak) id <BScreenViewDelegate> delegate;
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,copy) NSString *categoryTitle;

@end


