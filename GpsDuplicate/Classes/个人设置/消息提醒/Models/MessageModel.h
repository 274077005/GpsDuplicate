//
//  MessageModel.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/19.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
//"PushID": "h861st1962cc81da9f215adrt6d8172dw",
//"PushUserID": "2ba05dc6330949c3848c2ebbbedf7f47",
//"PushTitle": "您有一个新的联单",
//"PushContent": "您有一个新的电子联单信息，请及时查看",
//"PushTime": "2017-12-18 16:34:24"

@property (nonatomic,copy) NSString *PushID;
@property (nonatomic,copy) NSString *PushUserID;
@property (nonatomic,copy) NSString *PushTitle;
@property (nonatomic,copy) NSString *PushContent;
@property (nonatomic,copy) NSString *PushTime;

@end
