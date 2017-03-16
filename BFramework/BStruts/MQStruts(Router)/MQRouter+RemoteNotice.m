//
//  MQRouter+RemoteNotice.m
//  MQStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQRouter+RemoteNotice.h"
//通知视图
#import "NoticeViewController.h"

//保存上一次通知信息
static NSDictionary * lastNoticeInfo = nil;

@implementation ApsModel


@end

@implementation MQRemoteNoticeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"aps":[ApsModel class]};
}

- (MQRemoteNoticeType)type{
    if ([_pushType isKindOfClass:[NSString class]] && _pushType.length) {
        if ([_pushType isEqualToString:@"order"]) {
            return MQRemoteNoticeTypeOrderUpdate;
        }
        if ([_pushType isEqualToString:@"notice"]) {
            return MQRemoteNoticeTypeNewNotice;
        }
    }
    return MQRemoteNoticeTypeTakeUnknown;
}

@end

@implementation MQRouter (RemoteNotice)

+ (void)showNoticeDetail:(NSDictionary *)userInfo{
    if ([userInfo isKindOfClass:[NSDictionary class]] && userInfo.count) {
        MQRemoteNoticeModel * noticeModel = [MQRemoteNoticeModel mj_objectWithKeyValues:userInfo];
        //if ([[MQRootViewControllers mq_tabbarController].view window]) {
        UIViewController * rootVC = [[UIApplication sharedApplication].keyWindow rootViewController];
        if (rootVC == [MQRootViewControllers mq_tabbarController]) {
            UIViewController * selectedVC = [[MQRootViewControllers mq_tabbarController] selectedViewController];
            UINavigationController * nav = nil;
            if ([[MQRootViewControllers mq_tabbarController] presentedViewController]) {//判断时候present了某个vc
                selectedVC = [[MQRootViewControllers mq_tabbarController] presentedViewController];
            }
            if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                nav = (UINavigationController *)selectedVC;
                selectedVC = [[(UINavigationController *)selectedVC viewControllers] firstObject];
            }else{
                nav = selectedVC.navigationController;
            }
            
            if ([selectedVC isKindOfClass:[NoticeViewController class]]) {
                lastNoticeInfo = userInfo;
                return;
            }
            if (![nav isKindOfClass:[UINavigationController class]]) {
                lastNoticeInfo = userInfo;
                return;
            }
            lastNoticeInfo = nil;
            if (noticeModel.type == MQRemoteNoticeTypeTakeUnknown) {
                [MQAudioUtils vibrate];
                [MQAlertUtils showAAlertWithTitle:@"新消息" message:noticeModel.aps.alert];
            }else{
                [MQAudioUtils vibrate];
                [MQAlertUtils showAAlertWithTitle:@"新消息" message:noticeModel.aps.alert buttonTexts:@[@"忽略",@"马上查看"] buttonAction:^(int buttonIndex) {
                    if (buttonIndex == 1) {
                        switch (noticeModel.type) {
                            case MQRemoteNoticeTypeNewNotice:
                            {
                                
                            }
                                break;
                            case MQRemoteNoticeTypeOrderUpdate:
                            {
                                
                                
                            }
                                break;
                            default:
                                break;
                        }
                    }
                }];
            }
        }else{
            lastNoticeInfo = userInfo;
        }
    }else{
        lastNoticeInfo = nil;
    }
}

+ (void)checkNoticeCache{
    [self showNoticeDetail:lastNoticeInfo];
}

@end
