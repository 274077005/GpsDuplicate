//
//  AbnormalViewController.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/4.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "AbnormalViewController.h"

@interface AbnormalViewController ()

@end

@implementation AbnormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"异常上报";
    self.view.backgroundColor=skLineColor;
    
    kWeakSelf(self)
    [[_btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (weakself.textFidld.text.length<200&&![weakself.textFidld.text isEqualToString:@""]) {
            [weakself UploadError];
        }
        
    }];
    [_btnSure skSetBoardRadius:3 Width:1 andBorderColor:[UIColor clearColor]];
    [_btnSure setBackgroundColor:skBaseColor];
    
    [[_textFidld rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        if (x.length>200) {
            
            [SkyerHUD skyerShowToast:@"文字不能超过200"];
            weakself.textFidld.text=[x substringToIndex:200];
            
        }
    }];
}

/**
 异常上报的接口
 */
-(void)UploadError{
    
    NSDictionary *parameters=@{@"No":@"UploadError",
                               @"UserID":UserLogin.sharedUserLogin.UserID,
                               @"OrderID":_OrderID,
                               @"Describe":_textFidld.text
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        
        [SkyerHUD skyerShowToast:@"异常已经提交"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
