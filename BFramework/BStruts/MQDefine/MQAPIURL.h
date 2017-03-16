//
//  MQAPIURL.h
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#ifndef MQAPIURL_h
#define MQAPIURL_h

//接口地址及状态定义

#define MQPAGE_SIZE  10       //单页数据条数
#define MQAPI_KEY    @"BMQ" //接口签名秘钥
#define MQAPI_INITIAL_PASSWORD   @"BMQ123456" //初始密码

#define MQAPI_TIMEOUT_INTREVAL   10 //接口超时时间
#define MQAPI_SUCCESS             0 //接口调用成功
#define MQAPI_LOGIN_INVALID  100001 //登录失效
#define MQAPI_SIGN_FAILED    100002 //签名认证失败
#define MQAPI_PARAM_ERROR    100003 //参数校验失败
#define MQAPI_NOT_EXIST      100004 //用户不存在
#define MQAPI_NODATE         100005 //误操作的数据
#define MQAPI_ACCOUNT_ERROR  100006 //用户名或密码错误
#define MQAPI_ACCOUNT_LOCKED 100007 //当前用户已锁定
#define MQAPI_ERROR          200001 //业务操作失败
#define MQAPI_NOT_MEMBER     200002 //药店不存在该会员
#define MQAPI_SYSTEM_ERROR   300001 //系统异常

//MARK: -
#define MQAPI_FORMAT_ERROR   900900           //接口返回数据非json字典
#define MQFORMAT_ERROR_MSG   @"接口数据格式错误" //接口返回数据非json字典
//MARK: -
#define MQAPI_HTTP_TIME_OUT  -1001            //请求超时
#define MQAPI_HTTP_ERROR     900901           //HTTP请求失败
#define MQAPI_HTTP_ERROR_MSG   @"此时无法访问服务器"    //HTTP请求失败
#define MQAPI_HTTP_TIMEOUT_MSG @"访问超时,请稍后再试"    //HTTP请求失败

//MARK: -
#define MQHUD_MBDELAY_TIME 1.0  //HUD显示时间

//MARK: - AppStore更新检测地址
#define APPSTORE_CHECKUPDATE        @""
//MARK: - 应用包名
#define ENTERPRISE_BUNDLE_ID        @"com.AidyBao.BFramework"           //企业
#define APPSTORE_BUNDLE_ID          @"com.AidyBao.BFramework.AppStore"  //AppStore
//MARK: - 我的、管家、药店二维码地址需包含
#define MQ_QRCODE_CONTAIN           @""

#if MQTARGET == 1
    //MARK: - -----------------------------生产环境----------------------------------
    //MARK: - 接口地址
    #define MQROOT_URL                  @""
    #define MQPORT                      @""
    //MAKR: - 资源服务器地址
    #define MQIMAGE_URL                 @""
    #define MQIMAGE_PORT                @""
    //MARK: - 静态网页端口
    #define MQROOT_STATIC_URL           @""
    //MARK: - 企业版更新检测地址
    #define ENTERPRISE_CHECKUPDATE      @""
#elif MQTARGET == 2
    //MARK: - -----------------------------测试环境----------------------------------
    //MARK: - 接口地址
    #define MQROOT_URL                  @""
    #define MQPORT                      @""
    //MAKR: - 资源服务器地址
    #define MQIMAGE_URL                 @""
    #define MQIMAGE_PORT                @""
    //MARK: - 静态网页端口
    #define MQROOT_STATIC_URL           @""
    //MARK: - 企业版更新检测地址
    #define ENTERPRISE_CHECKUPDATE      @""
#else
    //MARK: - -----------------------------培训环境----------------------------------
    //MARK: - 接口地址
    #define MQROOT_URL                  @""
    #define MQPORT                      @""
    //MAKR: - 资源服务器地址
    #define MQIMAGE_URL                 @""
    #define MQIMAGE_PORT                @""
    //MARK: - 静态网页端口
    #define MQROOT_STATIC_URL           @""
    //MARK: - 企业版更新检测地址
    #define ENTERPRISE_CHECKUPDATE      @""
#endif

//MARK: - 资源存储文件夹
#define MQAPI_Thumb_Path                    @""                     //头像存储文件夹
#define MQAPI_ChuFang_Path                  @""             //处方存储文件夹
#define MQAPI_HYD_Path                      @""          //化验单存储文件夹


#endif /* MQAPIURL_h */
