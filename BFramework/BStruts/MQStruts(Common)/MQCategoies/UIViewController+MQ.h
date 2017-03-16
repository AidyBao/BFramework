//
//  UIViewController+MQ.h
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MQ)

//MARK: - 键盘将要显示、隐藏事件
/**添加键盘 【Will】显示 和 隐藏通知 */
- (void)mq_addKeyboardNotification;

/**移除键盘 【Will】显示 和 隐藏通知 */
- (void)mq_removeKeyboardNotification;

/**键盘 【Will】显示事件时间 */
- (void)mq_keyboardWillShowTimeInteval:(double)dt
                               notice:(NSNotification *)notice;
/**键盘 【Will】消失事件时间 */
- (void)mq_keyboardWillHideTimeInteval:(double)dt
                               notice:(NSNotification *)notice;

/**键盘 变换大小 */
- (void)mq_keyboardWillChangeFrameBeginRect:(CGRect)beginRect
                                    endRect:(CGRect)endRect
                               timeInterval:(double)dt
                                     notice:(NSNotification *)notice;

@end
