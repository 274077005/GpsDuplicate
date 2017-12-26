//
//  WasteModel.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/25.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WasteModel : NSObject
/*
 "Waste": [
 {
 "WasteID": "1",
 "WasteName": "渣土"
 },
 {
 "WasteID": "2",
 "WasteName": "废土"
 }
 ],
 */

@property (nonatomic,copy) NSString *WasteID;
@property (nonatomic,copy) NSString *WasteName;
@end
