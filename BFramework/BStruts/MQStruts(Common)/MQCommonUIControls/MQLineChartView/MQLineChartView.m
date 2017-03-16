//
//  MQLineChartView.m
//  TestChart
//
//  Created by JuanFelix on 2017/1/11.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "MQLineChartView.h"
#define MQLINE_TOP_OFFSET       70
#define MQCHART_HEIGHT          310
#define MQLINE_CONTENT_HEIGHT   200
#define MQCHART_WIDTH           [UIScreen mainScreen].bounds.size.width
#define MQ_MASK_COLOR           [UIColor colorWithRed:79 / 255.0 green:142 / 255.0 blue:229 / 255.0 alpha:0.2]
#define MQ_LINE_COLOR           [UIColor colorWithRed:59 / 255.0 green:135 / 255.0 blue:239 / 255.0 alpha:1.0]
#define MQ_BACKGROUND_COLOR     [UIColor colorWithRed:242 / 255.0 green:247 / 255.0 blue:253 / 255.0 alpha:1.0]

@interface MQLineChartView ()
{
    CGFloat MQLINE_MARGIN;
    NSInteger highLightIndex;
    BOOL isAnimationEnd;
}

@property (nonatomic,strong) UILabel * lbUnitsInfo;
@property (nonatomic,strong) UILabel * lbDateZone;
@property (nonatomic,assign) int        maxYValue;
@property (nonatomic,assign) float      floatMaxY;
@property (nonatomic,strong) NSMutableArray<UILabel *> * yLabels;
@property (nonatomic,strong) NSMutableArray<UILabel *> * xLabels;
@property (nonatomic,strong) NSMutableArray<NSValue *> * dataValuePoints;

@property (nonatomic,strong) CALayer      * chartContentLayer;
@property (nonatomic,strong) CAShapeLayer * lineLayer;//线
@property (nonatomic,strong) CALayer      * chartFillColorLayer;//填充颜色
@property (nonatomic,strong) CAShapeLayer * chartFillColorMaskLayer;//填充颜色轨迹
@property (nonatomic,strong) CALayer      * dotsContentLayer;
@property (nonatomic,strong) NSMutableArray<CAShapeLayer * > * dotLayers;//点
@property (nonatomic,strong) CAShapeLayer * animationMaskLayer;
@property (nonatomic,strong) CAShapeLayer * animationLayer;

@property (nonatomic,strong) UIView  * popView;
@property (nonatomic,strong) UILabel * popLabel;

@end

@implementation MQLineChartView

- (instancetype)initWithOrigin:(CGPoint)pOrigin{
    if (self = [super initWithFrame:CGRectMake(pOrigin.x, pOrigin.y + 100, MQCHART_WIDTH, MQCHART_HEIGHT)]) {
        _floatMaxY = 0;
        highLightIndex = 0;
        isAnimationEnd = false;
        self.lbUnitsInfo = [[UILabel alloc] initWithFrame:CGRectMake(14, 14, MQCHART_WIDTH - 28, 24)];
        [self.lbUnitsInfo setBackgroundColor:[UIColor clearColor]];
        [self.lbUnitsInfo setTextColor:[UIColor blackColor]];
        [self.lbUnitsInfo setFont:[UIFont systemFontOfSize:17]];
        [self.lbUnitsInfo setText:@"标题"];
        [self addSubview:self.lbUnitsInfo];
        
        self.lbDateZone = [[UILabel alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(self.lbUnitsInfo.frame), MQCHART_WIDTH - 28, 22)];
        [self.lbDateZone setTextColor:[UIColor lightGrayColor]];
        [self.lbDateZone setFont:[UIFont systemFontOfSize:13.0]];
        [self.lbDateZone setBackgroundColor:[UIColor clearColor]];
        [self.lbDateZone setText:@"123456"];
        [self addSubview:self.lbDateZone];
        [self setBackgroundColor:MQ_BACKGROUND_COLOR];
        
        [self.layer addSublayer:self.chartContentLayer];
        [self buildLineLayer];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 215 / 255.0, 230 / 255.0, 230 / 255.0, 0.5);
    CGContextSetShouldAntialias(context, NO);
    CGContextSetLineWidth(context, .5);
    for (int i = 0; i < 4; i++) {
        CGContextMoveToPoint(context,0, MQLINE_TOP_OFFSET + (MQLINE_CONTENT_HEIGHT / 4) * i);
        CGContextAddLineToPoint(context,MQCHART_WIDTH, MQLINE_TOP_OFFSET + (MQLINE_CONTENT_HEIGHT / 4) * i);
    }
    CGContextStrokePath(context);
}

