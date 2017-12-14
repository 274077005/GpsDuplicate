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

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSLog(@"willPresentNotification");
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    [self skReceiveJPUSH:userInfo];
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
    [self skReceiveJPUSH:userInfo];
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
-(void)skReceiveJPUSH:(NSDictionary *_Nullable)info{
    NSLog(@"收到了啥?=%@",info);
}

@end
