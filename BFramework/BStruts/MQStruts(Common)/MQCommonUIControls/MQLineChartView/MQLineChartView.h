//
//  MQLineChartView.h
//  TestChart
//
//  Created by JuanFelix on 2017/1/11.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLineChartView;
@protocol MQLineChartViewDelegate <NSObject>

@optional
- (void)mqLineChartViewSelectedAtIndex:(NSInteger)index lineChartView:(MQLineChartView *)lineChartView;
- (void)mqLineChartViewAnimationEnd:(MQLineChartView *)lineChartView;

@end

@interface MQLineChartView : UIView

/** 值*/
@property (nonatomic,strong) NSArray<NSNumber *> * arrValues;

/** 横坐标*/
@property (nonatomic,strong) NSArray<NSString *> * arrDays;

/** 起始点值，defaul nil , 绘图是默认Y值在中间*/
@property (nonatomic,copy) NSString * preValue;

@property (nonatomic,weak) id<MQLineChartViewDelegate> delegate;

/** 设置原点*/
- (instancetype)initWithOrigin:(CGPoint)pOrigin;

/** 默认选中点*/
- (void)selectedAtIndex:(NSInteger)index;

/** 子标题*/
- (void)setDateInfo:(NSString *)strInfo;

@end
