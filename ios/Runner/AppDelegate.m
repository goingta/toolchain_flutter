#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <WXApi.h>
#include <WWKApi.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 微信注册
    [WXApi registerApp:@"wx36017dd6944033f4" universalLink:@"https://yisheng.aihaisi.com/toolchain/"];
    //企业微信注册 使用的是dev
    [WWKApi registerApp:@"wwauth41abef44dc00e8c4000015" corpId:@"ww41abef44dc00e8c4" agentId:@"1000015"];
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

    FlutterMethodChannel* channel = [FlutterMethodChannel
                                            methodChannelWithName:@"goingta.flutter.io/share"
                                            binaryMessenger:controller];

    __weak typeof(self) weakSelf = self;
    [channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"gotoWechat" isEqualToString:call.method]) {
            NSString* appid = [call.arguments objectForKey:@"appid"];
            NSString* programType = [call.arguments objectForKey:@"programType"];
            [weakSelf gotoWechat:appid programType:programType];
            result(@(YES));
        } else if ([@"shareToWechat" isEqualToString:call.method]) {
            [weakSelf shareToWechat:call.arguments];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self] ;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //企业微信回调
    [self handleOpenURL:url sourceApplication:sourceApplication];
    //微信回调
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
//    return [WXApi handleOpenURL:userActivity delegate:self];
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    return [WWKApi handleOpenURL:url delegate:self];
}

- (void)gotoWechat:(NSString *)weappId programType:(NSString *)programType {
//    //类型转换失败，小程序无法跳转
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:@1 forKey:@"test"];
//    [dic setObject:@2 forKey:@"preview"];
//    [dic setObject:@0 forKey:@"release"];
//    WXMiniProgramType type = (WXMiniProgramType)[dic objectForKey:programType];
    WXMiniProgramType type = WXMiniProgramTypeRelease;
    if ([programType isEqual:@"test"]) {
        type = WXMiniProgramTypeTest;
    }
    else if ([programType isEqual:@"preview"]){
        type = WXMiniProgramTypePreview;
    }
    else if ([programType isEqual:@"release"]){
        type = WXMiniProgramTypeRelease;
    }
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    [launchMiniProgramReq setUserName:weappId];
    [launchMiniProgramReq setMiniProgramType:type];
    [WXApi sendReq:launchMiniProgramReq completion:nil];
}

- (void)shareToWechat:(NSDictionary *)dic {
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [NSString stringWithFormat:@"https://www.pgyer.com/%@",dic[@"buildKey"]];

    WXMediaMessage *message = [WXMediaMessage message];
    message.title = [NSString stringWithFormat:@"蒲公英iOS版本(%@:%@)",dic[@"buildVersion"],dic[@"buildBuildVersion"]];
    message.description = dic[@"buildUpdateDescription"];
    message.mediaObject = ext;
    [message setThumbImage:[UIImage imageNamed:@"logo"]];
    message.mediaTagName = dic[@"buildVersion"];

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.message = message;
    req.bText = false;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:nil];
}

@end
