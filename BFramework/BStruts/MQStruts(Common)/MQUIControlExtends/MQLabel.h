//
//  ZXLabel.h
//  ZXStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface MQLabel : UILabel

/**圆角半径*/
@property (nonatomic,assign) IBInspectable CGFloat   cornerRadius;
/**边框宽度*/
@property (nonatomic,assign) IBInspectable CGFloat   borderWidth;
/**边框颜色*/
@property (nonatomic,strong) IBInspectable UIColor * borderColor;

@end
