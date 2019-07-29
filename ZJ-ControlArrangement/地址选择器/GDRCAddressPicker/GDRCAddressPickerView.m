//
//  GDRCAddressPickerView.m
//  GDRCIphone
//
//  Created by KSL on 2019/3/8.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "GDRCAddressPickerView.h"
#import "GDRCAddressModel.h"
#import "GDRCAddressCell.h"

#define BTNFONTSIZE ( 13 * Screen_Ratio_Width)
#define TAB_TEXT_HEIGHT (18.5 * Screen_Ratio_Width)
#define TABLEVIEW_HEIGHT (300 * Screen_Ratio_Width)

@interface GDRCAddressPickerView ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *addressbaseView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) NSMutableArray *tabArrM;
@property (nonatomic, strong) UILabel *provinceTab;
@property (nonatomic, strong) UILabel *cityTab;
@property (nonatomic, strong) UILabel *districtTab;
@property (nonatomic, strong) UILabel *subdistrictTab;
@property (nonatomic, strong) UILabel *neighborhoodTab;
@property (nonatomic, strong) UIView *tabLineView;

@property (nonatomic, strong) NSMutableArray *tableViewsArrM;
@property (nonatomic, strong) UITableView *provinceTableView;
@property (nonatomic, strong) UITableView *cityTableView;
@property (nonatomic, strong) UITableView *districtTableView;
@property (nonatomic, strong) UITableView *subdistrictTableView;
@property (nonatomic, strong) UITableView *neighborhoodTableView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, copy) NSString *provinceString;
@property (nonatomic, copy) NSString *cityString;
@property (nonatomic, copy) NSString *districtString;
@property (nonatomic, copy) NSString *subdistrictString;
@property (nonatomic, copy) NSString *neighborhoodString;

@property (nonatomic, copy) NSString *provinceCode;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *districtCode;
@property (nonatomic, copy) NSString *subdistrictCode;
@property (nonatomic, copy) NSString *neighborhoodCode;

@property (nonatomic, strong) NSDictionary *addressDataDict;

@property (nonatomic, strong) NSMutableArray *provinceDataArrM;
@property (nonatomic, strong) NSMutableArray *cityDataArrM;
@property (nonatomic, strong) NSMutableArray *districtDataArrM;
@property (nonatomic, strong) NSMutableArray *subdistrictDataArrM;
@property (nonatomic, strong) NSMutableArray *neighborhoodDataArrM;

@property (nonatomic, assign) NSInteger willSelectIndex;
@property (nonatomic, assign) CGFloat choiceTextWidth;

@end

@implementation GDRCAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self initUI];
        [self getPlist];
    }
    return self;
}

