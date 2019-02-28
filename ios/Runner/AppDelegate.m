#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <WXApi.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:@"wx906221748b3266dd"];
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
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)gotoWechat:(NSString *)weappId {
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    [launchMiniProgramReq setUserName:weappId];
    [launchMiniProgramReq setMiniProgramType:WXMiniProgramTypeRelease];
    [WXApi sendReq:launchMiniProgramReq];
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
    [WXApi sendReq:req];
}

@end
