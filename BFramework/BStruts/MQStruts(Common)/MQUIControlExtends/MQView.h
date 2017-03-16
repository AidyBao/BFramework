//
//  MQView.h
//  MQStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

/*添加边框 圆角 XIB支持*/
@interface MQView : UIView

/**圆角半径*/
@property (nonatomic,assign) IBInspectable CGFloat   cornerRadius;
/**边框宽度*/
@property (nonatomic,assign) IBInspectable CGFloat   borderWidth;
/**边框颜色*/
@property (nonatomic,strong) IBInspectable UIColor * borderColor;


@end

