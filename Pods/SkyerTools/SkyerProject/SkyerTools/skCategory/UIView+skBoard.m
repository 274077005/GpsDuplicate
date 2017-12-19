//
//  UIView+skBoard.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "UIView+skBoard.h"

@implementation UIView (skBoard)

-(void)skSetBoardRadius:(CGFloat)Radius Width:(CGFloat)Width andBorderColor:(UIColor *)borderColor{
    
    self.layer.cornerRadius=Radius;
    self.layer.masksToBounds=YES;
    self.layer.borderWidth=Width;
    self.layer.borderColor=[borderColor CGColor];
}

@end
