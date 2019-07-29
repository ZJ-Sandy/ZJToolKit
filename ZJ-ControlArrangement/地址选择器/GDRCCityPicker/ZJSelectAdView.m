//
//  HmSelectAdView.m
//  AiaiWang
//
//  Created by 赵海明 on 2018/3/28.
//  Copyright © 2018年 cnmobi. All rights reserved.
//

#import "ZJSelectAdView.h"
#import "ZJAddressModel.h"
#import "UIView+Extension.h"

#define PickerViewHeight 200
#define kTitleHeight 30
#define HEADVIEW_HEIGHT 40.f

@interface ZJSelectAdView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSArray *allDataArr;
@property (nonatomic, strong) NSMutableArray *provinceArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *areaArr;

@property (nonatomic, strong) NSString *currentSelectProvince;
@property (nonatomic, strong) NSString *currentSelectCity;
@property (nonatomic, strong) NSString *currentSelectArea;

@property (nonatomic, assign) NSInteger selectProvince;
@property (nonatomic, assign) NSInteger selectCity;
@property (nonatomic, assign) NSInteger selectArea;


@property (nonatomic, weak) UIButton *Selectbutton;
@property (nonatomic, strong) UIView   *btnBgView;
@property (nonatomic, strong) UIView   *headView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UILabel  *titleLab;
@property (nonatomic, strong) UIView   *upView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSData *data;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger selectProvincett;
@property (nonatomic, assign) NSInteger selectCitytt;
@property (nonatomic, assign) NSInteger selectAreatt;
@end

@implementation ZJSelectAdView

- (instancetype)initWithLastContent:(NSArray *)lastContent withData:(NSData *)data withTitle:(NSString *)title{
    if ([super init]) {
        self.frame = CGRectMake(0, 0, ZJ_SCREEN_WIDTH, ZJ_SCREEN_HEIGHT);
        //lastContent 为传入的下标，跳转指定城市
        if (lastContent && lastContent.count > 0) {
            NSString *str1 = lastContent.firstObject;
            self.selectProvincett = str1.integerValue;
    
            NSString *str2 = lastContent[1];
            self.selectCitytt = str2.integerValue;
    
            NSString *str3 = lastContent.lastObject;
            self.selectAreatt = str3.integerValue;
        }
        self.data = data;
        self.title = title;
        [self setupView];
        [self HmGetArea];
    }
    return self;
}


#pragma mark - ------- UIPickerView Delegate ------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArr.count;
    }else if (component == 1) {
        return self.cityArr.count;
    }else {
        return self.areaArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.provinceArr[row];
    }else if (component == 1) {
        return self.cityArr[row];
    }else {
        return self.areaArr[row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.currentSelectProvince = self.provinceArr[row];
        self.selectProvince = row;
        self.currentSelectCity = nil;
        self.currentSelectArea = nil;
        [self calculationCityAreaArr];
        [pickerView selectRow:[self.cityArr indexOfObject:self.currentSelectCity] inComponent:1 animated:YES];
        [pickerView selectRow:[self.areaArr indexOfObject:self.currentSelectArea] inComponent:2 animated:YES];
    } else if (component == 1) {
        self.currentSelectCity = self.cityArr[row];
        self.selectCity = row;

        self.currentSelectArea = nil;
        [self calculationCityAreaArr];
        [pickerView selectRow:[self.areaArr indexOfObject:self.currentSelectArea] inComponent:2 animated:YES];
    } else {
        self.currentSelectArea = self.areaArr[row];
        self.selectArea = row;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (!view) {
        view = [[UIView alloc] init];
    }
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZJ_SCREEN_WIDTH / 3, 44)];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont systemFontOfSize:15];
    lblTitle.textColor = [UIColor blackColor];
    if (component == 0) {
        lblTitle.text = self.provinceArr[row];
    }else if (component == 1) {
        lblTitle.text = self.cityArr[row];
    }else {
        lblTitle.text = self.areaArr[row];
    }
    [view addSubview:lblTitle];
    
    //设置分割线颜色
    UIView *lineViewOne = (UIView *)[pickerView.subviews objectAtIndex:1];
    UIView *lineViewTwo = (UIView *)[pickerView.subviews objectAtIndex:2];
    lineViewOne.backgroundColor = [UIColor lightGrayColor];
    lineViewTwo.backgroundColor = [UIColor lightGrayColor];
    return view;
}

