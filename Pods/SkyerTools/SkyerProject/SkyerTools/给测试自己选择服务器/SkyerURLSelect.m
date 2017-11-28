//
//  SkyerURLSelect.m
//  test
//
//  Created by SoKing on 2017/5/17.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "SkyerURLSelect.h"
#import "SkyerGetVisibleViewController.h"

// 正式服务器
#define ConnectionInfoServerSkyer      @"http://54.179.149.239:10000/SyncData/RemotingAPI"
#define REQUEST_SERVICE_URLSkyer            [NSString stringWithFormat:@"http://%@/WebApi2d/WebAPIVersion3",localSavedUrlIPandPortSkyer]

#define localSavedUrlIPandPortSkyer   [[NSUserDefaults standardUserDefaults] objectForKey:@"registServerURL"]

//// 测试服务器
//#define ConnectionInfoServer      @"http://218.17.161.66:10230/SyncData/RemotingAPI"
//#define REQUEST_SERVICE_URL            [NSString stringWithFormat:@"http://%@/WebApi2d/WebAPIVersion3",localSavedUrlIPandPort]

//#define ConnectionInfoServer      @"http://218.17.161.66:10230/SyncData/RemotingAPI"
//#define REQUEST_SERVICE_URL            [NSString stringWithFormat:@"http://%@/WebApi2d/WebAPIVersion3",localSavedUrlIPandPort]



// 张仕华接口
//#define ConnectionInfoServer      @"http://172.18.2.100:8090/SyncData/RemotingAPI"
//#define REQUEST_SERVICE_URL @"http://172.18.2.100:8080/WebApi2d/WebAPIVersion3"


// 汤瑞接口
//#define ConnectionInfoServer      @"http://172.18.11.168:8090/SyncData/RemotingAPI"
//#define REQUEST_SERVICE_URL       @"http://172.18.11.168:8050/WebApi2d/WebAPIVersion3"



@implementation SkyerURLSelect
{
    NSInteger indexSelect;
}
//全局变量
static id _instance = nil;
//单例方法
+(instancetype)sharedInstance{
    return [[self alloc] init];
}
////alloc会调用allocWithZone:
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    //只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
//初始化方法
- (instancetype)init{
    // 只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}
//copy在底层 会调用copyWithZone:
- (id)copyWithZone:(NSZone *)zone{
    return  _instance;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  _instance;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}


- (void) skyerSelect{
    
#ifdef DEBUG
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"这个弹框appstore不显示，只是方便测试人员在进入app的时候选择不同的服务器地址！" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *Action0 = [UIAlertAction actionWithTitle:@"正式服务器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        indexSelect=0;
    }];
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"测试服务器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        indexSelect=1;
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"汤瑞服务器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        indexSelect=2;
    }];
    
    [alertController addAction:Action0];
    [alertController addAction:Action1];
    [alertController addAction:Action2];
    UIViewController *VC=[[SkyerGetVisibleViewController sharedInstance] skyerVisibleViewController];
    [VC presentViewController:alertController animated:YES completion:nil];
    
#else
    
    
#endif
   
}

-(NSString *)skyerURLSelect{
    
#ifdef DEBUG
    
    return [self getURLBy];
    
#else
    
    return ConnectionInfoServerSkyer;
    
#endif
    return ConnectionInfoServerSkyer;
    
}
//根据用户选择返回不同的服务器地址1.正式服务器2.测试服务器3.汤瑞服务器
- (NSString *)getURLBy{
    NSString *url;
    switch (indexSelect) {
        case 0:
            url=ConnectionInfoServerSkyer;
            break;
        case 1:
            url=@"http://218.17.161.66:10230/SyncData/RemotingAPI";
            break;
        case 2:
            url=@"http://172.18.11.168:8090/SyncData/RemotingAPI";
            break;
            
        default:
            break;
    }
    return url;
}

-(NSString *)skyerRequestURL{
    
#ifdef DEBUG
    
    return [self getRequestURL];
    
#else
    
    return REQUEST_SERVICE_URLSkyer;
    
#endif
    return REQUEST_SERVICE_URLSkyer;
    
}
//根据用户选择返回不同的服务器地址1.正式服务器2.测试服务器3.汤瑞服务器
- (NSString *)getRequestURL{
    NSString *url;
    switch (indexSelect) {
        case 0:
            url=REQUEST_SERVICE_URLSkyer;
            break;
        case 1:
            url=[NSString stringWithFormat:@"http://%@/WebApi2d/WebAPIVersion3",localSavedUrlIPandPortSkyer];
            break;
        case 2:
            url=@"http://172.18.11.168:8050/WebApi2d/WebAPIVersion3";
            break;
            
        default:
            break;
    }
    return url;
}

@end
