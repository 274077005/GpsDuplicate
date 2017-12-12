//
//  orderStateColor.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/12.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "orderStateColor.h"

@implementation orderStateColor

+(UIColor *)skOrderState:(NSString *)state{
    /*
     司机:       状态：11已激活、12待出场、15待处置、21已完成
     工地施工单位: 状态：12待确认、15待签认、14已签认
     工地监理单位: 状态：12待确认、15待签认、13已签认
     处置场处理员: 状态：15待确认、21待签认、22已签认
     */
    UIColor *OrderStatusColor;
    switch ([UserLogin.sharedUserLogin.UserType integerValue]) {
        case 1:
        {
            switch ([state integerValue]) {
                case 11:
                {
                    OrderStatusColor=skUIColorFromRGB(0xF38C30);
                }
                    break;
                case 12:
                {
                    
                    OrderStatusColor=skUIColorFromRGB(0xF24D30);
                }
                    break;
                case 15:
                {
                    OrderStatusColor=skUIColorFromRGB(0x2AB3A3);
                }
                    break;
                case 21:
                {
                    OrderStatusColor=skUIColorFromRGB(0x20B85D);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch ([state integerValue]) {
                case 12:
                {
                    
                    OrderStatusColor=skUIColorFromRGB(0xF24D30);
                }
                    break;
                case 15:
                {
                    OrderStatusColor=skUIColorFromRGB(0x2AB3A3);
                }
                    break;
                case 14:
                {
                    OrderStatusColor=skUIColorFromRGB(0x20B85D);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch ([state integerValue]) {
                case 12:
                {
                    
                    OrderStatusColor=skUIColorFromRGB(0xF24D30);
                }
                    break;
                case 15:
                {
                    OrderStatusColor=skUIColorFromRGB(0x2AB3A3);
                }
                    break;
                case 13:
                {
                    OrderStatusColor=skUIColorFromRGB(0x20B85D);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            switch ([state integerValue]) {
                case 15:
                {
                    
                    OrderStatusColor=skUIColorFromRGB(0xF24D30);
                }
                    break;
                case 21:
                {
                    OrderStatusColor=skUIColorFromRGB(0x2AB3A3);
                }
                    break;
                case 22:
                {
                    OrderStatusColor=skUIColorFromRGB(0x20B85D);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    return OrderStatusColor;
}

@end
