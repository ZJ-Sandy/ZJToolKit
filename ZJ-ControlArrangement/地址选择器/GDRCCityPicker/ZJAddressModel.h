//
//  HmAddressModel.h
//  AiaiWang
//
//  Created by 赵海明 on 2018/3/27.
//  Copyright © 2018年 cnmobi. All rights reserved.
//

//#import <JSONModel/JSONModel.h>
#import "JSONModel.h"
#import "ZJAddressCityModel.h"

@interface ZJAddressModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSArray<ZJAddressCityModel, Optional> *city;

@end
