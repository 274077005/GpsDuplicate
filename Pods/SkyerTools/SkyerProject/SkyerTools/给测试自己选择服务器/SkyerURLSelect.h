//
//  SkyerURLSelect.h
//  test
//
//  Created by SoKing on 2017/5/17.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkyerURLSelect : NSObject

+(instancetype)sharedInstance;
/**
 先在app第一次进入这个程序的时候调用一下给用户选择服务器地址
 */
- (void) skyerSelect;

/**
 获得URL，根据是否是debug状态还是发布状态，发布状态固定，debug状态测试人员选择

 @return 返回URL
 */
-(NSString *)skyerURLSelect;
@end
