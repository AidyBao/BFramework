//
//  MQTabbarItem.h
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTabbarItem : NSObject
/**嵌入在NavigationController*/
@property (nonatomic,assign) BOOL embedInNavigation;
/**选中时点显示方式*/
@property (nonatomic,assign) BOOL showAsPresent;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * normalImage;
@property (nonatomic,copy) NSString * selectedImage;

@end