//MARK: - 金额
- (void)setArrValues:(NSArray<NSNumber *> *)values{
    [self reloadData];
    _arrValues = values;
    if (_arrValues && _arrValues.count) {
        MQLINE_MARGIN = MQCHART_WIDTH / _arrValues.count / 2;
    }else{
        MQLINE_MARGIN = 30;
    }
    [self buildYLables];
    [self buildLineLayer];
    [self dotLayers];
}

//MARK: - Y 值
- (void)buildYLables{
    if (_yLabels && _yLabels.count) {
        [_yLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_yLabels removeAllObjects];
        _yLabels = nil;
    }
    int max = [self maxYValue];
    _yLabels = [NSMutableArray array];
    for (int count = 4; count > 0; count --) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(14, MQLINE_TOP_OFFSET + (MQLINE_CONTENT_HEIGHT / 4) * (4 - count), 60, 22)];
        [label setFont:[UIFont systemFontOfSize:12.0]];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setTextColor:[UIColor lightGrayColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        NSString * strV = nil;
        if (max <= 1) {
            if (_floatMaxY > 0) {
                CGFloat tempF = [self maxYLess1FloatValue:_floatMaxY];
                strV = [NSString stringWithFormat:@"%0.2f",count * (tempF / 4.0)];
                if (tempF < 0.1) {
                    strV = [NSString stringWithFormat:@"%0.3f",count * (tempF / 4.0)];
                    if (strV && strV.length) {
                        NSString * strMxF = [NSString stringWithFormat:@"%0.3f",tempF];
                        NSString * trailZero = [strMxF substringWithRange:NSMakeRange(strMxF.length - 1, 1)];
                        if ([trailZero intValue] == 0) {
                            //去除小数点之前
                            NSString * tempV = [strMxF substringWithRange:NSMakeRange(2, strMxF.length - 3)];
                            int  value = [tempV intValue];
                            if (value % 4 == 0) {//最大值能被4整除 末尾不带0
                                strV = [NSString stringWithFormat:@"%0.2f",count * (tempF / 4.0)];
                            }
                        }
                    }
                }
            }else{
                strV = [NSString stringWithFormat:@"%0.2f",count * (1.0 / 4.0)];
            }
        }else{
            strV = [NSString stringWithFormat:@"%@",@(count * (max / 4))];
        }
        
        [label setText:strV];
        [self addSubview:label];
        [_yLabels addObject:label];
    }
}
//MARK: - 日期
- (void)setArrDays:(NSArray<NSString *> *)days{
    _arrDays = days;
    [self buildXLables];
}

//MARK: X 值
- (void)buildXLables{
    if (_xLabels && _xLabels.count) {
        [_xLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_xLabels removeAllObjects];
        _xLabels = nil;
    }
    _xLabels = [NSMutableArray array];
    NSInteger count = self.arrDays.count;
    if (count > 0) {
        CGFloat width = MQCHART_WIDTH / count;
        for (int i = 0; i < count; i ++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(width * i, MQLINE_CONTENT_HEIGHT + MQLINE_TOP_OFFSET, width, 40)];
            [label setFont:[UIFont systemFontOfSize:13.0]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor lightGrayColor]];
            [label setHighlightedTextColor:MQ_LINE_COLOR];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setText:[self.arrDays objectAtIndex:i]];
            [self addSubview:label];
            [_xLabels addObject:label];
        }
    }
}
//MARK: - Y 轴最大值
- (int)maxYValue{
    if (_maxYValue <= 0) {
        if (_arrValues && _arrValues.count) {
            NSArray <NSNumber *> * sortedNum = [_arrValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                NSNumber *tNumber1 = (NSNumber *)obj1;
                NSNumber *tNumber2 = (NSNumber *)obj2;
                if ([tNumber1 floatValue] < [tNumber2 floatValue])
                    return NSOrderedDescending;
                return NSOrderedAscending;
            }];
            NSNumber * max = [sortedNum firstObject];
            if ([max floatValue] <= [self.preValue floatValue]) {
                max = [NSNumber numberWithFloat:[self.preValue floatValue]];
            }
            _floatMaxY = [max floatValue];
            float fMax = ceilf([max floatValue]);
            _maxYValue = [self min4_10TimesNum:fMax];
        }else{
            _maxYValue = 20;
        }
    }
    return _maxYValue;
}

