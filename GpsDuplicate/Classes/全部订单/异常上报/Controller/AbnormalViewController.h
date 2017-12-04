//
//  AbnormalViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/4.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbnormalViewController : SkyerBaseViewController
@property (nonatomic,copy) NSString *OrderID;
@property (weak, nonatomic) IBOutlet UITextField *textFidld;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;

@end
