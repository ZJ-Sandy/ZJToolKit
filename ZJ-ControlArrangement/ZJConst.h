//
//  TQConst.h
//  Taoqicar
//
//  Created by xmk on 16/9/29.
//  Copyright © 2016年 taoqicar. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - ***** 枚举 *****
/** tableView 上下拉 刷新 */
typedef enum {
    TQTVRefreshTypeNone      = 0,        //不添加刷新
    TQTVRefreshTypeHeader    = 1 << 1,      //头部
    TQTVRefreshTypeFooter    = 1 << 2,      //尾部
    TQTVRefreshTypeAll       = ~0UL
}TQTVRefreshType;

/** 注册类型 */
typedef NS_ENUM(NSInteger, RegisterVCType) {
    RegisterVCType_register = 0,
    RegisterVCType_findPassword,
    RegisterVCType_modifyPassword,
    RegisterVCType_bindingPhone,
    RegisterVCType_phoneAuth,
};

/** 身份认证结果 */
typedef NS_ENUM(NSInteger, TQCertificateType) {
    TQCertificateType_none      = 0,
    TQCertificateType_success   = 1,
    TQCertificateType_fail      = 2
};

typedef NS_ENUM(NSUInteger, TQAuthEntranceType) {
    TQAuthEntranceType_mine     = 1,
    TQAuthEntranceType_order    = 2,
};

typedef NS_ENUM(NSInteger, TQLocationSendState) {
    TQLocationSendState_startApp    = 1,    //每次启动app
    TQLocationSendState_login       = 2,    //登录
    TQLocationSendState_logout      = 3,    //退出登录
    TQLocationSendState_itemDetail  = 4,    //进入车辆详情页
    TQLocationSendState_toPayAmount = 5,    //点击详情页“支付定金99元”
    TQLocationSendState_submitOrder = 6,    //点击提交订单
    TQLocationSendState_payAmount   = 7,    //点击“去支付”99元
    TQLocationSendState_payAmountAdditional     = 8,    //点击“补全定金”4900元"
    TQLocationSendState_identityAuthentication  = 9,    //点击“身份验证”
    TQLocationSendState_signContract            = 10,   //点击“签署合同”
    TQLocationSendState_confirmCarInfo          = 11,   //点击“确认提车信息”
    TQLocationSendState_payDelivery             = 12,   //点击“立即支付”提车款"
    TQLocationSendState_signFinancingContract   = 13,   //点击“签署融资租赁合同”
//    [TQUserDataHelper sendLocationInfoWithNode:TQLocationSendState];
};

/** 分享类型 */
//1 微信好友 2 微信朋友圈 3 多图  4 QQ 5 QQ空间 6新浪微博 100 复制链接  101 二维码展示
typedef NS_ENUM(NSInteger, TQShareType) {
    TQShareTypeWechar       = 1,
    TQShareTypeMoment,
    TQShareTypeMultiImage,
    TQShareTypeQQ,
    TQShareTypeQQZone,
    TQShareTypeSina,
    TQShareTypeCopyUrl      = 100,
    TQShareTypeQRCode       = 101,
    
    TQShareTypeBanner       = 1000,
    TQShareTypeNeedLogin    = 1001,
};

typedef NS_ENUM(NSInteger, TQPayType) {
    TQPayType_wechat    = 0,
    TQPayType_alipay    = 1,
};

typedef NS_ENUM(NSInteger, TQCameraType) {
    TQCameraType_idFront = 101,
    TQCameraType_idBack,
    TQCameraType_driveFront,
    TQCameraType_driveBack,
};

#define TQTQDEPRECATED_VERSION(_version) __attribute__((_version))

#pragma mark - ***** const *****
#define kPhoneVerifyCodeLeng 6
#define kPwdMinLeng 8

#define TQFont(a)       [UIFont systemFontOfSize:a]
#define TQFontBold(a)   [UIFont boldSystemFontOfSize:a]

#define TQFont_PFSC_Regular(a)   [UIFont fontWithName:@"PingFangSC-Regular" size:a]
#define TQFont_PFSC_Light(a)     [UIFont fontWithName:@"PingFangSC-Light" size:a]

#define TQNavBarStyleH     0.f



#pragma mark - ***** config *****
static NSString * const kTaoqi_telCustomer  = @"400-892-7378"; // @"18050217025";  //059186129160 400-766-7166
//vc.url = @"http://taoqi.xxfgo.com/m/yuegong/";
//vc.url = @"http://taoqi.xxfgo.com/m/illegalquery/";