//#error - 调整
- (float)maxYLess1FloatValue:(float)floatValue{//Y最大值小于1
    if (floatValue <= 0.01) {
        return 0.01;
    }
    int num = (int)(floatValue * 10000);
    num = (int)(ceil(num / 100.0));
    if (num == 10) {
        return 0.1;
    }else if (num < 10) {
        for (; num < 10 ; num++) {
            if (num % 2 == 0) {
                break;
            }
        }
        return num / 100.0;
    }
    return [self min4_10TimesNum:floatValue * 100] / 100.0;
    /*
    int num = (int)(floatValue * 100);
    if (num <= 1) {
        return 0.01;
    }
    for (; num < 100 ; num++) {
        if (num % 2 == 0) {
            break;
        }
    }
    return num / 100.0;
     */
}

- (int)min4_10TimesNum:(float)fx{
    int max = fx;
    int num = (int)fx;
    if (fx <= 1) {
        return 1;
    }
    
    for (; num < 10000000 ; num++) {
        if (num % 4 == 0) {
            if (max < 10 ) {
                break;
            }else{
                if (num % 10 == 0) {
                    break;
                }
            }
        }
    }
    return num;
}

//MARK: - LineLayer
- (void)buildLineLayer{
    NSMutableArray<NSValue *> * points = [self buildValuePoints];
    if (points && points.count) {
        //MaskPath
        UIBezierPath * maskPath = [UIBezierPath bezierPath];
        NSMutableArray<NSValue *> * maskPoints = [self getMaskLayerPoints];
        if (maskPoints && maskPoints.count) {
            [maskPoints enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    [maskPath moveToPoint:[obj CGPointValue]];
                }else{
                    [maskPath addLineToPoint:[obj CGPointValue]];
                }
            }];
            [maskPath closePath];
        }else{
            maskPath = [UIBezierPath bezierPathWithRect:CGRectZero];
        }
        [self.chartFillColorMaskLayer setPath:maskPath.CGPath];
        [self.chartFillColorMaskLayer setPosition:CGPointMake(0, -MQLINE_TOP_OFFSET)];
        
        //LinePath
        UIBezierPath * linePath = [UIBezierPath bezierPath];
        [points enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                [linePath moveToPoint:[obj CGPointValue]];
            }else{
                [linePath addLineToPoint:[obj CGPointValue]];
            }
        }];
        [self.lineLayer setPath:linePath.CGPath];
    }else{
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRect:CGRectZero];
        self.chartFillColorMaskLayer.strokeColor = [UIColor clearColor].CGColor;
        [self.chartFillColorMaskLayer setPath:maskPath.CGPath];
    }
    
    //Animation
    [self startLineandFillColorAnimation];
}

//MARK: - Start Animation
- (void)startLineandFillColorAnimation{
    //NSLog(@"startLineandFillColorAnimation");
    isAnimationEnd = false;
    [self.animationLayer setPosition:CGPointMake(-MQCHART_WIDTH, 0)];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-MQCHART_WIDTH, 0)];
    animation.toValue   = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.duration  = 0.75;
    animation.fillMode  = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.animationLayer addAnimation:animation forKey:@"LineAndFillColor"];
    [self performSelector:@selector(startDotAnimation) withObject:nil afterDelay:0.75];
}

- (void)startDotAnimation{
    [_chartContentLayer addSublayer:self.dotsContentLayer];
    //NSLog(@"startDotAnimation");
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(0);
    animation.toValue   = @(1);
    animation.duration  = 0.4;
    animation.fillMode  = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.dotsContentLayer addAnimation:animation forKey:@"DotsSunRise"];
    [self performSelector:@selector(startPopOverViewAnimiation) withObject:nil afterDelay:0.3];
}

