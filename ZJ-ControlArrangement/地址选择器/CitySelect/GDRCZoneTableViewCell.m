//
//  GDRCCityZoneTableViewCell.m
//  GDRCIphone
//
//  Created by laijun on 2019/1/3.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "GDRCZoneTableViewCell.h"

@implementation GDRCZoneTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
//    _highlightColor = [UIColor colorWithHexString:@"#F57A00"];
//    _titleColor = [UIColor colorWithHexString:@"#1A1A1A"];
//    _contentColor = [UIColor colorWithHexString:@"#949499"];
    
    _highlightColor = [UIColor orangeColor];
    _titleColor = [UIColor blackColor];
    _contentColor = [UIColor lightTextColor];
    
    _selectedIcon = [[UIImageView alloc] init];
    _selectedIcon.image = [UIImage imageNamed:@"fuGou"];
    _selectedIcon.hidden = YES;
    [self addSubview:_selectedIcon];
    [_selectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(16);
        make.centerY.offset(0);
        make.right.offset(-28.75);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = _titleColor;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.offset(20);
        make.right.mas_equalTo(_selectedIcon.mas_left).offset(-20);
        make.top.offset(12);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textColor = _contentColor;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(16.5);
        make.left.offset(20);
        make.right.mas_equalTo(_selectedIcon.mas_left).offset(-20);
        make.bottom.offset(-12);
    }];
}

- (void)bindData:(id)data{
    
    NSDictionary *dic = (NSDictionary *)data;
    
    NSString *selectedArea = dic[@"selectedZone"];
//    NSDictionary *cityDic = [dic objectForKey:@"sysRegionDto"];
    NSString *areaName = dic[@"name"];
    _titleLabel.text = areaName;
    
//    NSDictionary *zoneDic = [dic objectForKey:@"sysOrganizeDto"];
    if(dic && ![dic isKindOfClass:[NSNull class]]){
        NSString *organizeName = [dic objectForKey:@"value"];
        if(organizeName && ![@"" isEqualToString:organizeName]){
            _contentLabel.text = organizeName;
            _titleLabel.textColor = _titleColor;
            self.userInteractionEnabled = YES;
        }else{
            _titleLabel.textColor = _contentColor;
            _contentLabel.text = @"此地区暂未开设机构";
            self.userInteractionEnabled = NO;
        }
    }else{
        _titleLabel.textColor = _contentColor;
        _contentLabel.text = @"此地区暂未开设机构";
        self.userInteractionEnabled = NO;
    }
    
    //是否选择
    if(selectedArea && [selectedArea isEqualToString:areaName]){
        _selectedIcon.hidden = NO;
        _titleLabel.textColor = _highlightColor;
        _contentLabel.textColor = _highlightColor;
    }else{
        _selectedIcon.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation GDRCZoneTitleTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
//    _contentLabel.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
    _contentLabel.textColor = [UIColor lightTextColor];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.offset(20);
        make.right.offset(-20);
        make.centerY.offset(0);
    }];
}

- (void)bindData:(id)data{
    NSDictionary *dic = (NSDictionary *)data;
    _contentLabel.text = dic[@"name"];
}

@end
