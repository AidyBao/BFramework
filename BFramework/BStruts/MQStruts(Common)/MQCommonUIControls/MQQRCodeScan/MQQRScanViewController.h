//
//  MQQRScanViewController.h
//  XXXX
//
//  Created by JuanFelix on 2016/12/5.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MQQRCallBack)(NSString *memberInfo);

@interface MQQRScanViewController : UIViewController

@property (nonatomic,copy) MQQRCallBack mqQRCallBack;
@property (nonatomic,assign) BOOL autoDismiss;

/** Start Scan
 * push : YES - PUSH ,NO - PRESENT
 */
+ (MQQRScanViewController *)startScanInViewController:(UIViewController *)vc
                                               asPush:(BOOL)push
                                          autoDismiss:(BOOL)autoDismiss
                                             callBack:(MQQRCallBack)callBack;

- (void)stopScan;
- (void)restartScan;

@end