#pragma mark - delegate
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger indexOfTab = scrollView.contentOffset.x / screenWidth;
    UILabel *tab = [self.tabArrM objectAtIndex:indexOfTab];
    [self changeTabLabelStyle:tab];
    self.tabLineView.centerX = tab.centerX; //移动页面tab标记
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.provinceTableView) {
        
        return self.provinceDataArrM.count;
        
    } else if (tableView == self.cityTableView) {
        
        return self.cityDataArrM.count;
        
    } else if (tableView == self.districtTableView) {
        
        return self.districtDataArrM.count;
        
    } else if (tableView == self.subdistrictTableView) {
        
        return self.subdistrictDataArrM.count;
        
    } else if (tableView == self.neighborhoodTableView) {
        
        return self.neighborhoodDataArrM.count;
        
    } else {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GDRCAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    if (!cell) {
        cell = [[GDRCAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressCell"];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    }
    
    if (tableView == self.provinceTableView) {
        
        GDRCAddressModel *model = self.provinceDataArrM[indexPath.row];
        cell.contentLb.text = model.n;
        
    } else if (tableView == self.cityTableView) {
        
        GDRCAddressModel *model = self.cityDataArrM[indexPath.row];
        cell.contentLb.text = model.n;
        
    } else if (tableView == self.districtTableView) {
        
        GDRCAddressModel *model = self.districtDataArrM[indexPath.row];
        cell.contentLb.text = model.n;
        
    } else if (tableView == self.subdistrictTableView) {
        
        GDRCAddressModel *model = self.subdistrictDataArrM[indexPath.row];
        cell.contentLb.text = model.n;
        
    } else if (tableView == self.neighborhoodTableView) {
        
        GDRCAddressModel *model = self.neighborhoodDataArrM[indexPath.row];
        cell.contentLb.text = model.n;
        
    } else {
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44 * Screen_Ratio_Width;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger tag = tableView.tag - 200;
    
    switch (tag) {
        case 0: {
            
            GDRCAddressModel *model = self.provinceDataArrM[indexPath.row];
            
            CGRect tmpFrame = self.provinceTab.frame;
            
            self.provinceTab.text = model.n;
            self.cityTab.text = @"请选择";
            self.districtTab.text = @"";
            self.subdistrictTab.text = @"";
            self.neighborhoodTab.text = @"";
            
            [self changeTabLabelStyle:self.cityTab];
            //计算文字长度
            CGFloat provinceTabWidth = [self getLabelWidth:model.n font:BTNFONTSIZE height:TAB_TEXT_HEIGHT];
            self.provinceTab.frame = CGRectMake(20 * Screen_Ratio_Width, (45.5-18.5) * Screen_Ratio_Width/2.0, provinceTabWidth, TAB_TEXT_HEIGHT);
            
            self.cityTab.frame = CGRectMake(10 * Screen_Ratio_Width + CGRectGetMaxX(self.provinceTab.frame), tmpFrame.origin.y, self.choiceTextWidth, tmpFrame.size.height);
            
            self.tabLineView.centerX = self.cityTab.centerX; //移动页面tab标记
            
            [self willSelectIndex:1 addressString:model.n addressCode:model.i];
            
        }
            break;
        case 1: {
            
            GDRCAddressModel *model = self.cityDataArrM[indexPath.row];
            CGRect tmpFrame = self.cityTab.frame;
            
            self.cityTab.text = model.n;
            self.districtTab.text = @"请选择";
            self.subdistrictTab.text = @"";
            self.neighborhoodTab.text = @"";
            
            [self changeTabLabelStyle:self.districtTab];
            
            CGFloat cityTabWidth = [self getLabelWidth:model.n font:BTNFONTSIZE height:TAB_TEXT_HEIGHT];
            self.cityTab.frame = CGRectMake(tmpFrame.origin.x, (45.5-18.5) * Screen_Ratio_Width/2.0, cityTabWidth, TAB_TEXT_HEIGHT);
            self.districtTab.frame = CGRectMake(10 * Screen_Ratio_Width + CGRectGetMaxX(self.cityTab.frame), tmpFrame.origin.y, self.choiceTextWidth, tmpFrame.size.height);
            
            self.tabLineView.centerX = self.districtTab.centerX; //移动页面tab标记
            
            [self willSelectIndex:2 addressString:model.n addressCode:model.i];
            
        }
            break;
        case 2: {
            
            GDRCAddressModel *model = self.districtDataArrM[indexPath.row];
            
            CGRect tmpFrame = self.districtTab.frame;
            
            self.districtTab.text = model.n;
            self.subdistrictTab.text = @"请选择";
            self.neighborhoodTab.text = @"";
            
            [self changeTabLabelStyle:self.subdistrictTab];
            
            CGFloat districtTabWidth = [self getLabelWidth:model.n font:BTNFONTSIZE height:TAB_TEXT_HEIGHT];
            self.districtTab.frame = CGRectMake(tmpFrame.origin.x, (45.5-18.5) * Screen_Ratio_Width/2.0, districtTabWidth, TAB_TEXT_HEIGHT);
            self.subdistrictTab.frame = CGRectMake(10 * Screen_Ratio_Width + CGRectGetMaxX(self.districtTab.frame), tmpFrame.origin.y, self.choiceTextWidth, tmpFrame.size.height);
            
            self.tabLineView.centerX = self.subdistrictTab.centerX; //移动页面tab标记
            
            [self willSelectIndex:3 addressString:model.n addressCode:model.i];
            
        }
            break;
        case 3: {
            
            GDRCAddressModel *model = self.subdistrictDataArrM[indexPath.row];
            
            CGRect tmpFrame = self.subdistrictTab.frame;
            
            self.subdistrictTab.text = model.n;
            self.neighborhoodTab.text = @"请选择";
            
            [self changeTabLabelStyle:self.neighborhoodTab];
            
            CGFloat subdistrictTabWidth = [self getLabelWidth:model.n font:BTNFONTSIZE height:TAB_TEXT_HEIGHT];
            self.subdistrictTab.frame = CGRectMake(tmpFrame.origin.x, (45.5-18.5) * Screen_Ratio_Width/2.0, subdistrictTabWidth, TAB_TEXT_HEIGHT);
            self.neighborhoodTab.frame = CGRectMake(10 * Screen_Ratio_Width + CGRectGetMaxX(self.subdistrictTab.frame), tmpFrame.origin.y, self.choiceTextWidth, tmpFrame.size.height);
            
            self.tabLineView.centerX = self.neighborhoodTab.centerX; //移动页面tab标记
            
            [self willSelectIndex:4 addressString:model.n addressCode:model.i];
            
        }
            break;
        case 4: {
            
            GDRCAddressModel *model = self.neighborhoodDataArrM[indexPath.row];
            
            [self willSelectIndex:5 addressString:model.n addressCode:model.i];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)changeTabLabelStyle:(UILabel *)lb{
    for (UILabel *temp in self.tabArrM) {
        if(temp == lb){
            temp.highlighted = YES;
        }else{
            temp.highlighted = NO;
        }
    }
}

#pragma mark - private methods
- (void)addressTabAction:(UITapGestureRecognizer *)recognizer {
    
    UILabel *tabLabel = (UILabel *)recognizer.view;
    
    [self changeTabLabelStyle:tabLabel];
    
    self.tabLineView.centerX = tabLabel.centerX; //移动页面tab标记
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(screenWidth * (tabLabel.tag - 100), 0);
    }];
    
}

- (void)tapHidenGes {
    [self hidenAreaView];
}

- (void)showAreaView {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.alpha = 0.6;
        CGRect viewFrame = self.addressbaseView.frame;
        viewFrame.origin.y = screenHeight - (415.5+ (iPhoneX ? 34:0)) * Screen_Ratio_Width;
        self.addressbaseView.frame = viewFrame;
    }];
    
}

- (void)hidenAreaView {
    
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] init];
    
    if (
        [NSString checkString:self.provinceString] &&
        [NSString checkString:self.cityString] &&
        [NSString checkString:self.districtString] &&
        [NSString checkString:self.subdistrictString] &&
        [NSString checkString:self.neighborhoodString] &&
        
        [NSString checkString:self.provinceCode] &&
        [NSString checkString:self.cityCode] &&
        [NSString checkString:self.districtCode] &&
        [NSString checkString:self.subdistrictCode] &&
        [NSString checkString:self.neighborhoodCode]
        ) {
        
        [dictM setObject:self.provinceString forKey:@"province"];
        [dictM setObject:self.provinceCode forKey:@"provinceCode"];
        
        [dictM setObject:self.cityString forKey:@"city"];
        [dictM setObject:self.cityCode forKey:@"cityCode"];
        
        [dictM setObject:self.districtString forKey:@"district"];
        [dictM setObject:self.districtCode forKey:@"districtCode"];
        
        [dictM setObject:self.subdistrictString forKey:@"subdistrict"];
        [dictM setObject:self.subdistrictCode forKey:@"subdistrictCode"];
        
        [dictM setObject:self.neighborhoodString forKey:@"neighborhood"];
        [dictM setObject:self.neighborhoodCode forKey:@"neighborhoodCode"];
        
        self.callBack(dictM.copy);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.alpha = 0;
        CGRect viewFrame = self.addressbaseView.frame;
        viewFrame.origin.y = screenHeight;
        self.addressbaseView.frame = viewFrame;
    } completion:^(BOOL finished) {
        
        if (finished) {
            [self removeFromSuperview];
        }
        
    }];
    
}

