
## BFramework介绍
BFramework项目是一个以MVVC模式搭建的开源功能集合，基于Objective-C上面进行编写，意在解决新项目对于常见功能模块的重复开发，主要有以下特点：

 1.BFramework各个模块职责也比较明确；

 2.BFramework引入一些常用第三方插件、宏定义、工具帮助类等；

 3.整个项目也是在不断更新跟维护中，功能点也会不断更新；

 4.代码支持iOS7以后版本；

## 基础框架篇
    
    1.所有核心组件都放在一个文件
    2.所有配置都以.plist载入，包括字体颜色、大小、导航栏颜色、tabbar字体颜色等
    3.加载tabbarController只需要一句话便可以完成
[MQRootViewControllers loadfromPlistWithControllerClassNames:@[@"FirstRootViewController",@"SecondRootViewController",@"ThreeRootViewController",@"FourRootViewController"]];
[[MQRootViewControllers mq_tabbarController] setSelectedIndex:0];

    4.所有程序 主色调 用一句话调用

/*!程序主色调*/
+ (UIColor *)mq_tintColor;

/**程序辅助色*/
+ (UIColor *)mq_assistColor;

/**通用背景色*/
+ (UIColor *)mq_backgroundColor;

/**分割线颜色*/
+ (UIColor *)mq_separatorColor;

/**边框颜色*/
+ (UIColor *)mq_borderColor;

/**自定义颜色A (默认橙色系)*/
+ (UIColor *)mq_customAColor;

/**自定义颜色B (默认红色系)*/
+ (UIColor *)mq_customBColor;

/**自定义颜色C (默认红色系)*/
+ (UIColor *)mq_customCColor;


 5.字体
//MARK: -- 正文

/**标题1 字体大小 默认 6:17号*/

extern CGFloat mq_title1FontSize();

/**标题2 字体大小 默认 6:15号*/

extern CGFloat mq_title2FontSize();

/*!正文 字体大小 默认 6:14号*/

extern CGFloat mq_bodyFontSize();

//MARK: -- 导航栏
/**导航栏 Title文字大小 默认 6:21号*/

extern CGFloat mq_navBarTitleFontSize();

/**导航栏 按钮文字大小 默认 6:18号*/

extern CGFloat mq_navBarButtonTitleFontSize();

## 网络/多线程篇
iOS笔记-多线程相关(pthread 、NSThread 、GCD、NSOperation)

一句话调用网络请求
/**
*  异步接口请求
*
*  @param url          接口地址
*  @param params       接口参数
*  @param token        有Token 才添加签名
*  @param method       请求方式 GET POST DELETE
*  @param mqCompletion 接口请求完成回调
*/

+ (NSURLSessionDataTask *)asyncRequestWithURL:(NSString *)url

params:(NSDictionary *)params

token:(NSString *)token

method:(MQRequestMethod)method

mqCompletion:(MQRequestCompletion)mqCompletion;


/**
*  图片文件上传
*
*  @param resourceURL 资源接口地址
*  @param images      图片数组
*  @param token       签名用
*  @param qulity      压缩图片质量 0~1 0 最大压缩 1 不压缩
*  @param params      接口请求参数
*  @param mqCompletion    请求完成回调
*/

+(NSURLSessionDataTask *)uploadImageToResourceURL:(NSString *)resourceURL

images:(NSArray *)images

compressQulity:(float)qulity

filePath:(MQFilePath)filePath

token:(NSString *)token

params:(NSDictionary *)params

mqCompletion:(MQRequestCompletion)mqCompletion;

## 第三方SDK
1.所有更新用cocoapods自动导入，方便更新

## 数据持久化篇
1.再次封装FMDB，所以用方便
/** 保存或更新*/
- (BOOL)saveOrUpdate;

/** 保存或更新*/
- (BOOL)saveOrUpdateByColumnName:(NSString*)columnName AndColumnValue:(NSString*)columnValue;

/** 保存单个数据 */
- (BOOL)save;

/** 批量保存数据 */
+ (BOOL)saveObjects:(NSArray *)array;

+(BOOL)saveOrUpdateObjects:(NSArray *)array;

/** 更新单个数据 */
- (BOOL)update;

/** 批量更新数据*/
+ (BOOL)updateObjects:(NSArray *)array;

/** 删除单个数据 */
- (BOOL)deleteObject;

/** 批量删除数据 */
+ (BOOL)deleteObjects:(NSArray *)array;

/** 通过条件删除数据 */
+ (BOOL)deleteObjectsByCriteria:(NSString *)criteria;

/** 通过条件删除 (多参数）--2 */
+ (BOOL)deleteObjectsWithFormat:(NSString *)format, ...;

/** 清空表 */
+ (BOOL)clearTable;

## 效果图
<img src="https://github.com/AidyBao/BFramework/blob/master/GitHubResource/BF_01.png" width=200px height=300px></img>
<img src="https://github.com/AidyBao/BFramework/blob/master/GitHubResource/BF_02.png" width=200px height=300px></img>
<img src="https://github.com/AidyBao/BFramework/blob/master/GitHubResource/BF_03.png" width=200px height=300px></img>
<img src="https://github.com/AidyBao/BFramework/blob/master/GitHubResource/BF_04.png" width=200px height=300px></img>
<img src="https://github.com/AidyBao/BFramework/blob/master/GitHubResource/BF_05.png" width=200px height=300px></img>

## 联系方式
如果你在使用过程中有什么不明白或者问题可以281907061@qq.com联系，当然如果你有时间也可以一起维护
