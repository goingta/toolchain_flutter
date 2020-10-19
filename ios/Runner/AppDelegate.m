#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <WXApi.h>
#include <WWKApi.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 微信注册
//    [WXApi registerApp:@"wx36017dd6944033f4" universalLink:@"https://yisheng.aihaisi.com/toolchain/"];
    //企业微信注册 使用的是dev
    [WWKApi registerApp:@"wwauth41abef44dc00e8c4000015" corpId:@"ww41abef44dc00e8c4" agentId:@"1000015"];
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

    FlutterMethodChannel* channel = [FlutterMethodChannel
                                            methodChannelWithName:@"goingta.flutter.io/share"
                                            binaryMessenger:controller];
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


@end