- (void)willSelectIndex:(NSInteger)index addressString:(NSString *)addressString addressCode:(NSString *)addressCode {
    
    self.willSelectIndex = index;
    switch (self.willSelectIndex) {
        case 0:
            self.provinceString = addressString;
            self.provinceCode = addressCode;
            self.cityString = @"";
            self.cityCode = @"";
            self.districtString = @"";
            self.districtCode = @"";
            self.subdistrictString = @"";
            self.subdistrictCode = @"";
            self.neighborhoodString = @"";
            self.neighborhoodCode = @"";
            [self.cityDataArrM removeAllObjects];
            break;
            
        case 1:
            self.provinceString = addressString;
            self.provinceCode = addressCode;
            self.cityString = @"";
            self.cityCode = @"";
            self.districtString = @"";
            self.districtCode = @"";
            self.subdistrictString = @"";
            self.subdistrictCode = @"";
            self.neighborhoodString = @"";
            self.neighborhoodCode = @"";
            [self.cityDataArrM removeAllObjects];
            break;
            
        case 2:
            self.cityString = addressString;
            self.cityCode = addressCode;
            self.districtString = @"";
            self.districtCode = @"";
            self.subdistrictString = @"";
            self.subdistrictCode = @"";
            self.neighborhoodString = @"";
            self.neighborhoodCode = @"";
            [self.districtDataArrM removeAllObjects];
            break;
            
        case 3:
            self.districtString = addressString;
            self.districtCode = addressCode;
            self.subdistrictString = @"";
            self.subdistrictCode = @"";
            self.neighborhoodString = @"";
            self.neighborhoodCode = @"";
            [self.subdistrictDataArrM removeAllObjects];
            break;
            
        case 4:
            self.subdistrictString = addressString;
            self.subdistrictCode = addressCode;
            self.neighborhoodString = @"";
            self.neighborhoodCode = @"";
            [self.neighborhoodDataArrM removeAllObjects];

            break;
            
        case 5:
            self.neighborhoodString = addressString;
            self.neighborhoodCode = addressCode;
            
            break;
            
        default:
            
            break;
    }

    if (self.willSelectIndex == 5) {
        [self hidenAreaView];
    } else {
        [self getPlist];
    }
}

