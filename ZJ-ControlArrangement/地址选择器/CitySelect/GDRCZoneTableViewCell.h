//
//  GDRCCityZoneTableViewCell.h
//  GDRCIphone
//
//  Created by laijun on 2019/1/3.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDRCZoneTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *selectedIcon;
@property (nonatomic, strong) UIColor  *highlightColor;
@property (nonatomic, strong) UIColor  *titleColor;
@property (nonatomic, strong) UIColor  *contentColor;

- (void)bindData:(id)data;

@end

@interface GDRCZoneTitleTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;

- (void)bindData:(id)data;

@end

NS_ASSUME_NONNULL_END
