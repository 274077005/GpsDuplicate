//
//  SkNetwork.m
//  GpsDuplicate
//
//  Created by SoKing on 2018/1/4.
//  Copyright © 2018年 skyer. All rights reserved.
//

#import "SkNetwork.h"

@implementation SkNetwork
SkyerSingletonM(SkNetwork)
- (void)SKPOST:(NSString *_Nullable)URLString parameters:(NSDictionary *_Nullable)parameters showHUD:(Boolean)isShow showErrMsg:(BOOL) showErr success:(responseSuccess)success failure:(responseFailure)failure{
    
    NSLog(@"请求的URL\n%@ \n 请求的参数\n%@",URLString,parameters);
     
    [[SKNetworking sharedSKNetworking] SKPOST:URLString parameters:parameters showHUD:isShow showErrMsg:showErr success:^(id  _Nullable responseObject) {
        NSLog(@"请求的URL\n%@ \n 返回的结果\n%@",URLString,responseObject);
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
    
}

@end
