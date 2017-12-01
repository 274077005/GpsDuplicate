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
#define skURLWithPort(port)  [NSString stringWithFormat:@"%@%@",skURLString,port]
//返回数据的解析
#define skContent(responseObject)  [responseObject objectForKey:@"Content"]

#define skBaseColor  skUIColorFromRGB(0x24AC6E)
#define skLineColor  skUIColorFromRGB(0xEEF1F6)

// 16进制转RGB
#define skUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 16进制转
#define skUIColorFromRGBWithAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define skUIColorHexToRGB(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

@interface ComMacro : NSObject

@end
