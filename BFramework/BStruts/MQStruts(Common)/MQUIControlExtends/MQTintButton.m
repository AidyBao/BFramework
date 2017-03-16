//
//  MQTintButton.m
//  MQStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQTintButton.h"
#import "MQStruts.h"

@implementation MQTintButton

+ (instancetype)button{
    return [MQTintButton buttonWithType:UIButtonTypeCustom];
}

- (UIButtonType)buttonType{
    return UIButtonTypeCustom;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadColorFromPlist];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self loadColorFromPlist];
}

- (void)loadColorFromPlist{
    [self.titleLabel setFont:[UIFont mq_titleFontWithSize:mq_buttonTitleFontSize()]];
    [self setTitleColor:[UIColor mq_buttonTitleNormalColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor mq_buttonTitleSelectedColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor mq_buttonTitleSelectedColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor mq_buttonTitleDisabledColor] forState:UIControlStateDisabled];
    if (self.enabled) {
        [self setBackgroundColor:[UIColor mq_buttonBGNormalColor]];
    }else{
        [self setBackgroundColor:[UIColor mq_buttonBGDisabledColor]];
    }
}


@end
