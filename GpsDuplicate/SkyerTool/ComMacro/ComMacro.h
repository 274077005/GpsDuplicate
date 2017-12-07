//
//  ComMacro.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/27.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define skURLString @"http://121.15.7.44:30032/api/ElectronicCouplet/PostApi"
#define skName @"13530125769"
#define skPw @"123456"

//url和接口组成的请求连接
#define skURLWithPort(port)        [NSString stringWithFormat:@"%@/?No=%@",skURLString,port]
//返回数据的解析
#define skContent(responseObject)  [responseObject objectForKey:@"Content"]
#define skBaseColor  skUIColorFromRGB(0x24AC6E)
#define skLineColor  skUIColorFromRGB(0xEEF1F6)


@interface ComMacro : NSObject

@end