- (void)startPopOverViewAnimiation{
    isAnimationEnd = true;
    [self selectedAtIndex:highLightIndex];
    if (_delegate && [_delegate respondsToSelector:@selector(mqLineChartViewAnimationEnd:)]) {
        [_delegate mqLineChartViewAnimationEnd:self];
    }
}

//MARK: - 金额 坐标点
- (NSMutableArray<NSValue *> *)dataValuePoints{
    if (!_dataValuePoints) {
        if (self.arrValues && self.arrValues.count) {
            _dataValuePoints = [NSMutableArray array];
            __weak typeof(self) weakSelf = self;
            [self.arrValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_dataValuePoints addObject:[NSValue valueWithCGPoint:[weakSelf calculatePointByValue:obj withIndex:idx]]];
            }];
        }
    }
    
    return _dataValuePoints;
}

//MARK: - 折线图轨迹点
- (NSMutableArray<NSValue *> *)buildValuePoints{
    NSMutableArray <NSValue *> * points = [[self dataValuePoints] mutableCopy];
    if (points && points.count) {
        //插入前一天
        [points insertObject:[self prePoint] atIndex:0];
        //插入最后一天趋势
        NSValue * futurePoint = [self getFuturePoint];
        if (futurePoint) {
            [points addObject:futurePoint];
        }
    }
    return points;
}

- (NSValue *)prePoint{
    if (self.preValue && [self.preValue respondsToSelector:@selector(length)]) {
        int max = [self maxYValue];
        
//        CGFloat y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [self.preValue floatValue] / (CGFloat)max);
        CGFloat y = 0;
        if (max <= 1) {
            if (_floatMaxY > 0) {
                CGFloat tempF = [self maxYLess1FloatValue:_floatMaxY];
                y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [self.preValue floatValue] / tempF);
            }else{
                y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [self.preValue floatValue] / 1.0);
            }
        }else{
            y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [self.preValue floatValue] / (CGFloat)max);
        }
        
        return [NSValue valueWithCGPoint:CGPointMake(0, y)];
    }
    return [NSValue valueWithCGPoint:CGPointMake(0, MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT / 2)];
}

//MARK: - Mask轨迹
- (NSMutableArray<NSValue *> *)getMaskLayerPoints{
    NSMutableArray <NSValue *> * points = [[self buildValuePoints] mutableCopy];
    if (points && points.count) {
        [points insertObject:[NSValue valueWithCGPoint:CGPointMake(0, MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT)] atIndex:0];
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(MQCHART_WIDTH, MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT)] ];
    }
    return points;
}

- (NSValue *)getFuturePoint{
    if (self.arrValues && self.arrValues.count) {
        NSMutableArray <NSValue *> * points = [[self dataValuePoints] mutableCopy];
        if (points.count == 1) {
            CGPoint pnt = [points.firstObject CGPointValue];
            pnt.x = MQCHART_WIDTH;
            pnt.y -= 2;
            if (pnt.y < MQLINE_TOP_OFFSET) {
                pnt.y = MQLINE_TOP_OFFSET;
            }
            return [NSValue valueWithCGPoint:pnt];
        }else{
            CGPoint pnt1 = [points.lastObject CGPointValue];
            CGPoint pnt2 = [points[points.count - 2] CGPointValue];
            CGFloat ratio = fabs(pnt1.y - pnt2.y) / 2.0;
            if (pnt1.y < pnt2.y) { //高
                pnt1.y -= ratio; //趋势变缓
                if (pnt1.y < MQLINE_TOP_OFFSET) {
                    pnt1.y = MQLINE_TOP_OFFSET;
                }
            }else{
                pnt1.y += ratio;//趋势变缓
                if (pnt1.y > MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT) {
                    pnt1.y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT;
                }
            }
            pnt1.x = MQCHART_WIDTH;
            return [NSValue valueWithCGPoint:pnt1];
        }
    }
    return nil;
}

