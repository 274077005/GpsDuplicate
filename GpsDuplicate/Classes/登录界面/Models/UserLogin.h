//
//  UserLogin.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/27.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserLogin : NSObject
SkyerSingletonH(UserLogin)
@property (nonatomic,strong) NSMutableDictionary *userInfoDic;//用户的词典
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;

/**
 获取个人信息
 
 @return 返回个人信息模型
 */
-(UserLogin *)skGetUserInfo;

/**
 修改个人信息
 
 @param userinfo 新的个人信息词典
 */
-(void)skChangeUserInfo:(id)userinfo;
@end
