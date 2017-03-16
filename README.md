# BFramework
BFramework

进来的朋友帮忙点个⭐️Star哈，谢谢，持续更新...

十分钟搭建App框架系列（OC）

基础框架篇
一个用Cocoapod创建的iOS框架，集成了常用工具，耦合度低，使用方便

UI进阶篇
1.所有核心组件都放在一个文件
2.所有配置都以.plist载入，包括字体颜色、大小、导航栏颜色、tabbar字体颜色等
//MARK: - 主色调
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


字体
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

网络/多线程篇
iOS笔记-多线程相关(pthread 、NSThread 、GCD、NSOperation)

第三方SDK接入心得
1.所有更新用cocoapods自动导入，方便更新

数据持久化篇
1.再次封装FMDB，所以用方便

底层原理篇



架构篇


“ ... to be continued”
![image](https://github.com/AidyBao/AidyBao/BFramework/master/GitHubResource/BF_01.png)
![image](https://github.com/AidyBao/AidyBao/BFramework/master/GitHubResource/BF_02.png)
![image](https://github.com/AidyBao/AidyBao/BFramework/master/GitHubResource/BF_03.png)
![image](https://github.com/AidyBao/AidyBao/BFramework/master/GitHubResource/BF_04.png)
![image](https://github.com/AidyBao/AidyBao/BFramework/master/GitHubResource/BF_05.png)

注
    这个Demo是为iOS入门级的同学们准备的，由于本人也是过来人，深知入门时走过的弯路，希望对大家共同学习。
    由于本人知识和技术水平有限，若有什么意见及建议欢迎随时向我提出，我将非常期待与你一起探讨技术问题