- (CGPoint)calculatePointByValue:(NSNumber *)value withIndex:(NSInteger)index{
    int max = [self maxYValue];
    CGFloat x = MQLINE_MARGIN;
    if (index != 0) {
        x += index * (MQCHART_WIDTH - 2 * MQLINE_MARGIN) / (self.arrValues.count - 1);
    }
//    CGFloat y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [value floatValue] / (CGFloat)max);
     CGFloat y = 0;
    if (max <= 1) {
        if (_floatMaxY > 0) {
            CGFloat tempF = [self maxYLess1FloatValue:_floatMaxY];
            y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [value floatValue] / tempF);
        }else{
            y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [value floatValue] / 1.0);
        }
    }else{
        y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [value floatValue] / (CGFloat)max);
    }
    
//    CGFloat y = MQLINE_TOP_OFFSET + MQLINE_CONTENT_HEIGHT * (1 - [value floatValue] / (CGFloat)max);
    return CGPointMake(x, y);
}



//MARK: - 绘图背景层 用于Animation
- (CALayer *)chartContentLayer{
    if (!_chartContentLayer) {
        _chartContentLayer = [CALayer layer];
        _chartContentLayer.frame = CGRectMake(0, 0, MQCHART_WIDTH, MQLINE_CONTENT_HEIGHT + MQLINE_TOP_OFFSET);
        _chartContentLayer.backgroundColor = [UIColor clearColor].CGColor;
        [_chartContentLayer addSublayer:self.chartFillColorLayer];
        [_chartContentLayer addSublayer:self.lineLayer];
        [_chartContentLayer addSublayer:self.dotsContentLayer];
        [_chartContentLayer setMask:self.animationMaskLayer];
    }
    return _chartContentLayer;
}

//MARK: - 折线图层
- (CALayer *)chartFillColorLayer{
    if (!_chartFillColorLayer) {
        _chartFillColorLayer = [CALayer layer];
        _chartFillColorLayer.frame = CGRectMake(0, MQLINE_TOP_OFFSET, MQCHART_WIDTH, MQLINE_CONTENT_HEIGHT);
        _chartFillColorLayer.backgroundColor = MQ_MASK_COLOR.CGColor;
        _chartFillColorLayer.mask  = self.chartFillColorMaskLayer;

    }
    return _chartFillColorLayer;
}

//MARK: - 用于裁剪折线图背景
- (CAShapeLayer *)chartFillColorMaskLayer{
    if (!_chartFillColorMaskLayer) {
        _chartFillColorMaskLayer = [CAShapeLayer layer];
    }
    return _chartFillColorMaskLayer;
}

//MARK: - 折线图轨迹
- (CAShapeLayer *)lineLayer{
    if (!_lineLayer) {
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.lineWidth = 1.0;
        _lineLayer.strokeColor = MQ_LINE_COLOR.CGColor;
        _lineLayer.fillColor   = [UIColor clearColor].CGColor;;
    }
    return _lineLayer;
}

//MARK: AnimationLayer
- (CAShapeLayer *)animationMaskLayer{
    if (!_animationMaskLayer) {
        _animationMaskLayer = [CAShapeLayer layer];
        [_animationMaskLayer addSublayer:self.animationLayer];
    }
    return _animationMaskLayer;
}

- (CAShapeLayer *)animationLayer{
    if (!_animationLayer) {
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, MQCHART_WIDTH, MQLINE_CONTENT_HEIGHT + MQLINE_TOP_OFFSET)].CGPath;
        _animationLayer.position = CGPointMake(-MQCHART_WIDTH, 0);
    }
    return _animationLayer;
}



//MARK: - 点
- (CALayer *)dotsContentLayer{
    if (!_dotsContentLayer) {
        _dotsContentLayer = [CALayer layer];
        _dotsContentLayer.frame = CGRectMake(0, 0, MQCHART_WIDTH, MQLINE_CONTENT_HEIGHT + MQLINE_TOP_OFFSET);
        _dotsContentLayer.opacity = 0;
        _dotsContentLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _dotsContentLayer;
}
- (NSMutableArray<CAShapeLayer *> *)dotLayers{
    if (!_dotLayers) {
        _dotLayers = [NSMutableArray array];
        NSMutableArray <NSValue *> * points = [[self dataValuePoints] mutableCopy];
        if (points && points.count) {
            [points enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CAShapeLayer * dotLayer = [CAShapeLayer layer];
                dotLayer.lineWidth   = 1.0;
                dotLayer.strokeColor = MQ_LINE_COLOR.CGColor;
                dotLayer.fillColor   = [UIColor whiteColor].CGColor;
                UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:[obj CGPointValue] radius:3 startAngle:0 endAngle:2 * M_PI clockwise:true];
                dotLayer.path = path.CGPath;
                [self.dotsContentLayer addSublayer:dotLayer];
                [_dotLayers addObject:dotLayer];
            }];
        }
    }
    return  _dotLayers;
}

