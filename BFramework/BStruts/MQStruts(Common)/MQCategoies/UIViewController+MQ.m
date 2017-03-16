//
//  UIViewController+MQ.m
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UIViewController+MQ.h"

@implementation UIViewController (MQ)

- (void)mq_addKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baseKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baseKeyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baseKeyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)mq_removeKeyboardNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark 键盘即将显示
- (void)baseKeyBoardWillShow:(NSNotification *)notice{
    [self mq_keyboardWillShowTimeInteval:[notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] notice:notice];
}

- (void)mq_keyboardWillShowTimeInteval:(double)dt notice:(NSNotification *)notice{
    
}

#pragma mark 键盘即将退出
- (void)baseKeyBoardWillHide:(NSNotification *)notice{
    [self mq_keyboardWillHideTimeInteval:[notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] notice:notice];
}

- (void)mq_keyboardWillHideTimeInteval:(double)dt notice:(NSNotification *)notice{
    
}


#pragma mark willchangeframe
- (void)baseKeyBoardWillChangeFrame:(NSNotification *)notice{
    CGRect beginKeyboardRect = [[notice.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self mq_keyboardWillChangeFrameBeginRect:beginKeyboardRect endRect:endKeyboardRect timeInterval:[notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] notice:notice];
}

- (void)mq_keyboardWillChangeFrameBeginRect:(CGRect)beginRect endRect:(CGRect)endRect timeInterval:(double)dt notice:(NSNotification *)notice{
    
}

@end
