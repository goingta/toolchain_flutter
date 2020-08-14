#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <WXApi.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:@"wx36017dd6944033f4" universalLink:@"https://xingren.com/app/"];
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                            methodChannelWithName:@"goingta.flutter.io/share"
                                            binaryMessenger:controller];
    
    __weak typeof(self) weakSelf = self;
    [channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"gotoWechat" isEqualToString:call.method]) {
            NSString* weappId = call.arguments;
            [weakSelf gotoWechat:weappId];
            
            result(@(YES));
        } else if ([@"shareToWechat" isEqualToString:call.method]) {
            [weakSelf shareToWechat:call.arguments];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    //调用自检函数
    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult* result) {
        NSLog(@"wxapi:%@, %u, %@, %@", @(step), result.success, result.errorInfo, result.suggestion);
    }];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
//    return [WXApi handleOpenURL:userActivity delegate:self];
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

- (void)gotoWechat:(NSString *)weappId {
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    [launchMiniProgramReq setUserName:weappId];
    [launchMiniProgramReq setMiniProgramType:WXMiniProgramTypeRelease];
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