- (void)getPlist {
    
    if (!self.addressDataDict) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"plist"];
        NSMutableDictionary *plistDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        
        _addressDataDict = [NSDictionary dictionaryWithDictionary:plistDic];
    }
    
    NSString *keyString = @"";
    
    switch (self.willSelectIndex) {
        case 0:
            keyString = @"province";
            break;
        case 1:
            keyString = @"city";
            break;
        case 2:
            keyString = @"district";
            break;
        case 3:
            keyString = @"subdistrict";
            break;
        case 4:
            keyString = @"neighborhood";
            break;
        default:
            
            break;
    }
    
    NSArray *arr = [self.addressDataDict objectForKey:keyString];
    
    for (NSDictionary *dict in arr) {
        
        GDRCAddressModel *model = [[GDRCAddressModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        
        switch (self.willSelectIndex) {
            case 0:
                [self.provinceDataArrM addObject:model];
                break;
            case 1:
                if ([model.p isEqualToString:self.provinceCode]) {
                    [self.cityDataArrM addObject:model];
                    break;
                }
                
            case 2:
                if ([model.p isEqualToString:self.cityCode]) {
                    [self.districtDataArrM addObject:model];
                    break;
                }
                
            case 3:
                if ([model.p isEqualToString:self.districtCode]) {
                    [self.subdistrictDataArrM addObject:model];
                }
                
                break;
            case 4:
                if ([model.p isEqualToString:self.subdistrictCode]) {
                    [self.neighborhoodDataArrM addObject:model];
                }
                
                break;
            default:
                break;
        }
        
    }
    
    if (self.willSelectIndex == 0) {
        
        [self showAreaView];
        [self.provinceTableView reloadData];
        
    } else if (self.willSelectIndex == 1) {
        
        [self.cityTableView reloadData];
        self.scrollView.contentSize = CGSizeMake(screenWidth * 2, TABLEVIEW_HEIGHT);
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(screenWidth, 0);
        }];
        
    } else if (self.willSelectIndex == 2) {
        
        [self.districtTableView reloadData];
        self.scrollView.contentSize = CGSizeMake(screenWidth * 3, TABLEVIEW_HEIGHT);
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(screenWidth * 2, 0);
        }];
        
    } else if (self.willSelectIndex == 3) {
        
        [self.subdistrictTableView reloadData];
        self.scrollView.contentSize = CGSizeMake(screenWidth * 4, TABLEVIEW_HEIGHT);
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(screenWidth * 3, 0);
        }];
        
    } else if (self.willSelectIndex == 4) {
        
        [self.neighborhoodTableView reloadData];
        self.scrollView.contentSize = CGSizeMake(screenWidth * 5, TABLEVIEW_HEIGHT);
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(screenWidth * 4, 0);
        }];
        
    }

    NSLog(@"%s", __FUNCTION__);
}

