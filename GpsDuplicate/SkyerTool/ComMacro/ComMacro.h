//
//  ComMacro.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/27.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SkyerTools.h>
#import <ReactiveObjC.h>
#import "SkNetwork.h"
#import <Masonry.h>
#import "MJExtension.h"
#import "UserLogin.h"
#import "SkyerBaseViewController.h"
#import <skCategoryHeader.h>


//服务器的ip地址
#define skURLString @"http://121.15.7.44:30032/api/ElectronicCouplet/PostApi"
#define skName @"13530125769"
#define skPw @"123456"
//url和接口组成的请求连接
#define skURLWithPort(port)        [NSString stringWithFormat:@"%@/?No=%@",skURLString,port]
//返回数据的解析
#define skContent(responseObject)  [responseObject objectForKey:@"Content"]
//这个是主色调
#define skBaseColor  skUIColorFromRGB(0x24AC6E)
//这个是线条的颜色
#define skLineColor  skUIColorFromRGB(0xEEF1F6)
//用户的登录信息
#define skUser       UserLogin.sharedUserLogin


@interface ComMacro : NSObject

@end
