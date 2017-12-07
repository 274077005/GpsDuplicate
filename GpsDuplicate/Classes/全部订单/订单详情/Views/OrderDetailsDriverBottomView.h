//
//  OrderDetailsDriverBottomView.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/7.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsModel.h"

@interface OrderDetailsDriverBottomView : UIView
@property (nonatomic,strong) OrderDetailsModel *model;
@property (nonatomic,strong) UIButton *btnSure;
@property (nonatomic,strong) UIButton *btnAbnormal;

-(void)updateUI;
@end
