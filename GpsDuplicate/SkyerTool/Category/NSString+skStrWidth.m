//
//  NSString+skStrWidth.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "NSString+skStrWidth.h"

@implementation NSString (skStrWidth)
-(CGSize)skTitleSize:(NSString *)text
            labWidth:(CGFloat)width
          fontOfSize:(CGFloat)size{
    
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
    
    return titleSize;
}
@end
