//
//  OrderDetailsModel.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/4.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailsModel : NSObject
/*
 Content =     {
 BuildUnit = "\U57fa\U7840\U8bbe\U65bd\U5f00\U53d1\U5efa\U8bbe\U603b\U516c\U53f8";
 ConstructionUnit = "\U57fa\U7840\U8bbe\U65bd\U5f00\U53d1\U5efa\U8bbe\U603b\U516c\U53f8";
 InOrOut = 0;
 Loading = 15;
 OrderID = 201711241540320053;
 OrderStatus = 11;
 OutTime = "2017-11-20 12:00:00";
 ProjectAddress = "\U6c99\U6cb3\U897f\U8def";
 ProjectName = "12\U5e74\U5de5\U4e1a\U65b0\U57ce\U4f9b\U70ed\U5de5\U7a0b";
 ReceivingName = "\U90e8\U4e5d\U7a9d\U53d7\U7eb3\U573a";
 StatusName = "\U5f85\U786e\U8ba4";
 SupervisorUnit = "\U57fa\U7840\U8bbe\U65bd\U5f00\U53d1\U5efa\U8bbe\U603b\U516c\U53f8";
 VehicleNo = "\U7ca4B64986";
 WasteType = "<null>";
 };
 返回运单信息：OrderID（运单编号）、VehicleNo（车牌号）、ProjectAddress（工程地址）、ReceivingName（处置场名称）、OrderStatus（状态：11已激活、12待出场、15、待处置）、InOrOut（市内或市外：0、市内 1、市外）、OutTime（出场时间）、WasteType（废弃物种类）、Loading（装载量）、ProjectName（工程名称）、SupervisorUnit（监理单位）、BuildUnit（建设单位）、ConstructionUnit（施工单位）

 */
@property (nonatomic,copy) NSString *BuildUnit;
@property (nonatomic,copy) NSString *ConstructionUnit;
@property (nonatomic,copy) NSString *InOrOut;
@property (nonatomic,copy) NSString *Loading;
@property (nonatomic,copy) NSString *OrderID;
@property (nonatomic,copy) NSString *OrderStatus;
@property (nonatomic,copy) NSString *OutTime;
@property (nonatomic,copy) NSString *ProjectAddress;
@property (nonatomic,copy) NSString *ProjectName;
//处置场
@property (nonatomic,copy) NSString *ReceivingName;
@property (nonatomic,copy) NSString *StatusName;
@property (nonatomic,copy) NSString *SupervisorUnit;
@property (nonatomic,copy) NSString *VehicleNo;
@property (nonatomic,copy) NSString *WasteType;
@end
