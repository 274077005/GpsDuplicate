//
//  ReceivingModel.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/25.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceivingModel : NSObject
/*
 "Receiving": [
 {
 "ReceivingID": "1",
 "ReceivingName": "部九窝受纳场"
 },
 {
 "ReceivingID": "2",
 "ReceivingName": "临时处置场"
 }
 ],

 */

@property (nonatomic,copy) NSString *ReceivingID;
@property (nonatomic,copy) NSString *ReceivingName;

@end
