//
//  MQWebEngine.h
//  ydhyk
//
//  Created by screson on 2016/11/21.
//  Copyright © 2016年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>
/**Web内容加载，待后期完善 添加交互*/
@interface MQWebEngine : UIViewController

- (void)loadContentWithURL:(NSURL *)url;
- (void)loadContentWithHTMLString:(NSString *)htmlString baseURL:(NSURL *)baseURL;


@end
