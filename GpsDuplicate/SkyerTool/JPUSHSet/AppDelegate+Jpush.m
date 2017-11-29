//
//  AppDelegate+Jpush.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/29.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "AppDelegate+Jpush.h"
#import "skJPUSHSet.h"

@implementation AppDelegate (Jpush)
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //配置极光推送的key
    [[skJPUSHSet sharedskJPUSHSet] skJpushSet:launchOptions];
    
    return YES;
}
#pragma mark -下面的事推送的时候注册和消息处理
//获取deviceToken和注册
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
//注册失败回调
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"didReceiveRemoteNotification");
    
    [[skJPUSHSet sharedskJPUSHSet] skReceiveJPUSH:userInfo];
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"didReceiveRemoteNotification");
    // Required,For systems with less than or equal to iOS6
    [[skJPUSHSet sharedskJPUSHSet] skReceiveJPUSH:userInfo];
    [JPUSHService handleRemoteNotification:userInfo];
}
@end