- (void)setDateInfo:(NSString *)strInfo{
    [self.lbDateZone setText:strInfo];
}

//MARK: - Reload
- (void)reloadData{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startDotAnimation) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startPopOverViewAnimiation) object:nil];
    [self.dotsContentLayer removeAnimationForKey:@"DotsSunRise"];
    [self.animationLayer removeAnimationForKey:@"LineAndFillColor"];
    
    [self.popView removeFromSuperview];
    [self.dotsContentLayer removeFromSuperlayer];
    self.dotsContentLayer.opacity = 0.0;
    self.animationLayer.position = CGPointMake(-MQCHART_WIDTH, 0);
    highLightIndex = 0;
    _maxYValue = 0;
    if (_dataValuePoints) {
        [_dataValuePoints removeAllObjects];
        _dataValuePoints = nil;
    }
    [self clearDotLayers];
}

- (void)clearDotLayers{
    if (_dotLayers && _dotLayers.count) {
        [_dotLayers enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperlayer];
        }];
        [_dotLayers removeAllObjects];
        _dotLayers = nil;
    }
}

//MARK: - 点击点
- (void)selectedAtIndex:(NSInteger)index{
    if (self.arrValues && _arrValues.count) {
        if (index <= 0 ) {
            index = 0;
        }
        if ( index > (_arrValues.count - 1)) {
            index = _arrValues.count - 1;
        }
        if (!isAnimationEnd) {
            highLightIndex = index;
            return;
        }
        UILabel * lastLabel = [self.xLabels objectAtIndex:highLightIndex];
        [lastLabel setHighlighted:false];
        [[self.xLabels objectAtIndex:index] setHighlighted:true];
        highLightIndex = index;
        [self showPopViewWithIndex:index];
    }
}


//MARK: PopOver View
- (void)showPopViewWithIndex:(NSInteger)index{
    if (self.arrValues && _arrValues.count) {
        [self addSubview:self.popView];
        [self bringSubviewToFront:self.popView];
        NSNumber * num = [self.arrValues objectAtIndex:index];
         NSString * numStr = [NSString stringWithFormat:@"%@",num];
//        NSString * numStr = [NSString stringWithFormat:@"%0.2f",[num floatValue]];
//        int max = [self maxYValue];
//        if (max <= 1) {
//            if (_floatMaxY > 0) {
//                CGFloat tempF = [self maxYLess1FloatValue:_floatMaxY];
//                if (tempF < 0.1) {
//                    numStr = [NSString stringWithFormat:@"%0.3f",[num floatValue]];
//                    if (numStr && numStr.length) {
//                        NSString * trailZero = [numStr substringWithRange:NSMakeRange(numStr.length - 1, 1)];
//                        if ([trailZero intValue] == 0) {
//                            numStr = [NSString stringWithFormat:@"%0.2f",[num floatValue]];
//                        }
//                    }
//                }
//            }
//        }

        [self.popLabel setText:numStr];
        
        CGSize textSize = [self caculateStringSizeWithString:numStr font:self.popLabel.font limitSize:CGSizeMake(200, 20)];
        textSize.width += 16;
        self.popLabel.frame = CGRectMake(0, 0, textSize.width, 20);
        self.popView.frame  = CGRectMake(0, 0, textSize.width, 26);
        CGPoint pnt = [[[self dataValuePoints] objectAtIndex:index] CGPointValue];
        CAShapeLayer * popviewMask = [CAShapeLayer layer];
        popviewMask.path = [self popviewMaskPath:self.popView.frame];
        self.popView.layer.mask = popviewMask;
        
//        self.popView.center = CGPointMake(pnt.x, pnt.y - 20);
        //
        CGPoint startCenter = CGPointMake(pnt.x, pnt.y);
        CGPoint endCenter   = CGPointMake(pnt.x, pnt.y - 20);
        self.popView.alpha  = 0;
        self.popView.center = startCenter;
        [UIView animateWithDuration:0.25 animations:^{
            self.popView.alpha  = 1.0;
            self.popView.center = endCenter;
        }];
        
    }else{
        [self.popView removeFromSuperview];
    }
}

