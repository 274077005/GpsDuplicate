//
//  ResetPasswordViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/5.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "SkyerBaseViewController.h"

@interface ResetPasswordViewController : SkyerBaseViewController

typedef enum : NSUInteger {
    skTypeUnlogin=0,
    skTypeLogin,
} skChangPasswordType;

@property (nonatomic,assign) skChangPasswordType type;//修改类型0是
@property (nonatomic,copy)  NSString *Tel;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UITextField *textPasswordAgain;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;

@end
