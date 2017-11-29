//
//  skJPUSHSet.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "skJPUSHSet.h"

#define kjpushKey @"49387c68bd79abf22f7b630b"
#define kjpushChannel @"569965"
#define kjpushIsProduction YES


@implementation skJPUSHSet
SkyerSingletonM(skJPUSHSet)
#pragma mark 极光推送的初始化设置
- (void)skJpushSet:(NSDictionary * _Nullable)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:kjpushKey
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
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"didReceiveNotificationResponse");
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    [self skReceiveJPUSH:userInfo];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
}
#pragma mark - 对收到的消息进行处理
-(void)skReceiveJPUSH:(NSDictionary *_Nullable)info{
    NSLog(@"收到了啥?=%@",info);
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:@"收到了" forKey:@"key"];
    [ud synchronize];
}
@end
