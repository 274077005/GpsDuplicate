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
//服务器返回字段
@property (nonatomic,copy) NSString *EnterName;
@property (nonatomic,copy) NSString *IsBindVehicle;
@property (nonatomic,copy) NSString *RealName;
@property (nonatomic,copy) NSString *UserID;
@property (nonatomic,copy) NSString *UserName;
@property (nonatomic,copy) NSString *UserType;
@property (nonatomic,copy) NSString *VehicleNo;
/**
 修改个人信息
 
 @param userinfo 新的个人信息词典
 */
-(void)skChangeUserInfo:(id)userinfo;
@end
