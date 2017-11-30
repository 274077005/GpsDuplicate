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


-(void)skChangeUserInfo:(id)userinfo{
    if ([userinfo isKindOfClass:[NSDictionary class]]) {
        _userInfoDic=userinfo;
        [UserLogin mj_objectWithKeyValues:_userInfoDic];
    }else{
        NSLog(@"后台数据异常");
    }
}

@end
