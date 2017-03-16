//
//  MQNoDataView.m
//  YDHYK
//
//  JuanFelix on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQEmptyView.h"
#import <Masonry/Masonry.h>
#import "MQCommonEngine.h"

#define MQ_IMAGE_NODATA    @"MQNoData"
#define MQ_IMAGE_NONETWORK @"MQNoNetwork"


typedef enum : NSUInteger {
    HEmptyTypeNoData,    //无数据空白界面
    HEmptyTypeNoNetwork  //网络连接错误界面
} HEmptyType;

@interface MQEmptyView ()
{
    UIImageView  * imgIcon;
    UILabel      * lbInfo1;
    UILabel      * lbInfo2;
    MQTintButton * btnAcion;
}

@property (nonatomic,assign) HEmptyType   currentType;;

@property (nonatomic,copy)   MQRCallBack  callBack;;

@end

@implementation MQEmptyView

+ (MQEmptyView *)emptyViewForView:(UIView *)view{
    if (view) {
        MQEmptyView * eView = nil;
        for (id aView in [view subviews]) {
            if ([aView isKindOfClass:[MQEmptyView class]]) {
                eView = aView;
                break;
            }
        }
        return eView;
    }
    return nil;
}

+ (void)showNoDataInView:(UIView *)view text1:(NSString *)text1 text2:(NSString *)text2 heightFix:(CGFloat)heightFix{
    if (view) {
        MQEmptyView * emptyView = [self emptyViewForView:view];
        if (emptyView && emptyView.currentType != HEmptyTypeNoData) {
            [emptyView removeFromSuperview];
            emptyView = nil;
        }
        if (!emptyView) {
            emptyView = [[MQEmptyView alloc] init];
//            emptyView = [[MQEmptyView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height + heightFix)];
        }
        [view addSubview:emptyView];
        [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(view);
            make.height.equalTo(@(view.height + heightFix));
            if ([view isKindOfClass:[UIScrollView class]]) {
                make.width.equalTo(@(MQ_BOUNDS_WIDTH));
            }else{
                make.right.equalTo(view);
            }
        }];

        
        [emptyView setEmptyViewType:HEmptyTypeNoData];
        [emptyView setText1WithText:text1];
        [emptyView setText2WithText:text2];
    }
}

+ (void)showNetworkErrorInView:(UIView *)view heightFix:(CGFloat)heightFix refreshAction:(MQRCallBack)refreshAction{
    if (view) {
        MQEmptyView * emptyView = [self emptyViewForView:view];
        if (emptyView && emptyView.currentType != HEmptyTypeNoNetwork) {
            [emptyView removeFromSuperview];
            emptyView = nil;
        }
        if (!emptyView) {
            emptyView = [[MQEmptyView alloc] init];
            //emptyView = [[MQEmptyView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height + heightFix)];
        }
        [view addSubview:emptyView];
        
        [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(view);
            make.height.equalTo(@(view.height + heightFix));
            if ([view isKindOfClass:[UIScrollView class]]) {
                make.width.equalTo(@(MQ_BOUNDS_WIDTH));
            }else{
                make.right.equalTo(view);
            }
        }];
        
        [emptyView setEmptyViewType:HEmptyTypeNoNetwork];
        [emptyView setText1WithText:@"访问数据失败"];
        [emptyView setText2WithText:@"请检查网络或刷新"];
        emptyView.callBack = refreshAction;
    }
}


//- (instancetype)initWithFrame:(CGRect)frame
- (instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor mq_assistColor]];
        
        imgIcon = [[UIImageView alloc] init];
        [imgIcon setContentMode:UIViewContentModeScaleAspectFit];
        lbInfo1 = [[UILabel alloc] init];
        [lbInfo1 setTextAlignment:NSTextAlignmentCenter];
        lbInfo2 = [[UILabel alloc] init];
        [lbInfo2 setTextAlignment:NSTextAlignmentCenter];
        btnAcion = [[MQTintButton alloc] init];
//        [btnAcion addTarget:self action:@selector(buttonActionCallBack) forControlEvents:UIControlEventTouchUpInside];
        [btnAcion.layer setCornerRadius:5];
        [btnAcion setTitle:@"刷新" forState:UIControlStateNormal];
        
        [self addSubview:imgIcon];
        [self addSubview:lbInfo1];
        [self addSubview:lbInfo2];
        [self addSubview:btnAcion];
    }
    return self;
}

- (void)buttonActionCallBack{
    if (self.callBack) {
        self.callBack();
    }
}

- (void)setEmptyViewType:(HEmptyType)type{
    _currentType = type;
    if (type == HEmptyTypeNoData) {
        [imgIcon setImage:[UIImage imageNamed:MQ_IMAGE_NODATA]];
        [lbInfo1 setFont:[UIFont mq_titleFontWithSize:14]];
        [lbInfo1 setTextColor:[UIColor mq_sub2TextColor]];
        [lbInfo2 setFont:[UIFont mq_titleFontWithSize:14]];
        [lbInfo2 setTextColor:[UIColor mq_sub2TextColor]];
        
        [imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(40));
            make.width.equalTo(@(150));
            make.height.equalTo(@(130));
            make.centerX.equalTo(self);
        }];
        
        [lbInfo1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(20));
            make.right.equalTo(@(-20));
            make.top.equalTo(imgIcon.mas_bottom).offset(20);
            make.height.equalTo(@(24));
        }];
        [lbInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(20));
            make.right.equalTo(@(-20));
            make.top.equalTo(lbInfo1.mas_bottom);
            make.height.equalTo(@(24));
        }];
        [btnAcion setHidden:true];
    }else if(type == HEmptyTypeNoNetwork){
        [imgIcon setImage:[UIImage imageNamed:MQ_IMAGE_NONETWORK]];
        [lbInfo1 setFont:[UIFont mq_titleFontWithSize:17]];
        [lbInfo1 setTextColor:[UIColor mq_textColor]];
        [lbInfo2 setFont:[UIFont mq_titleFontWithSize:14]];
        [lbInfo2 setTextColor:[UIColor mq_sub2TextColor]];
        
        
        [lbInfo1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(20));
            make.right.equalTo(@(-20));
            make.height.equalTo(@(24));
            make.centerY.equalTo(self);
        }];
        [lbInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(20));
            make.right.equalTo(@(-20));
            make.top.equalTo(lbInfo1.mas_bottom);
            make.height.equalTo(@(24));
        }];
        
        [imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lbInfo1.mas_top).offset(-10);
            make.width.equalTo(@(57));
            make.height.equalTo(@(84));
            make.centerX.equalTo(self).offset(10);
        }];
        
        [btnAcion mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbInfo2.mas_bottom).offset(5);
            make.width.equalTo(@(87));
            make.height.equalTo(@(35));
            make.centerX.equalTo(self);
        }];
        
        [btnAcion setHidden:false];
    }
}

- (void)setText1WithText:(NSString *)text{
    if (text) {
        [lbInfo1 setText:text];
    }else{
        [lbInfo1 setText:@""];
    }
    
}

- (void)setText2WithText:(NSString *)text{
    if (text) {
        [lbInfo2 setText:text];
    }else{
        [lbInfo2 setText:@""];
    }
}

+ (void)dismissInView:(UIView *)view{
    MQEmptyView * emptyView = [self emptyViewForView:view];
    if (emptyView) {
        [emptyView removeFromSuperview];
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * view = [super hitTest:point withEvent:event];
    if (view == btnAcion) {
        [self buttonActionCallBack];
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
