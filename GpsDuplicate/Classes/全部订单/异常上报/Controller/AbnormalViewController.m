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
    
    
    [[_btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (_textFidld.text.length<200) {
            [self UploadError];
        }
        
    }];
    
    [[_textFidld rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        if (x.length>200) {
            
            [SkToast SkToastShow:@"文字不能超过200" withHight:skScreenHeight/2];
            _textFidld.text=[x substringToIndex:200];
        }
    }];
}

/**
 异常上报的接口
 */
-(void)UploadError{
    
    NSDictionary *parameters=@{@"No":@"UploadError",
                               @"UserID":self.user.UserID,
                               @"OrderID":_OrderID,
                               @"Describe":_textFidld.text
                               };
    
    [[SKNetworking sharedSKNetworking] SKPOST:skURLString parameters:parameters showHUD:YES showErrMsg:YES success:^(id  _Nullable responseObject) {
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
