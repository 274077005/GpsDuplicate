//
//  BindingViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindingViewController : SkyerBaseViewController


@property (nonatomic,copy) void(^bindBlock)();

@property (weak, nonatomic) IBOutlet UITextField *textNum;
@property (weak, nonatomic) IBOutlet UIButton *btnBind;
@property (weak, nonatomic) IBOutlet UILabel *labLine;
@property (weak, nonatomic) IBOutlet UIView *viewBind;


@end