- (NSString *)patchAddressWithString:(NSString *)string {
    
    if ([NSString checkString:string] || [string isEqualToString:@"请选择"]) {
        return @" ";
    }
    
    return string;
}

-(CGFloat)getLabelWidth:(NSString *)textStr font:(CGFloat)fontSize height:(CGFloat)labelHeight {
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [textStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, labelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size.width;
}

#pragma mark - init UI
- (void)initUI {
    
    [self addSubview:self.backView];
    
    self.addressbaseView.frame = CGRectMake(0, screenHeight, screenWidth, (415.5+ (iPhoneX ? 34:0)) * Screen_Ratio_Width);
    [self addSubview:self.addressbaseView];
    
    self.titleLabel.frame = CGRectMake(0, 0, screenWidth, 50 * Screen_Ratio_Width);
    [self.addressbaseView addSubview:self.titleLabel];
    
    [self.addressbaseView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(5 * Screen_Ratio_Width, (50 - 40) * Screen_Ratio_Width / 2.0, 56 * Screen_Ratio_Width, 40 * Screen_Ratio_Width);
    
    [self.tabArrM addObject:self.provinceTab];
    [self.tabArrM addObject:self.cityTab];
    [self.tabArrM addObject:self.districtTab];
    [self.tabArrM addObject:self.subdistrictTab];
    [self.tabArrM addObject:self.neighborhoodTab];
    
    [self.tableViewsArrM addObject:self.provinceTableView];
    [self.tableViewsArrM addObject:self.cityTableView];
    [self.tableViewsArrM addObject:self.districtTableView];
    [self.tableViewsArrM addObject:self.subdistrictTableView];
    [self.tableViewsArrM addObject:self.neighborhoodTableView];
    
    //页签布局视图
    UIView *pageBg = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), screenWidth, 45.5 * Screen_Ratio_Width)];
    [self.addressbaseView addSubview:pageBg];
    //分割线
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, 45.5 * Screen_Ratio_Width -1 , screenWidth, 1)];
    horizontalLine.backgroundColor = [UIColor colorWithHexString:@"#B2B2C2"];
    [pageBg addSubview:horizontalLine];
    
    for (int i = 0; i < 5; ++i) {
        
        UILabel *titleLb = self.tabArrM[i];
        titleLb.font = [UIFont systemFontOfSize:BTNFONTSIZE];
        titleLb.tag = 100 + i;
        titleLb.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
        titleLb.highlightedTextColor = [UIColor colorWithHexString:@"#F57A00"];
        titleLb.userInteractionEnabled = YES;
        //点击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTabAction:)];
        [titleLb addGestureRecognizer:tapGesture];
        
        if (i == 0) {
            titleLb.text = @"请选择";
            titleLb.highlighted = YES;
            titleLb.font = [UIFont systemFontOfSize:BTNFONTSIZE];
            CGFloat width = [self getLabelWidth:titleLb.text font:BTNFONTSIZE height:TAB_TEXT_HEIGHT];
            titleLb.frame = CGRectMake(20 * Screen_Ratio_Width, (45.5 - 18.5) * Screen_Ratio_Width / 2.0, width, 18.5 * Screen_Ratio_Width);
            self.choiceTextWidth = width;
        }
        
        [pageBg addSubview:titleLb];
    }
   
    //页签指示线
    [pageBg addSubview:self.tabLineView];
    [self.tabLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(2);
        make.width.offset(52.5 * Screen_Ratio_Width);
        make.bottom.mas_equalTo(horizontalLine);
        make.centerX.mas_equalTo(self.provinceTab);
    }];
    
    [self.addressbaseView addSubview:self.scrollView];
    
    for (int i = 0; i < 5; ++i) {
        
        UITableView *tableView = self.tableViewsArrM[i];
        tableView.frame = CGRectMake(screenWidth * i, 9.5 * Screen_Ratio_Width, screenWidth, TABLEVIEW_HEIGHT);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 200 + i;
        
        [self.scrollView addSubview:tableView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHidenGes)];
    [self.backView addGestureRecognizer:tap];
    
}

