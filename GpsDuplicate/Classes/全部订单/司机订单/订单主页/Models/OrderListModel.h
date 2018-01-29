//
//  OrderListModel.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/2.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject
/*
 BuildUnit = "<null>";
 ConstructionUnit = "<null>";
 InOrOut = 0;
 Loading = "<null>";
 OrderID = 201711241540320053;
 OrderStatus = 21;
 OutTime = "<null>";
 ProjectAddress = "\U6c99\U6cb3\U897f\U8def";
 ProjectName = "<null>";
 ReceivingName = "\U90e8\U4e5d\U7a9d\U53d7\U7eb3\U573a";
 StatusName = "\U5df2\U5b8c\U6210";
 SupervisorUnit = "<null>";
 VehicleNo = "\U7ca4B64986";
 WasteType = "<null>";
 返回联单信息：OrderID（联单编号）、VehicleNo（车牌号）、ProjectAddress（工程地址）、ReceivingName（处置场名称）、OrderStatus（状态：11已激活、12待出场、15待处置、21已完成）、InOrOut（市内或市外：0、市内 1、市外）、OutTime（出场时间）、WasteType（废弃物种类）、Loading（装载量）、ProjectName（工程名称）、SupervisorUnit（监理单位）、BuildUnit（建设单位）、ConstructionUnit（施工单位）

 */

@property (nonatomic,copy) NSString *OrderID;//联单编号
@property (nonatomic,copy) NSString *VehicleNo;//车牌号码
@property (nonatomic,copy) NSString *ProjectAddress;//工程地址
@property (nonatomic,copy) NSString *ReceivingName;//处置场名称
@property (nonatomic,copy) NSString *OrderStatus;//状态
@property (nonatomic,copy) NSString *InOrOut;//市内或市外
@property (nonatomic,copy) NSString *OutTime;//出场时间
@property (nonatomic,copy) NSString *WasteType;//废弃物种类
@property (nonatomic,copy) NSString *Loading;//装载量
@property (nonatomic,copy) NSString *ProjectName;//工程名称
@property (nonatomic,copy) NSString *SupervisorUnit;//监理单位
@property (nonatomic,copy) NSString *BuildUnit;//建设单位
@property (nonatomic,copy) NSString *ConstructionUnit;//施工单位
@property (nonatomic,copy) NSString *StatusName;//状态描述

@end
