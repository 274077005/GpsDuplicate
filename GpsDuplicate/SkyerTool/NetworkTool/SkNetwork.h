//
//  SkNetwork.h
//  GpsDuplicate
//
//  Created by SoKing on 2018/1/4.
//  Copyright © 2018年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SKNetworkingSDK/SKNetworking.h>

@interface SkNetwork : NSObject
SkyerSingletonH(SkNetwork)
/**
 *  封装的POST请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param isShow     是否有等待提示菊花
 *  @param showErr    是否显示错误信息
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)SKPOST:(NSString *_Nullable)URLString parameters:(NSDictionary *_Nullable)parameters showHUD:(Boolean)isShow showErrMsg:(BOOL) showErr success:(responseSuccess)success failure:(responseFailure)failure;
@end
