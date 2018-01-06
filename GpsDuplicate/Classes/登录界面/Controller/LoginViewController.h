//
//  ViewController.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    skUserTypeDriver=1,
    skUserTypeManager0,
    skUserTypeManager1,
    skUserTypeManager2,
} skUserType;

@interface LoginViewController : SkyerBaseViewController

@property (weak, nonatomic) IBOutlet UIView *viewName;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnRemamber;

@property (weak, nonatomic) IBOutlet UIButton *btnRemamberTop;

@property (weak, nonatomic) IBOutlet UIButton *btnForget;


@end

