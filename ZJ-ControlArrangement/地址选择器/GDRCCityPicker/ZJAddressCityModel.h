//
//  HmAddressCityModel.h
//  AiaiWang
//
//  Created by 赵海明 on 2018/3/27.
//  Copyright © 2018年 cnmobi. All rights reserved.
//

//#import <JSONModel/JSONModel.h>
#import "JSONModel.h"
@protocol ZJAddressCityModel <NSObject>

@end

@interface ZJAddressCityModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSArray<Optional> *area;

@end
