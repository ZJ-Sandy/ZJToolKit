//
//  GDRCCityTableViewCell.m
//  GDRCIphone
//
//  Created by laijun on 2019/1/3.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "GDRCCityTableViewCell.h"

@implementation GDRCCityTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15 ];
//    _contentLabel.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(42);
        make.left.right.offset(6);
        make.centerY.offset(0);
    }];
    
    _bottomLine = [[UIView alloc] init];
//    _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    _bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_bottomLine];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.offset(1);
        make.left.right.offset(0);
    }];
    
    _leftBar = [[UIView alloc] init];
    _leftBar.hidden = YES;
//    _leftBar.backgroundColor = [UIColor colorWithHexString:@"#F57A00"];
    _leftBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:_leftBar];
    [_leftBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(5);
        make.height.offset(16);
        make.centerY.offset(0);
    }];
    
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
