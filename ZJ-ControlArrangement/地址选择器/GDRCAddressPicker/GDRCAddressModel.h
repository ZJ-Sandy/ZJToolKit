//
//  GDRCAddressModel.h
//  GDRCIphone
//
//  Created by KSL on 2019/3/8.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDRCAddressModel : NSObject

@property(nonatomic,strong)NSString *i;//地区码
@property(nonatomic,strong)NSString *n;//地区名
@property(nonatomic,strong)NSString *p;//地区父级码

@end

NS_ASSUME_NONNULL_END
