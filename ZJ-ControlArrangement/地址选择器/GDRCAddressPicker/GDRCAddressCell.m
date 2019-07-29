//
//  GDRCAddressCell.m
//  GDRCIphone
//
//  Created by laijun on 2019/3/14.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "GDRCAddressCell.h"

@implementation GDRCAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    _contentLb = [[UILabel alloc] init];
    _contentLb.font = [UIFont systemFontOfSize:13 * Screen_Ratio_Width];
    _contentLb.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
    _contentLb.highlightedTextColor = [UIColor colorWithHexString:@"#F28518"];
    [self addSubview:_contentLb];
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(22 * Screen_Ratio_Width);
        make.width.offset(screenWidth - (20 * 2 + 38) * Screen_Ratio_Width );
    }];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.highlightedImage = [UIImage imageNamed:@"gou"];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(19 * Screen_Ratio_Width);
        make.left.mas_equalTo(_contentLb.mas_right).offset(10 * Screen_Ratio_Width);
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