#pragma mark - getter & setter
- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.4;
    }
    return _backView;
}

- (UIView *)addressbaseView {
    if (_addressbaseView == nil) {
        _addressbaseView = [[UIView alloc] init];
        _addressbaseView.backgroundColor = [UIColor whiteColor];
    }
    return _addressbaseView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"所在地";
        _titleLabel.font = [UIFont systemFontOfSize:16 * Screen_Ratio_Width];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn{
    if(_cancelBtn == nil){
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 * Screen_Ratio_Width];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#949499"] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(tapHidenGes) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (NSMutableArray *)tabArrM {
    if (_tabArrM == nil) {
        _tabArrM = [[NSMutableArray alloc] init];
    }
    return _tabArrM;
}

- (UILabel *)provinceTab {
    if (_provinceTab == nil) {
        _provinceTab = [[UILabel alloc] init];
        _provinceTab.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
        _provinceTab.highlightedTextColor = [UIColor colorWithHexString:@"#F57A00"];
    }
    return _provinceTab;
}

- (UILabel *)cityTab {
    if (_cityTab == nil) {
        _cityTab = [[UILabel alloc] init];
    }
    return _cityTab;
}

- (UILabel *)districtTab {
    if (_districtTab == nil) {
        _districtTab = [[UILabel alloc] init];
    }
    return _districtTab;
}

- (UILabel *)subdistrictTab {
    if (_subdistrictTab == nil) {
        _subdistrictTab = [[UILabel alloc] init];
    }
    return _subdistrictTab;
}

- (UILabel *)neighborhoodTab {
    if (_neighborhoodTab == nil) {
        _neighborhoodTab = [[UILabel alloc] init];
    }
    return _neighborhoodTab;
}

- (UIView *)tabLineView{
    if(_tabLineView == nil){
        _tabLineView = [[UIView alloc] init];
        _tabLineView.backgroundColor = [UIColor colorWithHexString:@"#F57A00"];
    }
    return _tabLineView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 95.5 * Screen_Ratio_Width, screenWidth, 319 * Screen_Ratio_Width + (iPhoneX ? 34:0))];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(screenWidth, 319 * Screen_Ratio_Width + (iPhoneX ? 34:0));
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (NSMutableArray *)tableViewsArrM {
    if (_tableViewsArrM == nil) {
        _tableViewsArrM = [[NSMutableArray alloc] init];
    }
    return _tableViewsArrM;
}

- (UITableView *)provinceTableView {
    if (_provinceTableView == nil) {
        _provinceTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _provinceTableView;
}

- (UITableView *)cityTableView {
    if (_cityTableView == nil) {
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _cityTableView;
}

- (UITableView *)districtTableView {
    if (_districtTableView == nil) {
        _districtTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _districtTableView;
}

- (UITableView *)subdistrictTableView {
    if (_subdistrictTableView == nil) {
        _subdistrictTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _subdistrictTableView;
}

- (UITableView *)neighborhoodTableView {
    if (_neighborhoodTableView == nil) {
        _neighborhoodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _neighborhoodTableView;
}

- (NSMutableArray *)provinceDataArrM {
    if (_provinceDataArrM == nil) {
        _provinceDataArrM = [[NSMutableArray alloc] init];
    }
    return _provinceDataArrM;
}

- (NSMutableArray *)cityDataArrM {
    if (_cityDataArrM == nil) {
        _cityDataArrM = [[NSMutableArray alloc] init];
    }
    return _cityDataArrM;
}

- (NSMutableArray *)districtDataArrM {
    if (_districtDataArrM == nil) {
        _districtDataArrM = [[NSMutableArray alloc] init];
    }
    return _districtDataArrM;
}

- (NSMutableArray *)subdistrictDataArrM {
    if (_subdistrictDataArrM == nil) {
        _subdistrictDataArrM = [[NSMutableArray alloc] init];
    }
    return _subdistrictDataArrM;
}

- (NSMutableArray *)neighborhoodDataArrM {
    if (_neighborhoodDataArrM == nil) {
        _neighborhoodDataArrM = [[NSMutableArray alloc] init];
    }
    return _neighborhoodDataArrM;
}

@end
