//
//  dataTool.h
//  LiteGuardian
//
//  Created by SoKing on 2017/5/2.
//  Copyright © 2017年 Castelecom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataTool : NSObject



/**
 byte[]转data

 @param byte 要转换的byte数组
 @param byteLength 数组的长度
 @return 一个完成转换的data
 */
+(NSData *)byteToData:(Byte *)byte andByteLength:(int)byteLength;
//string转data
+ (NSData *)stringToData:(NSString *)string;
//int转data,给定长度
+ (NSData *)intToData:(int)intValue andLength:(int)length;
//data转Byte,给定长度
+ (Byte *)dataToByte:(NSData *)data;

//不足补齐
+ (NSData *)dataAdd0x00:(NSData *)data length:(int)length;

/**
 大小端互转的方法

 @param data 需要转换的data
 @return 完成转换的data
 */
+(NSData *)dataTransfromBigOrSmall:(NSData *)data;

/**
 data的截取

 @param data 截取的对象
 @param subRange 截取的范围
 @return 截取的结果
 */
+(NSData *) dataCapture:(NSData *)data andSubDataRange:(NSRange)subRange;
/*
 *NSString转换
 */
+(NSString *)dataToString:(NSData *)data;

/**
 data转成10进制整形

 @param data 要转换的data
 @return 10进制的整形
 */
+(NSInteger)dataToInt:(NSData *)data;
@end
