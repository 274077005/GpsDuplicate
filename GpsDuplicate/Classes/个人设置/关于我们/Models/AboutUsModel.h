//
//  AboutUsModel.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/12/5.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutUsModel : NSObject
/*
 Address = "\U6df1\U5733\U5e02\U5357\U5c71\U533a\U9ad8\U65b0\U4e2d\U4e09\U90532\U53f7\U8f6f\U4ef6\U56ed\U4e00\U671f5\U680b5\U697c";
 Company = "\U6df1\U5733\U5e02\U822a\U901a\U5317\U6597\U4fe1\U606f\U6280\U672f\U6709\U9650\U516c\U53f8";
 Tel = "0755-86185110";
 Version = "V1.0";
 Website = "www.castelbds.com";
 */
@property (nonatomic,copy) NSString *Address;
@property (nonatomic,copy) NSString *Company;
@property (nonatomic,copy) NSString *Tel;
@property (nonatomic,copy) NSString *Version;
@property (nonatomic,copy) NSString *Website;
@end