- (CGPathRef)popviewMaskPath:(CGRect)rect{
    UIBezierPath * path = [UIBezierPath bezierPath];
    CGFloat beginX = 10;
    CGFloat rRatio = rect.size.height - 20;
    [path moveToPoint:CGPointMake(beginX, 0)];
    [path addLineToPoint:CGPointMake(rect.size.width - beginX, 0)];
    [path addArcWithCenter:CGPointMake(rect.size.width - beginX, 10) radius:10 startAngle:- M_PI / 2 endAngle:M_PI / 2 clockwise:true];
    [path addLineToPoint:CGPointMake(rect.size.width / 2 + rRatio, 20)];
    [path addArcWithCenter:CGPointMake(rect.size.width / 2 + rRatio, rect.size.height) radius:rRatio startAngle:- M_PI / 2 endAngle:M_PI clockwise:false];
    [path addArcWithCenter:CGPointMake(rect.size.width / 2 - rRatio, rect.size.height) radius:rRatio startAngle:0 endAngle:- M_PI / 2 clockwise:false];
    [path addLineToPoint:CGPointMake(beginX, 20)];
    [path addArcWithCenter:CGPointMake(beginX, 10) radius:10 startAngle:M_PI / 2 endAngle:3 * M_PI / 2 clockwise:true];
    [path closePath];
    return path.CGPath;
}

- (UIView *)popView{
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectZero];
        [_popView setBackgroundColor:MQ_LINE_COLOR];
    }
    return _popView;
}

- (UILabel *)popLabel{
    if (!_popLabel) {
        _popLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_popLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_popLabel setTextColor:[UIColor whiteColor]];
        [_popLabel setTextAlignment:NSTextAlignmentCenter];
        [_popLabel setBackgroundColor:[UIColor clearColor]];
        [self.popView addSubview:_popLabel];
    }
    return _popLabel;
}

//MARK: - Touch Began
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchKeyPoint:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchKeyPoint:touches withEvent:event];
}

- (void)touchKeyPoint:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSMutableArray <NSValue *> * points = [self dataValuePoints];
    if (points) {
        if (points.count > 1) {
            for (int i = 0; i < (int) points.count - 1; i += 1) {
                CGPoint p1 = [points[i] CGPointValue];
                CGPoint p2 = [points[i + 1] CGPointValue];
                float distanceToP1 = fabs(hypot(touchPoint.x - p1.x, touchPoint.y - p1.y));
                float distanceToP2 = hypot(touchPoint.x - p2.x, touchPoint.y - p2.y);
                float distance = MIN(distanceToP1, distanceToP2);
                if (distance <= 20.0) { // 点 周围 20pnt内点击有效
                    NSInteger index = (distance == distanceToP2 ? i + 1 : i);
                    [self selectedAtIndex:index];
                    if (_delegate && [_delegate respondsToSelector:@selector(mqLineChartViewSelectedAtIndex:lineChartView:)]) {
                        [_delegate mqLineChartViewSelectedAtIndex:index lineChartView:self];
                    }
                    break;
                }
            }
        }else{
            CGPoint p1 = [[points firstObject] CGPointValue];
            float distance = fabs(hypot(touchPoint.x - p1.x, touchPoint.y - p1.y));
            if (distance <= 20.0) { // 点 周围 20pnt内点击有效
                [self selectedAtIndex:0];
                if (_delegate && [_delegate respondsToSelector:@selector(mqLineChartViewSelectedAtIndex:lineChartView:)]) {
                    [_delegate mqLineChartViewSelectedAtIndex:0 lineChartView:self];
                }
            }
        }
    }
}

- (CGSize)caculateStringSizeWithString:(NSString *)string
                                  font:(UIFont *)font
                             limitSize:(CGSize)limitSize{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize textSize = [string boundingRectWithSize:limitSize
                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                        attributes:attribute context:nil].size;
    return textSize;
}

@end