#pragma mark - ***** notification *****
static NSString * const kNotificontion_networkReconnect = @"kNotificontion_networkReconnect";

static NSString * const kNotificontion_receiveMsg_KF    = @"kNotificontion_receiveMsg_KF";
static NSString * const kNotificontion_receiveMsg_sys   = @"kNotificontion_receiveMsg_sys";
static NSString * const kNotificontion_updateIMList     = @"kNotificontion_updateIMList";

#pragma mark - ***** Cache *****
static NSString * const kTQCache_userInfo               = @"TQCache_userInfo";
static NSString * const kTQCache_virtualInfo            = @"TQCache_virtualInfo";
static NSString * const kTQCache_searchHistory          = @"TQCache_searchHistory";
static NSString * const kTQCache_selectCity             = @"TQCache_selectCity";
static NSString * const kTQCache_startPage              = @"kTQCache_startPage";
static NSString * const kTQCache_tabbarInfo             = @"kTQCache_tabbarInfo";

static NSString * const kTQCache_bannerInfo             = @"kTQCache_bannerInfo";
static NSString * const kTQCache_navInfo                = @"kTQCache_navInfo";
static NSString * const kTQCache_recommendInfo          = @"kTQCache_recommendInfo";

static NSString * const TQCache_logTrackArray           = @"TQCache_logTrackArray";
static NSString * const TQCache_itemDetailPageLogAry    = @"TQCache_itemDetailPageLogAry";

#pragma mark - ***** shortcut ******
static NSString * const kTQShortcut_partner = @"com.taoqicar.mall.shortcut.partner";
static NSString * const kTQShortcut_scan    = @"com.taoqicar.mall.shortcut.scan";
static NSString * const kTQShortcut_choice  = @"com.taoqicar.mall.shortcut.choice";

#pragma mark - ***** UserDefault *****
static NSString * const kTQUserDefault_platform         = @"kTQUserDefault_platform";
static NSString * const kTQUserDefault_isLogin          = @"kTQUserDefault_isLogin";
static NSString * const kTQUserDefault_CFBundleVersion  = @"kTQUserDefault_CFBundleVersion";
static NSString * const kTQUserDefault_sysUnreadCount   = @"kTQUserDefault_sysUnreadCount";


#pragma mark - ***** app info *****
static NSString * const kTaoqi_appType      = @"1";
static NSString * const kTaoqi_appSecret    = @"89dbc721-e758-4f30-82d3-93a3582300e1";
static NSString * const kTaoqi_schemes      = @"taoqicar";
static NSString * const kTaoqi_appId        = @"1167395546";

#pragma mark - ***** NotificationCenter ******
static NSString * const kNotification_locationAlertInfo     = @"kNotification_locationAlertInfo";
static NSString * const kNotification_locationSetOver       = @"kNotification_locationSetOver";



/** UM Key   渠道 */
#ifdef DEBUG
static NSString * const kChannelId          = @"TQTest";              //打包渠道
static NSString * const kUM_appKey          = @"58aff9b97f2c744ab7000879";
#else
static NSString * const kChannelId          = @"TQAppStore";              //打包渠道
static NSString * const kUM_appKey          = @"58086c4167e58e01cb00373f";
#endif


#pragma mark - ***** third party *****
/** JSPatch */
static NSString * const kJSPatch_appKey     = @"";

/** 微信 */
static NSString * const kWX_appId           = @"wxd7b6787eb7baf1e6";
static NSString * const kWX_appSecret       = @"01a85f2de303dad7354bd2d4985b29be";
//static NSString * const kWX_AppUrl =        @"http://www.umeng.com/social";

/** QQ */
static NSString * const kQQ_appId           = @"101372144";
static NSString * const kQQ_appKey          = @"c02ed214e9af07ddb9360eae1b1196c0";

/** 支付宝 */
static NSString * const kAlipay_appId       = @"2016121204166754";

/** RC */
static NSString * const kRC_appKey          = @"25wehl3u2jvew";
static NSString * const kRC_appSecret       = @"KygH5T3UOWnZWL";
static NSString * const kIMKefuUuid         = @"KEFU148288933040639";


/** 高德地图 */
static NSString * const kAmap_appKey        = @"a10799c2932fbe8526aa0602b7eb55ba";


