//
//  skJPUSHSet.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "skJPUSHSet.h"




@implementation skJPUSHSet
SkyerSingletonM(skJPUSHSet)
#pragma mark 极光推送的初始化设置
- (void)skJpushSet:(NSDictionary * _Nullable)launchOptions {
    //接收自定义消息的时候需要写
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions
                           appKey:kjpushKey
                          channel:kjpushChannel
                 apsForProduction:kjpushIsProduction
            advertisingIdentifier:NULL];
}

#pragma mark- JPUSHRegisterDelegate
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    
    NSLog(@"消息%@",userInfo);
    
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSLog(@"willPresentNotification");
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    [self skReceiveJPUSHNotification:userInfo];
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
        completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户
    } else {
        // Fallback on earlier versions
    }
    
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"didReceiveNotificationResponse");
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    [self skReceiveJPUSHNotification:userInfo];
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
        completionHandler();  // 系统要求执行这个方法
    } else {
        // Fallback on earlier versions
    }
}


#pragma mark - 对收到的消息进行处理
-(void)skReceiveJPUSHNotification:(NSDictionary *_Nullable)info{
    NSLog(@"接收到通知=%@",info);
    [self skReceiveJush:info];
}
-(void)skReceiveJPUSHMessage:(NSDictionary *_Nullable)info{
    NSLog(@"接收到消息=%@",info);
    [self skReceiveJush:info];
}
-(void)skReceiveJush:(NSDictionary *_Nullable)info{
    NSLog(@"接收到消息都在这里=%@",info);
}

@end
