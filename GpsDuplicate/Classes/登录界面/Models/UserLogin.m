//
//  UserLogin.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/27.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "UserLogin.h"

@implementation UserLogin
SkyerSingletonM(UserLogin)

-(UserLogin *)skGetUserInfo{
    UserLogin *usrLogin=[UserLogin mj_objectWithKeyValues:_userInfoDic];
    return usrLogin;
}

-(void)skChangeUserInfo:(id)userinfo{
    if ([userinfo isKindOfClass:[NSDictionary class]]) {
        _userInfoDic=userinfo;
    }
}

@end