#pragma mark - ----- setupView -----
- (void)setupView {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    self.btnBgView.frame = CGRectMake(0, size.height, size.width,PickerViewHeight + HEADVIEW_HEIGHT + ZJ_SCREEN_IPHONEX_BOTTOM);
    [self addSubview:self.btnBgView];
    
    self.upView.frame = CGRectMake(0, 0, ZJ_SCREEN_WIDTH, ZJ_SCREEN_HEIGHT-self.btnBgView.frame.size.height - ZJ_SCREEN_IPHONEX_BOTTOM);
    [self addSubview:self.upView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
    [self.upView addGestureRecognizer:tap];
    
    if (self.title && self.title.length > 0) {
        self.titleLab.text = self.title;
    }
    
    [self.headView addSubview:self.cancelButton];
    [self.headView addSubview:self.confirmButton];
    [self.headView addSubview:self.titleLab];
    [self.btnBgView addSubview:self.headView];
    [self.btnBgView addSubview:self.pickerView];

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self showSheet];
    
}
//确定
- (void)confirmButtonAction {
    
    if (self.confirmSelect) {
//        self.confirmSelect(@[@(self.selectProvince), @(self.selectCity), @(self.selectArea)]);
        
        self.confirmSelect(@[self.currentSelectProvince, self.currentSelectCity, self.currentSelectArea]);
    }
    [self hiddenSheet];
}
/// 解析地址
- (void)HmGetArea {
    [self removeAllObjectFromArea];
//    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aiai_area.txt" ofType:nil]];
    
    if (!self.data) {
        return;
    }
    NSArray *allArr = [ZJAddressModel arrayOfModelsFromData:self.data error:nil];
    self.allDataArr = [NSArray arrayWithArray:allArr];
    [self getCurrentSelectName];
    [self calculationCityAreaArr];
    [self.pickerView selectRow:[self.provinceArr indexOfObject:self.currentSelectProvince] inComponent:0 animated:YES];
    [self.pickerView selectRow:[self.cityArr indexOfObject:self.currentSelectCity] inComponent:1 animated:YES];
    [self.pickerView selectRow:[self.areaArr indexOfObject:self.currentSelectArea] inComponent:2 animated:YES];
}

/// 清空当前数据
- (void)removeAllObjectFromArea {
    [self.provinceArr removeAllObjects];
    [self.cityArr removeAllObjects];
    [self.areaArr removeAllObjects];
}


- (void)getCurrentSelectName{
    NSArray *allArray = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    
    if (allArray && allArray.count > 0) {
        NSDictionary *dict = allArray[self.selectProvincett];
        self.currentSelectProvince = dict[@"name"];
        NSArray *cityArray = dict[@"city"];
        
        NSDictionary *cityDict = cityArray[self.selectCitytt];
        self.currentSelectCity = cityDict[@"name"];
        NSArray *areaArray = cityDict[@"area"];
        
        self.currentSelectArea = areaArray[self.selectAreatt];
    }
    
}

/// 计算当前市区数组
- (void)calculationCityAreaArr {
    [self.provinceArr removeAllObjects];
    [self.cityArr removeAllObjects];
    [self.areaArr removeAllObjects];

    if (!self.currentSelectProvince) {
        self.currentSelectProvince = ((ZJAddressModel *)self.allDataArr[0]).name;
    }
    for (ZJAddressModel *model in self.allDataArr) {
        [self.provinceArr addObject:model.name];
        if ([self.currentSelectProvince isEqualToString:model.name]) {
            if (!self.currentSelectCity) {
                self.currentSelectCity = ((ZJAddressCityModel *)model.city[0]).name;
            }
            for (ZJAddressCityModel *mo in model.city) {
                [self.cityArr addObject:mo.name];
                if ([mo.name isEqualToString:self.currentSelectCity]) {
                    if (!self.currentSelectArea) {
                        self.currentSelectArea = mo.area.firstObject;
                    }
                    for (NSString *aa in mo.area) {
                        [self.areaArr addObject:aa];
                    }
                }
            }
        }
    }
    [self.pickerView reloadAllComponents];
}

- (void)showSheet{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.btnBgView.frame;
        frame.origin.y =  [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.btnBgView.frame = frame;
    }];
}

- (void)hiddenSheet {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.btnBgView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.btnBgView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - ---- lazy ----
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEADVIEW_HEIGHT, ZJ_SCREEN_WIDTH, PickerViewHeight)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

- (UIView *)btnBgView {
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc] init];
        _btnBgView.backgroundColor = [UIColor whiteColor];
    }
    return _btnBgView;
}

- (UIView *)upView {
    if (!_upView) {
        _upView = [[UIView alloc] init];
        _upView.backgroundColor = [UIColor clearColor];
    }
    return _upView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJ_SCREEN_WIDTH, HEADVIEW_HEIGHT)];
        _headView.backgroundColor = [UIColor lightGrayColor];
        _headView.layer.masksToBounds = YES;
        _headView.layer.borderWidth = 0.5;
        _headView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _headView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, ZJ_SCREEN_WIDTH-120, HEADVIEW_HEIGHT)];
        _titleLab.text = @"选择地址";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(16, 10, 44, 20)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_cancelButton addTarget:self action:@selector(hiddenSheet) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 56, 10, 40, 20)];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


#pragma mark -- Getter
- (NSMutableArray *)provinceArr {
    if (!_provinceArr) {
        _provinceArr = [NSMutableArray array];
    }
    return _provinceArr;
}

- (NSMutableArray *)cityArr {
    if (!_cityArr) {
        _cityArr = [NSMutableArray array];
    }
    return _cityArr;
}

- (NSMutableArray *)areaArr {
    if (!_areaArr) {
        _areaArr = [NSMutableArray array];
    }
    return _areaArr;
}
@end
